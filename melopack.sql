CREATE OR REPLACE PACKAGE melopack AS
    -- global
    interprete_actual VARCHAR2(50);
  
    PROCEDURE asignar(id_interprete VARCHAR2);
    PROCEDURE insertar_album_track(
        pair CHAR,
        format CHAR,
        title, VARCHAR2,
        rel_date DATE,
        publisher VARCHAR2,
        manager NUMBER,

        sequ NUMBER,
        title_song VARCHAR2,
        id_writer_song CHAR,
        id_duration NUMBER,
        rec_date DATE,
        studio VARCHAR2,
        engineer VARCHAR2
    );
END melopack;


CREATE OR REPLACE PACKAGE BODY melopack AS
    PROCEDURE asignar(id_interprete VARCHAR2) AS
    BEGIN
        SELECT name
            INTO interprete_actual
            FROM performers
        WHERE name = id_inteprete;
    END asignar;
  
    PROCEDURE insertar_album_track(
        id_pair CHAR,
        format CHAR,
        title, VARCHAR2,
        rel_date DATE,
        publisher VARCHAR2,
        id_manager NUMBER,

        sequ NUMBER,
        id_title_song VARCHAR2,
        id_writer_song CHAR,
        duration NUMBER,
        rec_date DATE,
        id_studio VARCHAR2,
        engineer VARCHAR2
    )
        title_song VARCHAR2;
        writer_song CHAR;
        pair CHAR;
        manager NUMBER
        studio VARCHAR2;

    BEGIN
        IF interprete_actual is not NULL THEN (

            -- Comprobar las filas referenciadas

            SELECT
                title,
                song
                INTO title_song, writer_song
                FROM songs
            WHERE title = id_title_song AND song = id_writer_song;

            SELECT
                pair
                INTO pair
                FROM albums
            WHERE pair = id_studio;

            SELECT
                name
                INTO studio
                FROM studios
            WHERE name = id_studio;

            IF  title_song is NOT NULL AND 
                writer_song is NOT NULL AND 
                (studio is NOT NULL or id_studio is NULL) THEN (
                -- Existe la cancion y el estudio referenciado

                IF pair is NOT NULL THEN (
                    -- Si no existe el album
                    INSERT INTO albums
                        pair, performer, format, title, rel_date, publisher, manager



                )


            )
        )
    END insertar_album_track;
END melopack;
