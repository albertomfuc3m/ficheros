
WITH n_albums AS (
        SELECT 
            performer AS p,
            format AS f,
            ROUND((MAX(rel_date) - MIN(rel_date))/COUNT(*), 0) AS t, 
            COUNT(*) AS c
        FROM albums
        WHERE performer = 'La Ciudadela'
        GROUP BY format, performer
        ORDER BY performer
    ),
    n_conciertos AS (
        SELECT
            performer,
            count(*)
        FROM concerts
        GROUP BY performer
    ),
    n_tracks as (
        SELECT 
            performer,
            count(*)
        FROM tracks
        GROUP BY performer
    ),
    temp_canciones AS (
        SELECT
            albums.performer AS p,
            albums.format AS f,
            COUNT(*) AS n_canciones,
            SUM(tracks.duration) AS duration_tipo
        FROM albums
        INNER JOIN tracks ON tracks.pair = albums.pair
        GROUP BY albums.performer, albums.format
    ),
    temp_conciertos0 as (
        SELECT
            concerts.performer as p,
            count(*) as total_canciones,
            sum(performances.duration) as total_duration,
            round((MAX(concerts.when) - MIN(concerts.when)), 0) as total_periodo
        FROM (
            concerts
            INNER JOIN
            performances

            ON concerts.performer = performances.performer AND 
            concerts.when = performances.when
        )
        GROUP BY concerts.performer
    ),
    temp_conciertos1 as (
        SELECT 
            performer as p, 
            count(*) as n_conciertos 
        FROM concerts 
        GROUP BY performer
    ),
    discograficas as (
        SELECT 
            performer,
            publisher,
            count(*)
        FROM 
            albums
        GROUP BY performer, publisher
        order by performer
    ),
    ingenieros as (
        SELECT 
            albums.performer,
            tracks.engineer,
            count(*)
        FROM (
            albums
            INNER JOIN
            tracks
            ON tracks.pair = albums.pair
        )
        GROUP BY albums.performer, tracks.engineer
        ORDER BY albums.performer
    ),
    studios as (
        SELECT 
            albums.performer,
            tracks.studio,
            count(*)
        FROM (
            albums
            INNER JOIN
            tracks
            ON tracks.pair = albums.pair
        )
        WHERE tracks.studio is not NULL
        GROUP BY albums.performer, tracks.studio
        ORDER BY PERFORMER

    ),
    managers_album as (
        SELECT 
            performer,
            manager,
            count(*)
        FROM albums
        GROUP BY performer, manager
    ),
    managers_conciertos as (
        SELECT 
            performer,
            manager,
            count(*)
        FROM concerts
        GROUP BY performer, manager
    ),
    FINAL_conciertos as (
        SELECT
            temp_conciertos0.p,
            round(temp_conciertos0.total_canciones/temp_conciertos1.n_conciertos, 1) as media_canciones,
            round(temp_conciertos0.total_duration/temp_conciertos1.n_conciertos, 1) as media_duration,
            round(temp_conciertos0.total_periodo/temp_conciertos1.n_conciertos, 1) as media_periodo
        FROM 
            temp_conciertos0
            INNER JOIN
            temp_conciertos1
            ON temp_conciertos0.p = temp_conciertos1.p
    ),
    FINAL AS (
        SELECT
            n_albums.p AS p,
            n_albums.f AS f,
            n_albums.c AS n_albums,
            n_albums.t AS m_periodicidad,
            TRUNC(temp_canciones.n_canciones/n_albums.c, 1) AS m_canciones,
            TRUNC(temp_canciones.duration_tipo/n_albums.c, 1) AS m_duration
        FROM 
            n_albums
            INNER JOIN temp_canciones 
            ON n_albums.p = temp_canciones.p 
            AND n_albums.f = temp_canciones.f
    )
    select * from managers_conciertos

    
