SET SERVEROUT ON;

CREATE OR REPLACE TRIGGER actualizar_duracion
AFTER INSERT OR DELETE OR UPDATE ON performances
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
        raise_application_error(-20111, "Los menores no pueden comprar entradas");
    END IF;
END;


CREATE OR REPLACE TRIGGER canciones_repetidas
BEFORE INSERT ON songs
FOR EACH ROW
BEGIN
    SELECT count(*)
        INTO cuenta
    FROM songs
    WHERE title = :NEW.title AND writer = :NEW.cowriter AND cowriter = :NEW.writer

    IF cuenta > 0 THEN
        raise_application_error(-20111, "No se pueden insertar canciones repetidas");
    END IF;
END;