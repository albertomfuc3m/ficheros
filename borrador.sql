SET SERVEROUT ON;
CREATE OR REPLACE PACKAGE melopack AS
    -- global
    interprete_actual VARCHAR2(50);
  
    PROCEDURE asignar(id_interprete VARCHAR2);
    FUNCTION get_ia return VARCHAR2;
    PROCEDURE insertar_album_track(
        id_pair CHAR,
        format CHAR,
        title VARCHAR2,
        rel_date DATE,
        id_publisher VARCHAR2,
        id_manager NUMBER,

        sequ NUMBER,
        id_title_song VARCHAR2,
        id_writer_song CHAR,
        rec_date DATE,
        id_studio VARCHAR2,
        engineer VARCHAR2,
        duration NUMBER
        );
    PROCEDURE borrar_track(id_pair CHAR, sequ NUMBER);
    PROCEDURE informe;

END melopack;
/

CREATE OR REPLACE PACKAGE BODY melopack AS
    PROCEDURE asignar(id_interprete VARCHAR2) IS
        cuenta NUMBER;
        BEGIN
            SELECT count(*)
                INTO cuenta
                FROM performers
            WHERE name = id_interprete;

            IF cuenta = 1 THEN
                SELECT name
                    INTO interprete_actual
                    FROM performers
                WHERE name = id_interprete;
            ELSE
                interprete_actual := NULL;
            END IF;
        END asignar;
    
    FUNCTION get_ia return VARCHAR2 IS 
        BEGIN
            return interprete_actual;
        END get_ia;
    PROCEDURE insertar_album_track(
        id_pair CHAR,
        format CHAR,
        title VARCHAR2,
        rel_date DATE,
        id_publisher VARCHAR2,
        id_manager NUMBER,

        sequ NUMBER,
        id_title_song VARCHAR2,
        id_writer_song CHAR,
        rec_date DATE,
        id_studio VARCHAR2,
        engineer VARCHAR2,
        duration NUMBER
        ) IS
            pair_album albums.pair%TYPE;
            publisher publishers.name%TYPE;
            manager managers.mobile%TYPE;
            title_song songs.title%TYPE;
            writer_song songs.title%TYPE;
            studio studios.name%TYPE;

            cuenta NUMBER;

            BEGIN
                IF interprete_actual is not NULL THEN
                    -- Comprobar las filas referenciadas
                    SELECT 
                        count(*)
                        INTO cuenta
                        FROM albums
                    WHERE pair = id_pair;

                    IF cuenta = 1 THEN
                        SELECT 
                            pair
                            INTO pair_album
                            FROM albums
                        WHERE pair = id_pair;
                    ELSE
                        pair_album := NULL;
                    END IF;

                    SELECT 
                        count(*)
                        INTO cuenta
                        FROM publishers
                    WHERE name = id_publisher;

                    IF cuenta = 1 THEN
                        SELECT
                            name
                            INTO publisher
                            FROM publishers
                        WHERE name = id_publisher;
                    ELSE
                        publisher := NULL;
                    END IF;

                    SELECT 
                        count(*)
                        INTO cuenta
                        FROM managers
                    WHERE mobile = id_manager;

                    IF cuenta = 1 THEN
                        SELECT
                            mobile
                            INTO manager
                            FROM managers
                        WHERE mobile = id_manager;
                    ELSE
                        manager := NULL;
                    END IF;
                    
                    SELECT 
                        count(*)
                        INTO cuenta
                        FROM songs
                    WHERE songs.writer = id_writer_song AND songs.title = id_title_song;

                    IF cuenta = 1 THEN
                        SELECT
                            title,
                            writer
                            INTO title_song, writer_song
                            FROM songs
                        WHERE songs.writer = id_writer_song AND songs.title = id_title_song;
                    ELSE
                        title_song := NULL;
                        writer_song := NULL;
                    END IF;

                    SELECT 
                        count(*)
                        INTO cuenta
                        FROM studios
                    WHERE name = id_studio;

                    IF cuenta = 1 THEN
                        SELECT
                            name
                            INTO studio
                            FROM studios
                        WHERE name = id_studio;
                    ELSE
                        studio := NULL;
                    END IF;


                    IF  title_song is NOT NULL AND 
                        writer_song is NOT NULL AND 
                        (studio is NOT NULL or id_studio is NULL) AND 
                        publisher is NOT NULL AND
                        manager is NOT NULL THEN 

                        -- datos referenciados existen

                        IF pair_album is NULL THEN 
                            INSERT INTO albums
                            (PAIR, performer, format, title, rel_date, publisher, manager)
                            VALUES 
                                (id_pair, interprete_actual, format, title, rel_date, publisher, manager);
                        END IF;

                        
                        INSERT INTO tracks
                        (PAIR, sequ, title, writer, rec_date, studio, engineer, duration)
                        VALUES 
                            (id_pair, sequ, title_song, writer_song, rec_date, studio, engineer, duration);
                        
                    
                    END IF;
                END IF;
            END insertar_album_track;

    PROCEDURE borrar_track(id_pair CHAR, sequ NUMBER) AS
        cuenta NUMBER;
        BEGIN
            SELECT count(*)
                INTO cuenta
                FROM tracks
            WHERE pair = id_pair AND sequ = sequ;

            IF cuenta > 0 THEN
                SELECT count(*)
                    INTO cuenta
                    FROM tracks
                WHERE pair = id_pair;

                IF cuenta = 1 THEN
                    DELETE FROM albums WHERE PAIR = id_pair;
                ELSE
                    DELETE FROM tracks WHERE PAIR = id_pair AND sequ = sequ;
                END IF;

            END IF;
        END borrar_track;

    

    PROCEDURE informe AS 
        CURSOR c_discograficas IS 
            WITH n_albums as (
                SELECT
                    performer as p,
                    count(*) as c
                FROM albums
                WHERE performer = interprete_actual
                GROUP BY performer
            ),
            discograficas as (
                SELECT 
                    performer as p,
                    publisher,
                    count(*) as c
                FROM albums
                WHERE performer = interprete_actual
                GROUP BY performer, publisher
                order by performer
            ),
            FINAL_discograficas as (
                SELECT 
                    discograficas.p,
                    discograficas.publisher,
                    discograficas.c,
                    round(discograficas.c/n_albums.c, 3) as porcentaje
                FROM (
                    discograficas
                    INNER JOIN
                    n_albums
                    ON discograficas.p = n_albums.p
                )
            )
            SELECT * FROM FINAL_discograficas;
        
        
        CURSOR c_ingenieros IS 
            WITH n_tracks as (
                SELECT 
                    albums.performer as p,
                    count(*) as c 
                FROM (
                    albums
                    INNER JOIN
                    tracks
                    ON tracks.pair = albums.pair
                )
                WHERE albums.performer = interprete_actual
                GROUP BY albums.performer
            ),
            ingenieros as (
                SELECT 
                    albums.performer as p,
                    tracks.engineer,
                    count(*) as c
                FROM (
                    albums
                    INNER JOIN
                    tracks
                    ON tracks.pair = albums.pair
                )
                WHERE albums.performer = interprete_actual
                GROUP BY albums.performer, tracks.engineer
            ),
            FINAL_ingenieros as (
                SELECT 
                    ingenieros.p,
                    ingenieros.engineer,
                    ingenieros.c,
                    round(ingenieros.c/n_tracks.c, 3) as porcentaje
                FROM (
                    ingenieros
                    INNER JOIN
                    n_tracks
                    ON ingenieros.p = n_tracks.p
                )
            )
            SELECT * FROM FINAL_ingenieros;
        CURSOR c_studios IS 
            WITH  n_tracks as (
                SELECT 
                    albums.performer as p,
                    count(*) as c 
                FROM (
                    albums
                    INNER JOIN
                    tracks
                    ON tracks.pair = albums.pair
                )
                WHERE albums.performer = interprete_actual
                GROUP BY albums.performer
            ),
            studios as (
                SELECT 
                    albums.performer as p,
                    tracks.studio,
                    count(*) as c
                FROM (
                    albums
                    INNER JOIN
                    tracks
                    ON tracks.pair = albums.pair
                )
                WHERE tracks.studio is not NULL AND albums.performer = interprete_actual
                GROUP BY albums.performer, tracks.studio
                ORDER BY PERFORMER
            ),
            FINAL_studios as (
                SELECT 
                    studios.p,
                    studios.studio,
                    studios.c,
                    round(studios.c/n_tracks.c, 3) as porcentaje
                FROM (
                    studios
                    INNER JOIN
                    n_tracks
                    ON studios.p = n_tracks.p
                )
            )
            SELECT * FROM FINAL_studios;
        CURSOR c_managers_albums IS
            WITH n_albums as (
                SELECT
                    performer as p,
                    count(*) as c
                FROM albums
                WHERE performer = interprete_actual
                GROUP BY performer
            ),
            managers_albums as (
                SELECT 
                    performer as p,
                    manager,
                    count(*) as c
                FROM albums
                WHERE performer = interprete_actual
                GROUP BY performer, manager
            ),
            FINAL_managers_albums as (
                SELECT 
                    managers_albums.p,
                    managers_albums.manager,
                    managers_albums.c,
                    round(managers_albums.c/n_albums.c, 3) as porcentaje
                FROM (
                    managers_albums
                    INNER JOIN
                    n_albums
                    ON managers_albums.p = n_albums.p
                )
            )
            SELECT * FROM FINAL_managers_albums;
        CURSOR c_managers_conciertos IS 
            WITH n_conciertos AS (
                SELECT
                    performer as p,
                    count(*) as c
                FROM concerts
                WHERE performer = interprete_actual
                GROUP BY performer
            ),
            managers_conciertos as (
                SELECT 
                    performer as p,
                    manager,
                    count(*) as c
                FROM concerts
                WHERE performer = interprete_actual
                GROUP BY performer, manager
            ),
            FINAL_managers_conciertos as (
                SELECT 
                    managers_conciertos.p,
                    managers_conciertos.manager,
                    managers_conciertos.c,
                    round(managers_conciertos.c/n_conciertos.c, 3) as porcentaje
                FROM (
                    managers_conciertos
                    INNER JOIN
                    n_conciertos
                    ON managers_conciertos.p = n_conciertos.p
                )
            )
            SELECT * FROM FINAL_managers_conciertos;

        CURSOR c_conciertos IS 
            WITH temp_conciertos0 as (
                SELECT
                    concerts.performer as p,
                    count(*) as total_canciones,
                    sum(performances.duration) as total_duration,
                    MAX(concerts.when) - MIN(concerts.when) as total_periodo
                FROM (
                    concerts
                    INNER JOIN
                    performances

                    ON concerts.performer = performances.performer AND 
                    concerts.when = performances.when
                )
                WHERE concerts.performer = interprete_actual
                GROUP BY concerts.performer
            ),
            temp_conciertos1 as (
                SELECT 
                    performer as p, 
                    count(*) as n_conciertos 
                FROM concerts
                WHERE performer = interprete_actual
                GROUP BY performer
            ),
            FINAL_conciertos as (
                SELECT
                    temp_conciertos0.p,
                    round(temp_conciertos0.total_canciones/temp_conciertos1.n_conciertos, 1) as m_canciones,
                    round(temp_conciertos0.total_duration/temp_conciertos1.n_conciertos, 1) as m_duration,
                    round(temp_conciertos0.total_periodo/temp_conciertos1.n_conciertos, 1) as m_periodicidad
                FROM 
                    temp_conciertos0
                    INNER JOIN
                    temp_conciertos1
                    ON temp_conciertos0.p = temp_conciertos1.p
            )
            SELECT * FROM FINAL_conciertos;
        CURSOR c_albums IS 
            WITH n_albums_format AS (
                SELECT 
                    performer AS p,
                    format AS f,
                    ROUND((MAX(rel_date) - MIN(rel_date))/COUNT(*), 0) AS t, 
                    COUNT(*) AS c
                FROM albums
                WHERE performer = interprete_actual
                GROUP BY format, performer
                ORDER BY performer
            ),
            temp_canciones AS (
                SELECT
                    albums.performer AS p,
                    albums.format AS f,
                    COUNT(*) AS n_canciones,
                    SUM(tracks.duration) AS duration_tipo
                FROM (
                    albums
                    INNER JOIN 
                    tracks 
                    ON tracks.pair = albums.pair
                )
                WHERE albums.performer = interprete_actual
                GROUP BY albums.performer, albums.format
            ),
            FINAL_albums AS (
                SELECT
                    n_albums_format.p AS p,
                    n_albums_format.f AS f,
                    n_albums_format.c AS n_albums_format,
                    n_albums_format.t AS m_periodicidad,
                    trunc(temp_canciones.n_canciones/n_albums_format.c, 1) AS m_canciones,
                    trunc(temp_canciones.duration_tipo/n_albums_format.c, 1) AS m_duration
                FROM 
                    n_albums_format
                    INNER JOIN 
                    temp_canciones 
                    ON n_albums_format.p = temp_canciones.p AND 
                        n_albums_format.f = temp_canciones.f
            )
            SELECT * FROM FINAL_albums;  

        r_discograficas c_discograficas%ROWTYPE;
        r_ingenieros c_ingenieros%ROWTYPE;
        r_studios c_studios%ROWTYPE;
        r_managers_albums c_managers_albums%ROWTYPE;
        r_managers_conciertos c_managers_conciertos%ROWTYPE;
        r_conciertos c_conciertos%ROWTYPE;
        r_albums c_albums%ROWTYPE;

        BEGIN
            dbms_output.put_line('--------------------INFORME--------------------');
            dbms_output.put_line('----- ' || interprete_actual || CHR(10));

            OPEN c_albums;
            dbms_output.put_line('-*- Albums');
            dbms_output.put_line('FORMATO'|| CHR(9) || CHR(9) || CHR(9) ||'Nº DE ALBUMES' || CHR(9) || CHR(9) || CHR(9) ||'MEDIA DE CANCIONES' || CHR(9) || CHR(9) || CHR(9) ||'DURACION MEDIA' || CHR(9) || CHR(9) || CHR(9) ||'PERIODICIDAD MEDIA');
            dbms_output.put_line('------------------------------------------------------------------------------------------------------------------------------------');
            LOOP 
                FETCH c_albums INTO r_albums;
                EXIT WHEN c_albums%NOTFOUND;

                
                IF r_albums.f = 'C' THEN
                    dbms_output.put_line('CD'|| CHR(9) || CHR(9) || CHR(9) || r_albums.n_albums_format || CHR(9) || CHR(9) || CHR(9) || r_albums.m_canciones || CHR(9) || CHR(9) || CHR(9) || r_albums.m_duration || CHR(9) || CHR(9) || CHR(9) || r_albums.m_periodicidad);
                ELSIF r_albums.f = 'S' THEN
                    dbms_output.put_line('SINGLE'|| CHR(9) || CHR(9) || CHR(9) || r_albums.n_albums_format || CHR(9) || CHR(9) || CHR(9) || r_albums.m_canciones || CHR(9) || CHR(9) || CHR(9) || r_albums.m_duration || CHR(9) || CHR(9) || CHR(9) || r_albums.m_periodicidad);
                ELSIF r_albums.f = 'M' THEN
                    dbms_output.put_line('MP3'|| CHR(9) || CHR(9) || CHR(9) || r_albums.n_albums_format || CHR(9) || CHR(9) || CHR(9) || r_albums.m_canciones || CHR(9) || CHR(9) || CHR(9) || r_albums.m_duration || CHR(9) || CHR(9) || CHR(9) || r_albums.m_periodicidad);
                ELSIF r_albums.f = 'T' THEN
                    dbms_output.put_line('STREAMING'|| CHR(9) || CHR(9) || CHR(9) || r_albums.n_albums_format || CHR(9) || CHR(9) || CHR(9) || r_albums.m_canciones || CHR(9) || CHR(9) || CHR(9) || r_albums.m_duration || CHR(9) || CHR(9) || CHR(9) || r_albums.m_periodicidad);
                ELSIF r_albums.f = 'V' THEN
                    dbms_output.put_line('VYNIL'|| CHR(9) || CHR(9) || CHR(9) || r_albums.n_albums_format || CHR(9) || CHR(9) || CHR(9) || r_albums.m_canciones || CHR(9) || CHR(9) || CHR(9) || r_albums.m_duration || CHR(9) || CHR(9) || CHR(9) || r_albums.m_periodicidad);
                END IF;

            END LOOP;
            CLOSE c_albums;
            dbms_output.put_line(CHR(10));

            OPEN c_conciertos;
            dbms_output.put_line('-*- Conciertos');
            LOOP
                FETCH c_conciertos INTO r_conciertos;
                EXIT WHEN c_conciertos%NOTFOUND;
                dbms_output.put_line('[media de canciones interpretadas = ' || r_conciertos.m_canciones ||'][duracion media = ' || r_conciertos.m_duration || '][periodicidad media = ' || r_conciertos.m_periodicidad ||']');

            END LOOP;
            CLOSE c_conciertos;
            dbms_output.put_line(CHR(10) || CHR(10));


            OPEN c_discograficas;
            dbms_output.put_line('---------Colaboradores---------');
            dbms_output.put_line('-*- Discograficas');
            LOOP
                FETCH c_discograficas INTO r_discograficas;
                EXIT WHEN c_discograficas%NOTFOUND;

                dbms_output.put_line('[nombre = ' || r_discograficas.publisher || '][nº de colaboraciones = ' || r_discograficas.c ||'][% de colaboraciones = ' || r_discograficas.porcentaje*100 || '%]');

            END LOOP;
            CLOSE c_discograficas;
            dbms_output.put_line(CHR(10));


            OPEN c_studios;
            dbms_output.put_line('-*- Studios');
            LOOP
                FETCH c_studios INTO r_studios;
                EXIT WHEN c_studios%NOTFOUND;

                dbms_output.put_line('[nombre = ' || r_studios.studio || '][nº de colaboraciones = ' || r_studios.c ||'][% de colaboraciones = ' || r_studios.porcentaje*100 || '%]');

            END LOOP;
            CLOSE c_studios;
            dbms_output.put_line(CHR(10));


            OPEN c_ingenieros;
            dbms_output.put_line('-*- Ingenieros');
            LOOP
                FETCH c_ingenieros INTO r_ingenieros;
                EXIT WHEN c_ingenieros%NOTFOUND;

                dbms_output.put_line('[nombre = ' || r_ingenieros.engineer || '][nº de colaboraciones = ' || r_ingenieros.c ||'][% de colaboraciones = ' || r_ingenieros.porcentaje*100 || '%]');

            END LOOP;
            CLOSE c_ingenieros;
            dbms_output.put_line(CHR(10));


            OPEN c_managers_albums;
            dbms_output.put_line('-*- Managers de albumes');
            LOOP
                FETCH c_managers_albums INTO r_managers_albums;
                EXIT WHEN c_managers_albums%NOTFOUND;

                dbms_output.put_line('[nombre = ' || r_managers_albums.manager || '][nº de colaboraciones = ' || r_managers_albums.c ||'][% de colaboraciones = ' || r_managers_albums.porcentaje*100 || '%]');

            END LOOP;
            CLOSE c_managers_albums;
            dbms_output.put_line(CHR(10));


            OPEN c_managers_conciertos;
            dbms_output.put_line('-*- Managers de conciertos');
            LOOP
                FETCH c_managers_conciertos INTO r_managers_conciertos;
                EXIT WHEN c_managers_conciertos%NOTFOUND;

                dbms_output.put_line('[nombre = ' || r_managers_conciertos.manager || '][nº de colaboraxciones = ' || r_managers_conciertos.c ||'][% de colaboraciones = ' || r_managers_conciertos.porcentaje*100 || '%]');

            END LOOP;
            CLOSE c_managers_conciertos;
            dbms_output.put_line(CHR(10));

        END informe;
END melopack;

