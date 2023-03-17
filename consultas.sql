with track_info_raw as (
        SELECT 
            pair as pair,
            writer as autor1_track,
            title as titulo_track
        FROM tracks
        ),
    
    song_info as (
        SELECT
            writer as autor1,
            cowriter as autor2,
            title as titulo_song
        FROM songs
        ),

    track_info as (
        SELECT 
            autor1, 
            autor2, 
            titulo_song, 
            pair 
        FROM (
            track_info_raw
            inner JOIN
            song_info
            ON track_info_raw.autor1_track = song_info.autor1 and track_info_raw.titulo_track = song_info.titulo_song
        )
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
            musician as member,
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
                (members.member = performer_tracks.autor1 or members.member = performer_tracks.autor2) and performer_tracks.interprete = members.interprete_2
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
        round(100*(num_numerador_tracks/num_denominador_tracks), 2)||'%' as porcentaje_tracks,
        num_numerador_tracks,
        num_denominador_tracks
    FROM (
        numerador_tracks
        INNER JOIN
        denominador_tracks
        
        ON numerador_tracks.interprete_numerador_tracks = denominador_tracks.interprete_denominador_tracks
    )
    ORDER BY num_numerador_tracks/num_denominador_tracks
    
    





with performer_performances as (
    SELECT
        songtitle as titulo


)