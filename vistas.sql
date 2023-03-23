CREATE OR REPLACE VIEW my_albums as 
    SELECT
        albums.title as album,
        sum(tracks.duration) as duracion

    FROM (
        albums
        INNER JOIN
        tracks

        ON tracks.pair = albums.pair
    )
    WHERE albums.performer = melopack.get_ia()
    GROUP BY albums.title, albums.pair
WITH READ ONLY;

CREATE OR REPLACE VIEW events as 
    WITH 
    n_interpretacion as (
        SELECT 
            TO_CHAR(when, 'MM-YYYY') as fecha,
            count(*) as total_interpretacion,
            avg(duration) as m_duration
        FROM performances
        WHERE performances.performer = melopack.get_ia()
        GROUP BY TO_CHAR(when, 'MM-YYYY')
    ),
    n_conciertos as (
        SELECT 
            TO_CHAR(when, 'MM-YYYY') as fecha,
            count(*) as total_conciertos
        FROM concerts
        WHERE concerts.performer = melopack.get_ia()
        GROUP BY TO_CHAR(when, 'MM-YYYY')
    ),
    n_espectadores as (
        SELECT 
            TO_CHAR(when, 'MM-YYYY') as fecha,
            count(*) as total_espectadores
        FROM attendances
        WHERE attendances.performer = melopack.get_ia()
        GROUP BY TO_CHAR(when, 'MM-YYYY')
    ),
    FINAL as (
        SELECT 
            n_conciertos.fecha as fecha,
            n_conciertos.total_conciertos as n_conciertos,
            n_espectadores.total_espectadores as n_espectadores,
            round(n_interpretacion.m_duration, 2) as media_duracion,
            round(n_interpretacion.total_interpretacion/n_conciertos.total_conciertos, 2) as media_interpretaciones
        FROM (
            
            n_conciertos
            INNER JOIN
            n_espectadores
            ON n_conciertos.fecha = n_espectadores.fecha
            

            INNER JOIN 
            n_interpretacion
            ON 
                n_interpretacion.fecha = n_conciertos.fecha
        )
    )
    SELECT * FROM FINAL

WITH READ ONLY;

CREATE TABLE Banned (
    client VARCHAR2(100),
    performer VARCHAR2(100),
    ban NUMBER(1) DEFAULT 0,

    CONSTRAINT pk_banned
        PRIMARY KEY (client, performer),
    CONSTRAINT fk_banned_cliente
        FOREIGN KEY (client)
        REFERENCES clients(e_mail)
        ON DELETE CASCADE,
    CONSTRAINT fk_banned_performer
        FOREIGN KEY (performer)
        REFERENCES performers(name)
        ON DELETE CASCADE
    );

INSERT INTO Banned 
    (client, performer)
    SELECT DISTINCT
        client,
        performer
    FROM attendances;

CREATE OR REPLACE VIEW fans AS
    WITH interprete_valido as (
        SELECT 
            performer as p
        FROM concerts
        WHERE performer = melopack.get_ia()
        GROUP BY performer
        HAVING count(*) > 1
    ),
    FINAL as (
        SELECT DISTINCT
            clients.e_mail as email,
            clients.name as nombre,
            clients.surn1 as apellido1,
            clients.surn2 as apellido2,
            trunc((SYSDATE - clients.birthdate)/365, 0) as edad
        FROM (
            clients
            INNER JOIN
            banned
            ON banned.client = clients.e_mail
        )
        WHERE banned.ban = 0
    )
    SELECT * FROM FINAL
WITH CHECK OPTION;

CREATE OR REPLACE TRIGGER modificaciones_fans
INSTEAD OF UPDATE ON fans
BEGIN
    raise_application_error(-20111, "No se puede modificar view * fans *");
END;

CREATE OR REPLACE TRIGGER insertar_fans
INSTEAD OF INSERT ON fans
FOR EACH ROW
DECLARE
    cuenta NUMBER(3);
    temp_concierto DATE;
    ultimo_concierto DATE;
    penultimo_concierto DATE;

