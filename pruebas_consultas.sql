----------------------------------PRUEBA-1----------------------------------

-- El porcentaje de tracks va a pasar a NULL, porque dejara de tener grabaciones
DELETE FROM tracks 
    WHERE pair IN (SELECT pair FROM albums WHERE performer = 'Cunegunda');

----------------------------------PRUEBA-2----------------------------------

-- Si borramos las interpretaciones
-- El porcentaje de interpretaciones va a pasar a NULL
DELETE FROM performances
    WHERE performer = 'Cunegunda';

----------------------------------PRUEBA-3----------------------------------

-- Insertamos canciones escritas por Cunegunda y las respectivas tracks para cambiar su porcentaje
-- Tiene 175 tracks, de las cuales 31 ha escrito un miembro, siendo su porcentaje 17.71%
-- Si añadimos 30 tracks escritas por un miembro
-- porcentaje deberia cambiar a (31+30)/(175+30) = 29.75
INSERT ALL
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.01', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.02', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.03', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.04', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.05', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.06', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.07', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.08', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.09', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.10', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.11', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.12', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.13', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.14', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.15', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.16', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.17', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.18', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.19', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.20', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.21', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.22', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.23', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.24', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.25', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.26', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.27', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.28', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.29', 'US>>0604451328', NULL)
    INTO songs (title, writer, cowriter) VALUES ('Il Signore della notte Vol.30', 'US>>0604451328', NULL)
    SELECT 1 FROM DUAL;

INSERT ALL
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0',  3, 'Il Signore della notte Vol.01', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0',  4, 'Il Signore della notte Vol.02', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0',  5, 'Il Signore della notte Vol.03', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0',  6, 'Il Signore della notte Vol.04', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0',  7, 'Il Signore della notte Vol.05', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0',  8, 'Il Signore della notte Vol.06', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0',  9, 'Il Signore della notte Vol.07', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 10, 'Il Signore della notte Vol.08', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 11, 'Il Signore della notte Vol.09', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 12, 'Il Signore della notte Vol.10', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 13, 'Il Signore della notte Vol.11', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 14, 'Il Signore della notte Vol.12', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 15, 'Il Signore della notte Vol.13', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 16, 'Il Signore della notte Vol.14', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 17, 'Il Signore della notte Vol.15', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 18, 'Il Signore della notte Vol.16', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 19, 'Il Signore della notte Vol.17', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 20, 'Il Signore della notte Vol.18', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 21, 'Il Signore della notte Vol.19', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 22, 'Il Signore della notte Vol.20', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 23, 'Il Signore della notte Vol.21', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 24, 'Il Signore della notte Vol.22', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 25, 'Il Signore della notte Vol.23', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 26, 'Il Signore della notte Vol.24', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 27, 'Il Signore della notte Vol.25', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 28, 'Il Signore della notte Vol.26', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 29, 'Il Signore della notte Vol.27', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 30, 'Il Signore della notte Vol.28', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 31, 'Il Signore della notte Vol.29', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    INTO tracks (pair, sequ, title, writer, duration, rec_date, studio, engineer) VALUES ('R35096S379797J0', 32, 'Il Signore della notte Vol.30', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña')
    SELECT 1 FROM DUAL;

----------------------------------PRUEBA-4----------------------------------

-- Despues de insertar la canciones, insertamos las respectivas interpretaciones para cambiar el porcentaje
-- Tiene 87 interpretaciones de canciones distintas, de las cuales 12 ha escrito un miembro, siendo su porcentaje 13.79%
-- Si añadimos 30 interpretaciones escritas por un miembro
-- porcentaje deberia cambiar a (12+30)/(87+30) = 35.89%
INSERT ALL
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 12, 'Il Signore della notte Vol.01', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 13, 'Il Signore della notte Vol.02', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 14, 'Il Signore della notte Vol.03', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 15, 'Il Signore della notte Vol.04', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 16, 'Il Signore della notte Vol.05', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 17, 'Il Signore della notte Vol.06', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 18, 'Il Signore della notte Vol.07', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 19, 'Il Signore della notte Vol.08', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 20, 'Il Signore della notte Vol.09', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 21, 'Il Signore della notte Vol.10', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 22, 'Il Signore della notte Vol.11', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 23, 'Il Signore della notte Vol.12', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 24, 'Il Signore della notte Vol.13', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 25, 'Il Signore della notte Vol.14', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 41, 'Il Signore della notte Vol.15', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 26, 'Il Signore della notte Vol.16', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 27, 'Il Signore della notte Vol.17', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 28, 'Il Signore della notte Vol.18', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 29, 'Il Signore della notte Vol.19', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 30, 'Il Signore della notte Vol.20', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 31, 'Il Signore della notte Vol.21', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 32, 'Il Signore della notte Vol.22', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 33, 'Il Signore della notte Vol.23', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 34, 'Il Signore della notte Vol.24', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 35, 'Il Signore della notte Vol.25', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 36, 'Il Signore della notte Vol.26', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 37, 'Il Signore della notte Vol.27', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 38, 'Il Signore della notte Vol.28', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 39, 'Il Signore della notte Vol.29', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) VALUES ('Cunegunda', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 40, 'Il Signore della notte Vol.30', 'US>>0604451328', 180)
    SELECT 1 FROM DUAL

