----------------------------------PRUEBA-1-1----------------------------------

SET SERVEROUTPUT ON;
EXEC melopack.asignar('Cunegunda Renacido');
EXEC dbms_output.put_line('Interprete: ' || melopack.get_ia());

----------------------------------PRUEBA-1-2----------------------------------

-- este artista no existe, es un fantasma
EXEC melopack.asignar('RIKI GONZ');
EXEC dbms_output.put_line('Interprete: ' || melopack.get_ia());

----------------------------------PRUEBA-2-1----------------------------------

INSERT INTO albums
    (pair, performer, format, title, rel_date, publisher, manager)
    VALUES
        ('MELLAMOCARLOS', 'Cunegunda Renacido', 'V', 
        'Cunegunda Rencido, EL ALBUM', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 
        'QuickSilver', 555336234);
-- Primero insertamos un track nuevo en un album existente
EXEC melopack.asignar('Cunegunda Renacido');
EXEC melopack.insertar_album_track( 'MELLAMOCARLOS', 'V', 'Cunegunda Renacido, EL ALBUM', 
                                    TO_DATE('20/07/2019', 'DD-MM-YYYY'),  'QuickSilver', 555336234, 
                                    100, 'Il Signore della notte Vol.18', 'US>>0604451328',SYSDATE, 
                                    NULL, 'RIKI GONZ', 100);
SELECT * FROM tracks WHERE pair = 'MELLAMOCARLOS' AND sequ = 100;


----------------------------------PRUEBA-2-2----------------------------------

-- Cambiamos el PAIR, para crear un album nuevo
EXEC melopack.insertar_album_track( 'MELLAMO-PATO', 'V', 'Cunegunda Renacido, EL ALBUM', 
                                    TO_DATE('20/07/2019', 'DD-MM-YYYY'),  'QuickSilver', 555336234, 
                                    100, 'Il Signore della notte Vol.18', 'US>>0604451328',SYSDATE, 
                                    NULL, 'RIKI GONZ', 100);
SELECT * FROM albums WHERE pair = 'MELLAMO-PATO';
SELECT * FROM tracks WHERE pair = 'MELLAMO-PATO' AND sequ = 100;


----------------------------------PRUEBA-2-3----------------------------------

-- Si intentamos insertar otro track (cambiando el sequ), sobre un album que previamente insertamo
-- pero una de las columnas referenciadas no existe NO se inserta
-- En este caso la discografia NO-EXISTO
EXEC melopack.insertar_album_track( 'MELLAMO-PATO', 'V', 'Cunegunda Renacido, EL ALBUM', 
                                    TO_DATE('20/07/2019', 'DD-MM-YYYY'),  'NO-EXISTO', 555336234, 
                                    101, 'Il Signore della notte Vol.18', 'US>>0604451328',SYSDATE, 
                                    NULL, 'RIKI GONZ', 100);
SELECT * FROM tracks WHERE pair = 'MELLAMO-PATO' AND sequ = 101;

----------------------------------PRUEBA-2-4----------------------------------
DELETE from albums where performer = 'Cunegunda Renacido';

-- Si insertamos un track en un album que no existe, pero metemos un formato o duracion invalidas
-- No se inserta
EXEC melopack.insertar_album_track( 'MELLAMO-PATO', 'X', 'Cunegunda Renacido, EL ALBUM', TO_DATE('20/07/2019', 'DD-MM-YYYY'),  'QuickSilver', 555336234, 100, 'Il Signore della notte Vol.18', 'US>>0604451328',SYSDATE, NULL, 'RIKI GONZ', NULL);
SELECT * FROM albums WHERE pair = 'MELLAMO-PATO';

----------------------------------PRUEBA-3-1----------------------------------

-- Primero borramos un track de un album con muchos tracks
-- A4372UPF9634M4M de Cunegunda, tiene 14 canciones
-- Despues de borrar pasa a tener 13
EXEC melopack.asignar('Cunegunda');
EXEC melopack.borrar_track('A4372UPF9634M4M', 14);

select 
    albums.pair, 
    count(*) 
from (
    albums 
    inner join 
    tracks 
    on tracks.pair = albums.pair
    ) 
where performer = 'Cunegunda' AND albums.pair = 'A4372UPF9634M4M'
group by albums.pair;

----------------------------------PRUEBA-3-2----------------------------------
DELETE FROM albums WHERE performer = 'ALBUM-NUEVO';
-- Si insertamos un album nuevo con una sola cancion
EXEC melopack.insertar_album_track( 'ALBUM-NUEVO', 'V', 'Cunegunda Renacido, EL ALBUM', 
                                    TO_DATE('20/08/2019', 'DD-MM-YYYY'),  'QuickSilver', 555336234, 
                                    100, 'Il Signore della notte Vol.18', 'US>>0604451328',SYSDATE, 
                                    NULL, 'RIKI GONZ', 100);
