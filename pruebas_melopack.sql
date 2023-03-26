----------------------------------PRUEBA-1-1----------------------------------

EXEC melopack.asignar('Cunegunda');
dbms_output.put_line(melopack.get_ia());

-- este artista no existe, es un fantasma
EXEC melopack.asignar('RIKI GONZ');
dbms_output.put_line(melopack.get_ia());