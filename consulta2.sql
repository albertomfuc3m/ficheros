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

    performance_info_grouped as (
        SELECT DISTINCT
            performer as interprete,
            songtitle as titulo,
            songwriter as autor1
        FROM performances
    ),
    
    pre_denominador as (
        SELECT
            performance_info_grouped.interprete as p_interprete,
            performance_info_grouped.titulo as p_titulo,
            performance_info_grouped.autor1 as p_autor1,
            tracks_info.f_grabacion as t_fecha
        FROM (
            performance_info_grouped
            LEFT OUTER JOIN
            tracks_info
            
            ON tracks_info.interprete = performance_info_grouped.interprete AND
            tracks_info.titulo = performance_info_grouped.titulo AND
            tracks_info.autor1 = performance_info_grouped.autor1
        )
    ),

    denominador_porcentaje as (
        SELECT 
            p_interprete,
            count(*) as denominador
        FROM 
            pre_denominador
        GROUP BY p_interprete
    ),
    pre_numerador as (
        SELECT * FROM pre_denominador WHERE t_fecha is not NULL
    ),

    numerador_porcentaje as (
        SELECT 
            performers.name as p_interprete,
            count(pre_numerador.p_interprete) as numerador
        FROM
            performers
            LEFT OUTER JOIN
            pre_numerador
            on pre_numerador.p_interprete = performers.name
        GROUP BY  performers.name
    ),
    
    porcentaje as (
        SELECT 
            numerador_porcentaje.p_interprete,
            round(100*(numerador_porcentaje.numerador/denominador_porcentaje.denominador), 2)||'%' as porcentaje
        FROM (
            numerador_porcentaje
            INNER JOIN
            denominador_porcentaje
            
            ON numerador_porcentaje.p_interprete = denominador_porcentaje.p_interprete
        )
        
    ),
    temp as (
        SELECT
            performance_info.interprete as p_interprete,
            performance_info.titulo as p_titulo,
            performance_info.autor1 as p_autor1,
            performance_info.f_interpretacion as p_fecha,
            f_grabacion as t_fecha,
            tracks_info.autor1 as t_autor1,
            tracks_info.interprete as t_interprete
            -- ,f_interpretacion - f_grabacion as intervalo,
            -- round((f_interpretacion - f_grabacion)/365,0) as YEARS,
            -- round(MOD(f_interpretacion - f_grabacion, 365)/30,0) as MONTHS,
            -- MOD(MOD(f_interpretacion - f_grabacion, 365),30) as DAYS
        FROM (
           performance_info
           LEFT OUTER JOIN
           tracks_info

           ON tracks_info.interprete = performance_info.interprete AND
           tracks_info.titulo = performance_info.titulo AND
           tracks_info.autor1 = performance_info.autor1
        ) order by p_interprete
        
    ),
    pre_porcentaje as (
        SELECT
            p_interprete,
            p_titulo,
            p_autor1,
            count(*)
        FROM temp
        GROUP BY 
            p_interprete,
            p_titulo,
            p_autor1
   )
   select * from porcentaje