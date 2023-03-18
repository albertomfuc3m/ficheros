with tracks_info_raw as (
        SELECT 
            pair as pair,
            writer as autor1,
            title as titulo,
            rec_date as f_grabacion
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
            interprete,
            min(f_grabacion) as f_grabacion
        FROM (
            tracks_info_raw
            INNER JOIN
            performer_info 
            ON tracks_info_raw.pair = performer_info.pair
            )
        GROUP BY autor1, titulo, interprete
    ),
    performance_info as (
        SELECT
            performer as interprete,
            songtitle as titulo,
            songwriter as autor1,
            when as f_interpretacion
        FROM performances
    ),
    temp as (
        SELECT
            tracks_info.interprete as t_interprete,
            tracks_info.titulo as t_titulo,
            tracks_info.autor1 as t_autor1,
            f_grabacion as t_fecha,
            performance_info.interprete as p_interprete,
            performance_info.titulo as p_titulo,
            performance_info.autor1 as p_autor1,
            performance_info.f_interpretacion as p_fecha,
            numtoyminterval((f_interpretacion - f_grabacion)/30, 'MONTH'),
            numtodsinterval(mod((f_interpretacion - f_grabacion),30), 'DAY')
        FROM (
           performance_info
           left outer join
           tracks_info

           ON tracks_info.interprete = performance_info.interprete AND
           tracks_info.titulo = performance_info.titulo AND
           tracks_info.autor1 = performance_info.autor1
        )

    )
    
    select * from temp