
WITH 
    n_albums_format AS (
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
    n_albums as (
        SELECT
            performer as p,
            count(*) as c
        FROM albums
        GROUP BY performer
    )
    n_conciertos AS (
        SELECT
            performer as p,
            count(*) as c
        FROM concerts
        GROUP BY performer
    ),
    n_tracks as (
        SELECT 
            albums.performer as p,
            count(*) as c 
        FROM (
            albums
            INNER JOIN
            tracks
            ON tracks.pair = albums.pair
        )
        GROUP BY albums.performer
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
            performer as p,
            publisher,
            count(*) as c
        FROM 
            albums
        GROUP BY performer, publisher
        order by performer
    ),
    FINAL_discograficas as (
        SELECT 
            discograficas.p,
            discograficas.publisher,
            discograficas.c,
            round(discograficas.c/n_albums.c, 2) as porcentaje
        FROM (
            discograficas
            INNER JOIN
            n_albums
            ON discograficas.p = n_albums.p
        )
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
        GROUP BY albums.performer, tracks.engineer
    ),
    FINAL_ingenieros as (
        SELECT 
            ingenieros.p,
            ingenieros.engineer,
            ingenieros.c,
            round(ingenieros.c/n_tracks.c, 2) as porcentaje
        FROM (
            ingenieros
            INNER JOIN
            n_tracks
            ON ingenieros.p = n_tracks.p
        )
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
        WHERE tracks.studio is not NULL
        GROUP BY albums.performer, tracks.studio
        ORDER BY PERFORMER

    ),
    FINAL_studios as (
        SELECT 
            studios.p,
            studios.studio,
            studios.c,
            round(studios.c/n_tracks.c, 2) as porcentaje
        FROM (
            studios
            INNER JOIN
            n_tracks
            ON studios.p = n_tracks.p
        )
    ),
    managers_album as (
        SELECT 
            performer as p,
            manager,
            count(*) as c
        FROM albums
        GROUP BY performer, manager
    ),
    FINAL_managers_album as (
        SELECT 
            managers_album.p,
            managers_album.manager,
            managers_album.c,
            round(managers_album.c/n_albums.c, 2) as porcentaje
        FROM (
            managers_album
            INNER JOIN
            n_albums
            ON managers_album.p = n_albums.p
        )
    ),
    managers_conciertos as (
        SELECT 
            performer as p,
            manager,
            count(*) as c
        FROM concerts
        GROUP BY performer, manager
    ),
    FINAL_managers_conciertos as (
        SELECT 
            managers_conciertos.p,
            managers_conciertos.manager,
            managers_conciertos.c,
            round(managers_conciertos.c/n_conciertos.c, 2) as porcentaje
        FROM (
            managers_conciertos
            INNER JOIN
            n_conciertos
            ON managers_conciertos.p = n_conciertos.p
        )
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
    FINAL_canciones AS (
        SELECT
            n_albums_format.p AS p,
            n_albums_format.f AS f,
            n_albums_format.c AS n_albums_format,
            n_albums_format.t AS m_periodicidad,
            TRUNC(temp_canciones.n_canciones/n_albums_format.c, 1) AS m_canciones,
            TRUNC(temp_canciones.duration_tipo/n_albums_format.c, 1) AS m_duration
        FROM 
            n_albums_format
            INNER JOIN temp_canciones 
            ON n_albums_format.p = temp_canciones.p 
            AND n_albums_format.f = temp_canciones.f
    )
    select * from managers_conciertos

    
