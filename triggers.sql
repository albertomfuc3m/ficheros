SET SERVEROUT ON;

CREATE OR REPLACE TRIGGER actualizar_duracion
AFTER INSERT ON performances
FOR EACH ROW
BEGIN
    IF (INSERTING) THEN
        UPDATE concerts
            SET duration = duration + :NEW.duration
            WHERE 
                performer = :NEW.performer AND
                when = :NEW.when;
    ELSIF (DELETING) THEN
        UPDATE concerts
            SET duration = duration - :OLD.duration
            WHERE 
                performer = :NEW.performer AND
                when = :NEW.when;
    ELSIF (UPDATING) THEN
        UPDATE concerts
            SET duration = duration - :OLD.duration + :NEW.duration
            WHERE 
                performer = :NEW.performer AND
                when = :NEW.when;
    END IF;
END;

CREATE OR REPLACE TRIGGER control_edad
BEFORE INSERT ON attendances
FOR EACH ROW
BEGIN
    IF (SYSDATE - birthdate) < 18 * 365 THEN
        raise menor;
    END IF;
EXCEPTION
    WHEN menor THEN dbms_output.put_line("Los menors de 18 no pueden comprar entradas")
END;


CREATE OR REPLACE TRIGGER canciones_repetidas
BEFORE INSERT ON songs
FOR EACH ROW
DECLARE 
    cuenta NUMBER(3);
BEGIN
    SELECT count(*)
        INTO cuenta
    FROM songs
    WHERE title = :NEW.title AND writer = :NEW.cowriter AND cowriter = :NEW.writer

    IF cuenta > 0 THEN
        raise repetida;
    END IF;
EXCEPTION
    WHEN repetida THEN dbms_output.put_line("La cancion ya existe con los autores cambiados")
END;