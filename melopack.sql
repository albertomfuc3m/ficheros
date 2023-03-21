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
END melopack;
/

CREATE OR REPLACE PACKAGE BODY melopack AS
    PROCEDURE asignar(id_interprete VARCHAR2) IS
    BEGIN
        SELECT name
            INTO interprete_actual
            FROM performers
        WHERE name = id_interprete;
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
        pair_album CHAR(10);

        publisher VARCHAR2(50);
        manager NUMBER;
        title_song VARCHAR2(50);
        writer_song CHAR(14);
        studio VARCHAR2(50);

    BEGIN
        IF interprete_actual is not NULL THEN
            -- Comprobar las filas referenciadas
            SELECT 
                pair
                INTO pair_album
                FROM albums
            WHERE pair = id_pair;

            SELECT
                name
                INTO publisher
                FROM publishers
            WHERE name = id_publisher;

            SELECT
                mobile
                INTO manager
                FROM managers
            WHERE mobile = id_manager;

            SELECT
                title,
                writer
                INTO title_song, writer_song
                FROM songs
            WHERE songs.writer = id_writer_song AND songs.title = id_title_song;

            SELECT
                name
                INTO studio
                FROM studios
            WHERE name = id_studio;

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
                (PAIR, sequ, title_song, writer_song, rec_date, studio, engineer, duration)
                VALUES 
                    (id_pair, sequ, title_song, writer_song, rec_date, studio, engineer, duration);
            
            END IF;
        END IF;
    END insertar_album_track;
END melopack;