EXEC melopack.borrar_track('ALBUM-NUEVO', 100);
-- Se borran tanto el album, como el track
SELECT * FROM albums WHERE pair = 'ALBUM-NUEVO';

----------------------------------PRUEBA-3-3----------------------------------

-- Si intentamos borrar una cancion en un album que no existe
-- O un track que no existe en un album que si, no pasara nada
EXEC melopack.borrar_track('ALBUM-QUE-NO-EXISTE', 1);

-- Este album no tiene un track #100
EXEC melopack.borrar_track('A4372UPF9634M4M', 100);

----------------------------------PRUEBA-4-1----------------------------------

-- Un ejemplo de informe de un artista muchos con datos
EXEC melopack.asignar('La Ciudadela');
EXEC melopack.informe();

----------------------------------PRUEBA-4-2----------------------------------

-- Viendo datos específicos con un interprete nuevo
INSERT INTO performers
    (name, nationality, language)
    VALUES 
        ('INT-NOOB', 'Spanish', 'Spanish');

INSERT 

    INTO songs (title, writer, cowriter) 
        VALUES ('CANCION-INFORME', 'US>>0604451328', NULL),


    INTO albums (pair, performer, format, title, rel_date)
        VALUES ('PAIR-1', 'INT-NOOB', 'V', 'UNO', TO_DATE('01/01/2000', 'DD-MM-YYYY'), 'QuickSilver', 555336234),
    INTO albums (pair, performer, format, title, rel_date)
        VALUES ('PAIR-2', 'INT-NOOB', 'V', 'DOS', TO_DATE('01/01/2001', 'DD-MM-YYYY'), 'QuickSilver', 555336234),

    INTO tracks 
        (pair, sequ, title, writer, duration, rec_date, studio, engineer)
        VALUES ('PAIR-1', 1, 'CANCION-INFORME', 'US>>0604451328', 100,  TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'Jeff Bezos'),
    INTO tracks 
        (pair, sequ, title, writer, duration, rec_date, studio, engineer)
        VALUES ('PAIR-1', 2, 'CANCION-INFORME', 'US>>0604451328', 100,  TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'Jeff Bezos'),
    INTO tracks 
        (pair, sequ, title, writer, duration, rec_date, studio, engineer)
        VALUES ('PAIR-1', 3, 'CANCION-INFORME', 'US>>0604451328', 100,  TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'Jeff Bezos'),
    
    INTO tracks 
        (pair, sequ, title, writer, duration, rec_date, studio, engineer)
        VALUES ('PAIR-2', 1, 'CANCION-INFORME', 'US>>0604451328', 100,  TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'Jeff Bezos'),
    INTO tracks 
        (pair, sequ, title, writer, duration, rec_date, studio, engineer)
        VALUES ('PAIR-2', 2, 'CANCION-INFORME', 'US>>0604451328', 100,  TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'Jeff Bezos'),
    INTO tracks 
        (pair, sequ, title, writer, duration, rec_date, studio, engineer)
        VALUES ('PAIR-2', 3, 'CANCION-INFORME', 'US>>0604451328', 100,  TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'Jeff Bezos'),


    INTO albums (pair, performer, format, title, rel_date)
        VALUES ('PAIR-3', 'INT-NOOB', 'S', 'TRES', TO_DATE('01/01/2002', 'DD-MM-YYYY'), 'QuickSilver', 555336234),
    INTO albums (pair, performer, format, title, rel_date)
        VALUES ('PAIR-4', 'INT-NOOB', 'S', 'CUATRO', TO_DATE('01/01/2006', 'DD-MM-YYYY'), 'QuickSilver', 555336234),
    INTO albums (pair, performer, format, title, rel_date)
        VALUES ('PAIR-5', 'INT-NOOB', 'S', 'CUATRO', TO_DATE('01/01/2014', 'DD-MM-YYYY'), 'QuickSilver', 555336234),

    INTO tracks 
        (pair, sequ, title, writer, duration, rec_date, studio, engineer)
        VALUES ('PAIR-3', 1, 'CANCION-INFORME', 'US>>0604451328', 500,  TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'Jeff Bezos'),
    INTO tracks 
        (pair, sequ, title, writer, duration, rec_date, studio, engineer)
        VALUES ('PAIR-4', 1, 'CANCION-INFORME', 'US>>0604451328', 500,  TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'Jeff Bezos'),
    INTO tracks 
        (pair, sequ, title, writer, duration, rec_date, studio, engineer)
        VALUES ('PAIR-5', 1, 'CANCION-INFORME', 'US>>0604451328', 500,  TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'Jeff Bezos')
    SELECT 1 FROM DUAL;


-- 2 albums vinilo, 
--  separados en 365 dias
--  ambos con 3 canciones de 100 minutos

-- 3 albums single, 
--  12 años entre el primero y el ultimo
--  cada uno con una cancion de de 100 minutos

EXEC melopack.asignar('INTERPRETE-NOOB');
EXEC melopack.informe();