----------------------------------PRUEBA-5----------------------------------

-- Para un interprete sin musicos, ni interpretaciones, ni tracks, ambos porcentajes son NULL
INSERT INTO performers
    (name, nationality, language)
    VALUES 
        ('Cunegunda Renacido', 'Spanish', 'Spanish');

-- Si insertamos un track pasaran a ser 0 porque no tiene musicos que las hayan podido escribir
INSERT INTO albums
    (pair, performer, format, title, rel_date, publisher, manager)
    VALUES
        ('MELLAMOCARLOS', 'Cunegunda Renacido', 'V', 'Cunegunda Rencido, EL ALBUM', TO_DATE('20/07/2019', 'DD-MM-YYYY'), 'QuickSilver', 555336234);
INSERT INTO tracks 
    (pair, sequ, title, writer, duration, rec_date, studio, engineer) 
    VALUES 
        ('MELLAMOCARLOS',  1, 'Il Signore della notte Vol.01', 'US>>0604451328', 180, TO_DATE('01/01/2000', 'DD-MM-YYYY'), NULL, 'M.A. Peña');


------------------------------------------------------------------------------------------------------------------------------------------------



----------------------------------PRUEBA-1---------------------------------

-- Insertamos un interprete con una grabacion y dos interpretaciones (usamos el interprete y grabacion de la anterior prueba)
-- Dos conciertos con una interpretacion cada una

INSERT ALL
    INTO concerts (performer, when, tour, municipality, address, country, attendance, duration, manager)
        VALUES ('Cunegunda Renacido', TO_DATE('01/01/2010', 'DD-MM-YYYY'), NULL, 'Leganes', 'Avenida 123', 'Spain', 0, NULL, 555336234)
    INTO concerts (performer, when, tour, municipality, address, country, attendance, duration, manager)
        VALUES ('Cunegunda Renacido', TO_DATE('01/01/2020', 'DD-MM-YYYY'), NULL, 'Leganes', 'Avenida 123', 'Spain', 0, NULL, 555336234)
    SELECT 1 FROM DUAL;

INSERT ALL 
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) 
        VALUES ('Cunegunda Renacido', TO_DATE('01/01/2010', 'DD-MM-YYYY'), 12, 'Il Signore della notte Vol.01', 'US>>0604451328', 180)
    INTO performances (performer, when, sequ, songtitle, songwriter, duration) 
        VALUES ('Cunegunda Renacido', TO_DATE('01/01/2020', 'DD-MM-YYYY'), 12, 'Il Signore della notte Vol.01', 'US>>0604451328', 180)
    SELECT 1 FROM DUAL;

-- Sin tener en cuenta el %, vemos que la media es 5479 dias
-- Del 1/1/2000 al 01/01/2020 hay 7305 dias
-- Del 1/1/2000 al 01/01/2010 hay 3653 dias
-- Siendo la media 5479 dias

----------------------------------PRUEBA-2---------------------------------

-- Añadiendo una interpretacion de otra cancion que no a grabado, su porcentaje pasa a ser 50%
INSERT performances 
    (performer, when, sequ, songtitle, songwriter, duration) 
    VALUES 
        ('Cunegunda Renacido', TO_DATE('01/01/2010', 'DD-MM-YYYY'), 13, 'Il Signore della notte Vol.02', 'US>>0604451328', 180);

----------------------------------PRUEBA-3---------------------------------

-- Si se diese el caso de que no ha grabado ninguna cancion que ha interpretado no apareceria en la media y su porcentaje seria 0
DELETE FROM tracks 
    WHERE pair IN (SELECT pair FROM albums WHERE performer = 'Cunegunda Renacido');