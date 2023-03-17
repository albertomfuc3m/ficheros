with track_info as (
        SELECT 
            pair as pair,
            writer as autor,
            title as titulo
        FROM tracks
        ),

    performer_info as (
        SELECT
           pair as pair,
           performer as interprete
        FROM albums
        ),

    performer_tracks as (
        SELECT * FROM (
            track_info
            INNER JOIN
            performer_info 
            ON track_info.pair = performer_info.pair
            )
        ),

    members as (
        SELECT
            musician as autor_2,
            band as interprete_2
        FROM involvement
        ),

    numerador_tracks as (
        SELECT
            interprete as interprete_numerador_tracks, 
            count(*) as num_numerador_tracks
        FROM(
                performer_tracks
                INNER JOIN
                members
                ON
                performer_tracks.autor = members.autor_2 and performer_tracks.interprete = members.interprete_2
            ) 
        GROUP BY interprete
        ),

    denominador_tracks as (
        SELECT 
            interprete as interprete_denominador_tracks,
            count(*) as num_denominador_tracks
        FROM performer_tracks 
        GROUP BY interprete
    )

    SELECT 
        interprete_numerador_tracks,
        num_numerador_tracks,
        num_denominador_tracks,
        num_numerador_tracks/num_denominador_tracks as porcentaje_tracks
    FROM (
        numerador_tracks
        INNER JOIN
        denominador_tracks
        
        ON numerador_tracks.interprete_numerador_tracks = denominador_tracks.interprete_denominador_tracks
    )
    ORDER BY num_numerador_tracks/num_denominador_tracks
    
    
    
    
    
    
    