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
        ('MELLAMOCARLOS', 'Cunegunda Renacido', 'V', 'Cunegunda Rencido, EL ALBUM', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 'QuickSilver', 555336234);
-- Primero insertamos un track nuevo en un album existente

exec melopack.insertar_album_track('MELLAMOCARLOS', 'V', 'Cunegunda Renacido, EL ALBUM', TO_DATE('20/07/2019', 'DD-MM-YYYY'),  'QuickSilver', 555336234, 100, 'Il Signore della notte Vol.18', 'US>>0604451328',SYSDATE, NULL, 'RIKI GONZ', 100);
SELECT * FROM tracks WHERE pair = 'MELLAMOCARLOS' AND sequ = 100;