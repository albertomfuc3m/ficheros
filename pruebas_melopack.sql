----------------------------------PRUEBA-1-1----------------------------------

SET SERVEROUTPUT ON;
EXEC melopack.asignar('Cunegunda');
EXEC dbms_output.put_line('Interprete: ' || melopack.get_ia());

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
EXEC melopack.insertar_album_track( 'MELLAMO-PATO', 'V', 'Cunegunda Renacido, EL ALBUM', TO_DATE('20/07/2019', 'DD-MM-YYYY'),  'QuickSilver', 555336234, 100, 'Il Signore della notte Vol.18', 'US>>0604451328',SYSDATE, NULL, 'RIKI GONZ', 100);
SELECT * FROM albums WHERE pair = 'MELLAMO-PATO';
SELECT * FROM tracks WHERE pair = 'MELLAMOCARLOS' AND sequ = 100;


----------------------------------PRUEBA-2-3----------------------------------

-- Si intentamos insertar un track, sobre un album que previamente insertamo
-- pero una de las columnas referenciadas no existe NO se inserta
-- En este caso la discografia NO-EXISTO
EXEC melopack.insertar_album_track( 'MELLAMO-PATO', 'V', 'Cunegunda Renacido, EL ALBUM', 
                                    TO_DATE('20/07/2019', 'DD-MM-YYYY'),  'NO-EXISTO', 555336234, 
                                    100, 'Il Signore della notte Vol.18', 'US>>0604451328',SYSDATE, 
                                    NULL, 'RIKI GONZ', 100);
SELECT * FROM tracks WHERE pair = 'MELLAMO-PATO' AND sequ = 100;