CREATE OR REPLACE VIEW my_albums as 
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
WITH READ ONLY;

CREATE OR REPLACE VIEW events as 
    WITH 
    n_interpretacion as (
        SELECT 
            TO_CHAR(when, 'MM-YYYY') as fecha,
            count(*) as total_interpretacion,
            avg(duration) as m_duration
        FROM performances
        WHERE performances.performer = melopack.get_ia()
        GROUP BY TO_CHAR(when, 'MM-YYYY')
    ),
    n_conciertos as (
        SELECT 
            TO_CHAR(when, 'MM-YYYY') as fecha,
            count(*) as total_conciertos
        FROM concerts
        WHERE concerts.performer = melopack.get_ia()
        GROUP BY TO_CHAR(when, 'MM-YYYY')
    ),
    n_espectadores as (
        SELECT 
            TO_CHAR(when, 'MM-YYYY') as fecha,
            count(*) as total_espectadores
        FROM attendances
        WHERE attendances.performer = melopack.get_ia()
        GROUP BY TO_CHAR(when, 'MM-YYYY')
    ),
    FINAL as (
        SELECT 
            n_conciertos.fecha as fecha,
            n_conciertos.total_conciertos as n_conciertos,
            n_espectadores.total_espectadores as n_espectadores,
            round(n_interpretacion.m_duration, 2) as media_duracion,
            round(n_interpretacion.total_interpretacion/n_conciertos.total_conciertos, 2) as media_interpretaciones
        FROM (
            
            n_conciertos
            INNER JOIN
            n_espectadores
            ON n_conciertos.fecha = n_espectadores.fecha
            

            INNER JOIN 
            n_interpretacion
            ON 
                n_interpretacion.fecha = n_conciertos.fecha

        )
    )
    SELECT * FROM FINAL

WITH READ ONLY;


CREATE OR REPLACE VIEW fans 
    WITH interprete_valido as (
        SELECT 
            performer as p
        FROM concerts
        WHERE performer = melopack.get_ia()
        GROUP BY performer
        HAVING count(*) > 1
        
    ),
    FINAL as (
        SELECT 
            clients.e_mail,
            clients.name,
            clients.surn1,
            clients.surn2,
            trunc((SYSDATE - clients.birthdate)/365, 0)
        FROM (
            clients
            INNER JOIN
            (SELECT * 
            FROM 
                attendances
                INNER JOIN
                interprete_valido
                ON attendances.performer = interprete_valido.p
            )
            ON attendances.client = client.e_mail
        )
    )
