CREATE OR REPLACE VIEW my_albums as (
    SELECT
        albums.title as t,
        sum(tracks.duration) as d

    FROM (
        albums
        INNER JOIN
        tracks

        ON tracks.pair = albums.pair
    )
    WHERE albums.performer = melopack.get_ia()
    GROUP BY albums.title, albums.pair
)WITH READ ONLY;

CREATE OR REPLACE VIEW events as (
    WITH 
    n_interpretacion as (
        SELECT 
            TO_CHAR(when, 'MM-YYYY'),
            count(*),
            sum(duration) 
        FROM performances
        WHERE albums.performer = melopack.get_ia()
        GROUP BY TO_CHAR(when, 'MM-YYYY')
    )

) WITH READ ONLY;


