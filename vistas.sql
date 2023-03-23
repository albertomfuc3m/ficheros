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

DROP TABLE BANNED;
CREATE TABLE Banned (
    client VARCHAR2(100),
    performer VARCHAR2(100),
    ban NUMBER(1) DEFAULT 0,

    CONSTRAINT pk_banned
        PRIMARY KEY (client, performer),
    CONSTRAINT fk_banned_cliente
        FOREIGN KEY (client)
        REFERENCES clients(email)
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
            clients.email as email,
            clients.name as nombre,
            clients.surn1 as apellido1,
            clients.surn2 as apellido2,
            trunc((SYSDATE - clients.birthdate)/365, 0) as edad
        FROM (
            clients
            INNER JOIN
            banned
            ON banned.client = clients.email
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
    GROUP BY performer;

    IF melopack.get_ia() is not NULL OR cuenta < 1 THEN

        SELECT count(*)
            INTO cuenta
            FROM clients
        WHERE email = :NEW.email
        GROUP BY email;
        

        IF cuenta = 0 THEN
            INSERT INTO clients
                (email, name, surn1, surn2, birthdate, phone, address, dni)
                VALUES
                    (:NEW.email, :NEW.nombre, :NEW.apellido1, :NEW.apellido2, SYSDATE - :NEW.edad, NULL, NULL, NULL);
        END IF;

        SELECT count(*)
            INTO cuenta
            FROM attendances
        WHERE client = :NEW.email AND performer = melopack.get_ia()
        GROUP BY client, performer;
        

        SELECT max(when)
            INTO ultimo_concierto
            FROM concerts
        WHERE performer = melopack.get_ia()
        GROUP BY performer;
        

        SELECT when
            -- INTO penultimo_concierto
            FROM (
                SELECT
                    when,
                    rownum as rn
                FROM (
                    SELECT * FROM concerts
                    WHERE performer = melopack.get_ia()
                    ORDER BY -TO_NUMBER(TO_CHAR(when, 'J'))
                )
            )
        WHERE rn = 2;
        
        IF cuenta = 0 THEN
            INSERT INTO attendances
                (client, performer, when, rfid, birthdate, purchase)
                VALUES
                    (:NEW.email, melopack.get_ia(), ultimo_concierto, 'RFID-INVENTADO-ULTIMO-CONCIERTO-3.141592653589793', SYSDATE - :NEW.edad, SYSDATE),
                    (:NEW.email, melopack.get_ia(), penultimo_concierto, 'RFID-INVENTADO-PENULTIMO-CONCIERTO-3.141592653589793', SYSDATE - :NEW.edad, SYSDATE);
            
            INSERT INTO banned
                (client, performer)
                VALUES
                    (:NEW.email, melopack.get_ia());
            
        -- Si solo ha ido a un concierto
        ELSIF cuenta = 1 THEN
            -- ver si el concierto que tiene es el ultimo
            SELECT when
                INTO temp_concierto
                FROM attendances
            WHERE client = :NEW.email AND performer = melopack.get_ia()
            GROUP BY client, performer;

            IF temp_concierto = ultimo_concierto THEN
                -- si el único concierto al que ha ido es el ultimo, insertamos el PENultimo
                INSERT INTO attendances
                (client, performer, when, rfid, birthdate, purchase)
                VALUES
                    (:NEW.email, melopack.get_ia(), penultimo_concierto, 'RFID-INVENTADO-PENULTIMO-CONCIERTO-3.141592653589793', SYSDATE - :NEW.edad, SYSDATE);
            ELSE
                -- si no insertamos el ultimo
                INSERT INTO attendances
                (client, performer, when, rfid, birthdate, purchase)
                VALUES
                    (:NEW.email, melopack.get_ia(), ultimo_concierto, 'RFID-INVENTADO-ULTIMO-CONCIERTO-3.141592653589793', SYSDATE - :NEW.edad, SYSDATE);
            END IF;

            -- vetado a Falso
            UPDATE banned 
                SET ban = 0 
                WHERE 
                    client = :NEW.email AND 
                    performer = melopack.get_ia();
        
        ELSE
            UPDATE banned 
                SET ban = 0 
                WHERE 
                    client = :NEW.email AND 
                    performer = melopack.get_ia();
        END IF;
    END IF;

END;





CREATE OR REPLACE TRIGGER borrar_fans
INSTEAD OF DELETE ON fans
FOR EACH ROW
BEGIN
    UPDATE banned 
        SET ban = 1
        WHERE 
            client = :OLD.email AND 
            performer = melopack.get_ia();
END;



