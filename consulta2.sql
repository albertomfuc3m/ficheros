with tracks_info_raw as (
        SELECT 
            pair as pair,
            writer as autor1,
            title as titulo,
            recording_date as f_grabacion
        FROM tracks
        ),
    performer_info as (
        SELECT
           pair as pair,
           performer as interprete
        FROM albums
    ),
    tracks_info as (
        SELECT 
            autor1, 
            titulo,
            interprete
        FROM (
            tracks_info
            INNER JOIN
            performer_info 
            ON tracks_info.pair = performer_info.pair
            )
    ),
    performance_info as (
        SELECT DISTINCT
            performer as interprete,
            songtitle as titulo,
            songwriter as autor1,
            when as f_interpretacion
        FROM performances
    ),
    temp as (
        SELECT * FROM (
           tracks_info
           RIGHT OUTER JOIN
           performance_info

           ON tracks_info.interprete = performance_info.interprete AND
           tracks_info.titulo = performance_info.titulo AND
           tracks_info.autor1 = performance_info.autor1
        )

    )