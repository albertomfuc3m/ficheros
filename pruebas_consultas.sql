-- El porcentaje de tracks va a pasar a NULL, porque dejara de tener grabaciones
DELETE FROM tracks 
    WHERE pair IN (SELECT pair FROM albums WHERE performer = 'Cunegunda');

-- El porcentaje de interpretaciones va a pasar a NULL
DELETE FROM performances
    WHERE performer = 'Cunegunda';

-- Insertamos canciones escritas por Cunegunda y las respectivads
INSERT INTO songs
    (title, writer, cowriter)
    VALUES
        ('El Señore de la Noche', 'US>>0604451328', NULL);

INSERT INTO tracks
    (pair, sequ, title, writer, duration, rec_date, studio, engineer)        
    VALUES
        ('R35096S379797J0',  3, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  4, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  5, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  6, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  7, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  8, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  9, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 10, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 11, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 12, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 13, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 14, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 15, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 16, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 17, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 18, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 19, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 20, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 21, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 22, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 23, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 24, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 25, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 26, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 27, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 28, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 29, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 30, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 31, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 32, 'El Señore de la Noche', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña');

