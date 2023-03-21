CREATE OR REPLACE PACKAGE melopack AS
    -- global
    interprete_actual VARCHAR2(50);
  
    PROCEDURE asignar(id_interprete VARCHAR2);
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
END melopack;

