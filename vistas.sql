CREATE OR REPLACE VIEW my_album as (
    SELECT
        albums.pair,
        albums.title,
        sum(tracks.duration)

    FROM (
        albums
        INNER JOIN
        tracks

        ON tracks.pair = albums.pair
    )
    WHERE albums.performer = melopack.interprete_actual
    GROUP BY albums.title, album.title
);


