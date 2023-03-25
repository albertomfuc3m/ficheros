-- El porcentaje de tracks va a pasar a NULL, porque dejara de tener grabaciones
DELETE FROM tracks 
    WHERE pair IN (SELECT pair FROM albums WHERE performer = 'Cunegunda');

-- El porcentaje de interpretaciones va a pasar a NULL
DELETE FROM performances
    WHERE performer = 'Cunegunda';

-- Insertamos canciones escritas por Cunegunda y las respectivas tracks para cambiar su porcentaje
-- Tiene 175 tracks, de las cuales 31 ha escrito un miembro, siendo su porcentaje 17.71%
-- Si añadirmos 30 tracks escritos por un miembro
-- porcentaje deberia cambiar a (31+30)/(175+30) = 29.75
INSERT INTO songs
    (title, writer, cowriter)
    VALUES
        ('Il Signore della notte Vol.01', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.02', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.03', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.04', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.05', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.06', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.07', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.08', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.09', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.10', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.11', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.12', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.13', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.14', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.15', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.16', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.17', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.18', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.19', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.20', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.21', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.22', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.23', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.24', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.25', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.26', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.27', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.28', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.29', 'US>>0604451328', NULL),
        ('Il Signore della notte Vol.30', 'US>>0604451328', NULL);

INSERT INTO tracks
    (pair, sequ, title, writer, duration, rec_date, studio, engineer)        
    VALUES
        ('R35096S379797J0',  3, 'Il Signore della notte Vol.01', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  4, 'Il Signore della notte Vol.02', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  5, 'Il Signore della notte Vol.03', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  6, 'Il Signore della notte Vol.04', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  7, 'Il Signore della notte Vol.05', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  8, 'Il Signore della notte Vol.06', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0',  9, 'Il Signore della notte Vol.07', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 10, 'Il Signore della notte Vol.08', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 11, 'Il Signore della notte Vol.09', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 12, 'Il Signore della notte Vol.10', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 13, 'Il Signore della notte Vol.11', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 14, 'Il Signore della notte Vol.12', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 15, 'Il Signore della notte Vol.13', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 16, 'Il Signore della notte Vol.14', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 17, 'Il Signore della notte Vol.15', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 18, 'Il Signore della notte Vol.16', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 19, 'Il Signore della notte Vol.17', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 20, 'Il Signore della notte Vol.18', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 21, 'Il Signore della notte Vol.19', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 22, 'Il Signore della notte Vol.20', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 23, 'Il Signore della notte Vol.21', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 24, 'Il Signore della notte Vol.22', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 25, 'Il Signore della notte Vol.23', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 26, 'Il Signore della notte Vol.24', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 27, 'Il Signore della notte Vol.25', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 28, 'Il Signore della notte Vol.26', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 29, 'Il Signore della notte Vol.27', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 30, 'Il Signore della notte Vol.28', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 31, 'Il Signore della notte Vol.29', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña'),
        ('R35096S379797J0', 32, 'Il Signore della notte Vol.30', 'US>>0604451328', 180, SYSDATE, NULL, 'M.A. Peña');

