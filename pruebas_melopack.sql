----------------------------------PRUEBA-1-1----------------------------------

SET SERVEROUTPUT ON;
EXEC melopack.asignar('Cunegunda');
EXEC dbms_output.put_line('Interprete: ' || melopack.get_ia());

-- este artista no existe, es un fantasma
EXEC melopack.asignar('RIKI GONZ');
EXEC dbms_output.put_line('Interprete: ' || melopack.get_ia());

----------------------------------PRUEBA-2-1----------------------------------

/* 
('MELLAMOCARLOS', 'Cunegunda Renacido', 'V', 'Cunegunda Rencido, EL ALBUM', 
TO_DATE('20/07/2019', 'DD-MM-YYYY'), 'QuickSilver', 555336234);
*/
-- Utilizamos este album
-- Primero insertamos un track nuevo en un album existente


exec melopack.insertar_album_track('MELLAMOCARLOS', NULL, NULL, NULL, NULL, NULL, 100, 'Il Signore della notte Vol.18', 'US>>0604451328',SYSDATE, NULL, 'RIKI GONZ', 100);
SELECT * FROM tracks WHERE pair = 'MELLAMOCARLOS' AND sequ = 100;