BEGIN
    
    SELECT count(*)
        INTO cuenta
    FROM concerts
    WHERE performer = melopack.get_ia()
    GROUP BY performer

    -- Si no se ha asignado o si no tiene dos conciertos
    IF melopack.get_ia() is not NULL OR cuenta < 1
        SELECT count(*)
            INTO cuenta
            FROM cliente
            GROUP BY e_mail
        WHERE e_mail = NEW.e_mail;

        -- Si el cliente no existe, lo creamos
        IF cuenta = 0 THEN
            INSERT INTO clients
                (e_mail, name, surn1, surn2, birthdate, phone, address, dni)
                VALUES
                    (NEW.e_mail, NEW.name, NEW.surn1, NEW.surn2, NEW.birthdate, NEW.phone, NEW.address, NEW.dni);
        END IF;

        -- Calcular # de asistencias
        SELECT count(*)
            INTO cuenta
            FROM attendances
            GROUP BY client, performer
        WHERE client = NEW.e_mail AND performer = melopack.get_ia();

        -- fecha( ULTimo concierto )
        SELECT max(when)
            INTO ultimo_concierto
            FROM concerts
            GROUP BY performer
        WHERE performer = melopack.get_ia();

        -- fecha( PENultimo concierto )
        SELECT when
            INTO penultimo_concierto
        FROM (
            SELECT when, rownum as rn
            FROM concerts 
            WHERE performer = melopack.get_ia()
            ORDER BY TO_NUMBER(TO_CHAR(when, 'J'))
        ) WHERE rn = 2

        -- Si no ha ido a ningun concierto del interprete actual
        IF cuenta = 0 THEN
            -- insertar fichas del fan para el ultimo y penultimo concierto
            -- cuidado con que sean menores de edad
            INSERT INTO attendances
                (client, performer, when, rfid, birthdate, purchase)
                VALUES
                    (NEW.e_mail, melopack.get_ia(), ultimo_concierto, 'RFID-INVENTADO-ULTIMO-CONCIERTO-3.141592653589793', NEW.birthdate, SYSDATE),
                    (NEW.e_mail, melopack.get_ia(), penultimo_concierto, 'RFID-INVENTADO-PENULTIMO-CONCIERTO-3.141592653589793', NEW.birthdate, SYSDATE);
            
            -- crear tupla de banned
            INSERT INTO banned
                (client, performer)
                VALUES
                    (NEW.e_mail, melopack.get_ia());
            
        -- Si solo ha ido a un concierto
        ELIF cuenta = 1 THEN
            -- ver si el concierto que tiene es el ultimo
            SELECT when
                INTO temp_concierto
                FROM attendances
                GROUP BY client, performer
            WHERE client = NEW.e_mail AND performer = melopack.get_ia();

            IF temp_concierto = ultimo_concierto THEN
                -- si el único concierto al que ha ido es el ultimo, insertamos el PENultimo
                INSERT INTO attendances
                (client, performer, when, rfid, birthdate, purchase)
                VALUES
                    (NEW.e_mail, melopack.get_ia(), penultimo_concierto, 'RFID-INVENTADO-PENULTIMO-CONCIERTO-3.141592653589793', NEW.birthdate, SYSDATE);
            ELSE
                -- si no insertamos el ultimo
                INSERT INTO attendances
                (client, performer, when, rfid, birthdate, purchase)
                VALUES
                    (NEW.e_mail, melopack.get_ia(), ultimo_concierto, 'RFID-INVENTADO-ULTIMO-CONCIERTO-3.141592653589793', NEW.birthdate, SYSDATE);
            END IF;

            -- vetado a Falso
            UPDATE TABLE banned SET ban = 0 WHERE client = NEW.e_mail AND performer = melopack.get_ia()
        
        -- si ha ido a más de un concierto
        ELSE
            -- vetado a Falso
            UPDATE TABLE banned 
                SET ban = 0 
                WHERE 
                    client = NEW.e_mail AND 
                    performer = melopack.get_ia()
        END IF;
    END IF;

END;

CREATE OR REPLACE TRIGGER borrar_fans
INSTEAD OF INSERT ON fans
FOR EACH ROW
BEGIN
    UPDATE TABLE banned 
        SET ban = 1
        WHERE 
            client = NEW.e_mail AND 
            performer = melopack.get_ia()
END;



