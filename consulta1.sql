
with song_info as (
        SELECT
            writer as autor1,
            cowriter as autor2,
            title as titulo_song
        FROM songs
        ),
    members as (
        SELECT
            musician as member,
            band as band
        FROM involvement
        where end_d is null
    ),

    track_info_raw as (
        SELECT
            pair as pair,
            writer as autor1_track,
            title as titulo_track
        FROM tracks
        ),

    track_info as (
        SELECT 
            autor1, 
            autor2, 
            titulo_song, 
            pair 
        FROM (
            track_info_raw
            INNER JOIN
            song_info
            ON track_info_raw.autor1_track = song_info.autor1 and track_info_raw.titulo_track = song_info.titulo_song
        )
    ),
    performance_info_raw as (
        SELECT DISTINCT
            performer as interprete,
            songtitle as titulo_performance,
            songwriter as autor1_performance
        FROM performances
    ),
    performer_performance as (
        SELECT
            autor1,
            autor2,
            titulo_song,
            interprete
        FROM
            song_info
            INNER JOIN
            performance_info_raw
        ON performance_info_raw.autor1_performance = song_info.autor1 and performance_info_raw.titulo_performance = song_info.titulo_song
    ),
    performer_info as (
        SELECT
           pair as pair,
           performer as interprete
        FROM albums
    ),

    performer_tracks as (
        SELECT 
            autor1, 
            autor2, 
            titulo_song,
            interprete
        FROM (
            track_info
            INNER JOIN
            performer_info 
            ON track_info.pair = performer_info.pair
            )
    ),
    temp_performance as (
       -- añadir el grupo del primer autor
        SELECT
            interprete,
            autor1,
            autor2,
            titulo_song,
            band as band_autor1
        FROM (
            performer_performance
            LEFT OUTER join
            members
            ON members.member = performer_performance.autor1
        ) 
    ),
    tabla_sin_filtrar_performance as(
        -- añadir el grupo del segundo
        SELECT
            interprete,
            autor1,
            autor2,
            titulo_song,
            band_autor1,
            band as band_autor2
        FROM (
            temp_performance
            LEFT OUTER JOIN
            members
            ON members.member = temp_performance.autor2
        )
    ),
    tabla_filtrada_performance as (
        SELECT * FROM tabla_sin_filtrar_performance
        WHERE interprete = band_autor1 or interprete = band_autor2
    ),
    numerador_performance as (
        SELECT 
            performers.name as interprete_numerador_performance,
            count(tabla_filtrada_performance.interprete) as num_numerador_performance
        FROM
            performers
            LEFT OUTER JOIN
            tabla_filtrada_performance
            on performers.name = tabla_filtrada_performance.interprete
        GROUP BY  performers.name
        order by -count(tabla_filtrada_performance.interprete)
    ),
    denominador_performance as (
        SELECT 
            interprete as interprete_denominador_performance,
            count(*) as num_denominador_performance
        FROM tabla_sin_filtrar_performance 
        GROUP BY interprete
    ),
    FINAL_PERFORMANCE as (
        SELECT 
            interprete_numerador_performance as interprete,
            round(100*(num_numerador_performance/num_denominador_performance), 2)||'%' as porcentaje_performance,
            num_numerador_performance,
            num_denominador_performance
        FROM (
            numerador_performance
            INNER JOIN
            denominador_performance
            
            ON numerador_performance.interprete_numerador_performance = denominador_performance.interprete_denominador_performance
        )
        ORDER BY num_numerador_performance/num_denominador_performance
    ),
    -- -----

    temp_tracks as (
        -- añadir el grupo del primer autor
        SELECT
            interprete,
            autor1,
            autor2,
            titulo_song,
            band as band_autor1
        FROM (
            performer_tracks
            LEFT OUTER join
            members
            ON members.member = performer_tracks.autor1
        )
    ),
    tabla_sin_filtrar_tracks as(
        -- añadir el grupo del segundo
        SELECT
            interprete,
            autor1,
            autor2,
            titulo_song,
            band_autor1,
            band as band_autor2
        FROM (
            temp_tracks
            LEFT OUTER JOIN
            members
            ON members.member = temp_tracks.autor2
        )
    ),
    tabla_filtrada_tracks as (
        SELECT * FROM tabla_sin_filtrar_tracks
        WHERE interprete = band_autor1 or interprete = band_autor2
    ),
    numerador_tracks as (
        SELECT 
            performers.name as interprete_numerador_tracks,
            count(tabla_filtrada_tracks.interprete) as num_numerador_tracks
        FROM
            performers
            LEFT OUTER JOIN
            tabla_filtrada_tracks
            on performers.name = tabla_filtrada_tracks.interprete
        GROUP BY  performers.name
        order by -count(tabla_filtrada_tracks.interprete)
    ),

    denominador_tracks as (
        SELECT 
            interprete as interprete_denominador_tracks,
            count(*) as num_denominador_tracks
        FROM tabla_sin_filtrar_tracks 
        GROUP BY interprete
    ),
    
    FINAL_TRACKS as (
        SELECT 
            interprete_numerador_tracks as interprete,
            round(100*(num_numerador_tracks/num_denominador_tracks), 2)||'%' as porcentaje_tracks,
            num_numerador_tracks,
            num_denominador_tracks
        FROM (
            numerador_tracks
            INNER JOIN
            denominador_tracks
            
            ON numerador_tracks.interprete_numerador_tracks = denominador_tracks.interprete_denominador_tracks
        )
    ),

    FINAL as (
        SELECT
            name,
            porcentaje_tracks,
            porcentaje_performance
        FROM (
            performers
            LEFT OUTER JOIN
            FINAL_PERFORMANCE
            ON performers.name = FINAL_PERFORMANCE.interprete
            
            LEFT OUTER JOIN
            FINAL_TRACKS
            ON performers.name = FINAL_TRACKS.interprete

        ) ORDER BY porcentaje_performance
    )
    select * from FINAL
    