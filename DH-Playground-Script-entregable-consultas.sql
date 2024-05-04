/* Obtener los 5 cursos con más unidades: 
Escribe una consulta que devuelva los títulos de los 5 cursos que tienen más unidades. 
Los resultados deben estar ordenados en orden descendente por el número de unidades.*/
USE `dh-playground`;
SELECT
    c.titulo curso,
    COUNT(c.titulo) unidades_x_curso
FROM unidades_cursos u
JOIN cursos c ON u.CURSOS_id = c.id
GROUP BY c.titulo DESC
LIMIT 5;

/* Obtener la media de unidades por curso: 
Escribe una consulta que calcule la media de unidades por curso. 
Los resultados deben estar agrupados por el título del curso. */



/* Obtener los usuarios asociados a más de 3 cursos: 
Escribe una consulta que devuelva los nombres de los usuarios que están asociados a más de 3 cursos. 
Los resultados deben estar ordenados en orden ascendente por el nombre del usuario. */
SELECT 
	u.nombre,
    u.apellido,
    COUNT(cur.CURSOS_id) usuarios_por_curso
FROM cursos_usuarios_rel cur 
JOIN usuarios u ON cur.USUARIOS_id = u.id
GROUP BY cur.USUARIOS_id
HAVING usuarios_por_curso > 3;

/* NO HAY USUARIOS ASOCIADOS A MAS DE 3 CURSOS. Modifico la consulta para obtener resultados */
SELECT 
	u.nombre,
    u.apellido,
    COUNT(cur.CURSOS_id) usuarios_por_curso
FROM cursos_usuarios_rel cur 
JOIN usuarios u ON cur.USUARIOS_id = u.id
GROUP BY cur.USUARIOS_id
HAVING usuarios_por_curso >= 3;


/* Obtener las 10 primeras clases que comienzan después de una fecha determinada:
Escribe una consulta que devuelva las 10 primeras clases que comienzan después de una fecha determinada. 
Los resultados deben estar ordenados en orden ascendente por la fecha de inicio. */

SET @fecha_determinada = '2024-08-05' ; 

SELECT 
	*
FROM
	clases_unidades cu
WHERE
	date(cu.fecha_inicio) > date(@fecha_determinada)
ORDER BY 
	cu.fecha_inicio
LIMIT 10
;


/* Obtener el número de bloques por tipo para una clase específica: 
Escribe una consulta que devuelva el número de bloques por tipo para una clase específica. 
Los resultados deben estar agrupados por el tipo de bloque */

SET @clase_especifico = 2 ; 

SELECT 
    COUNT(id) bloques_por_tipo_para_esta_clase
FROM
	bloques_clases
WHERE CLASES_id = @clase_especifico
GROUP BY tipo
;


/* Obtener el nombre y el apellido de los usuarios, sustituyendo los valores nulos por una cadena vacía: 
Escribe una consulta que devuelva el nombre y el apellido de los usuarios, 
utilizando una función para sustituir los valores nulos por una cadena vacía. */

SELECT 
    COALESCE(nombre, '') nombre,
    COALESCE(apellido, '') apellido
from
	usuarios u;
    
/* Obtener los 3 cursos con la mayor cantidad de usuarios: 
Escribe una consulta que devuelva los títulos de los 3 cursos que tienen más usuarios asociados. 
Los resultados deben estar ordenados en orden descendente por el número de usuarios. */
SELECT
	c.titulo,
    COUNT(cur.USUARIOS_id) usuarios_por_curso
FROM cursos_usuarios_rel cur
JOIN cursos c ON cur.CURSOS_id = c.id
GROUP BY cur.CURSOS_id
ORDER BY usuarios_por_curso DESC
LIMIT 3;

/* Obtener el promedio de clases por unidad para cada curso: 
Escribe una consulta que calcule el promedio de clases por unidad para cada curso. 
Los resultados deben estar agrupados por el título del curso. */

/* Obtener los usuarios con más de 2 cursos que comienzan después de una fecha determinada: 
Escribe una consulta que devuelva los nombres de los usuarios que están asociados a más de 2 cursos que comienzan después de una fecha determinada. 
Los resultados deben estar ordenados en orden ascendente por el nombre del usuario.*/

SET @fecha_determinada = '2024-04-28' ; 

SELECT 
    u.nombre,
    u.apellido,
    c.titulo,
    c.fecha_inicio,
    COUNT(c.id) cursos_por_usuario
FROM cursos_usuarios_rel cur
JOIN usuarios u ON cur.USUARIOS_id = u.id
JOIN cursos c ON cur.CURSOS_id = c.id
GROUP BY u.id
HAVING cursos_por_usuario > 2
AND date(c.fecha_inicio) > date(@fecha_determinada); 


/* Obtener las 5 últimas unidades que comienzan después de una fecha determinada: 
Escribe una consulta que devuelva las 5 últimas unidades que comienzan después de una fecha determinada. 
Los resultados deben estar ordenados en orden descendente por la fecha de inicio. */

SET @fecha_determinada = '2024-06-19'; 

SELECT 
	titulo,
    fecha_inicio
FROM unidades_cursos
WHERE date(fecha_inicio) > date(@fecha_determinada)
ORDER BY fecha_inicio DESC
LIMIT 5;


/* Obtener el número de usuarios por categoría para un curso específico: 
Escribe una consulta que devuelva el número de usuarios por categoría para un curso específico. 
Los resultados deben estar agrupados por la categoría del usuario. */

SET @id_especifico = 2 ; 

SELECT 
	cur.CURSOS_id id_de_curso,
    cu.categoria,
    COUNT(u.id) usuarios_por_categoria
FROM cursos_usuarios_rel cur
JOIN usuarios u ON cur.USUARIOS_id = u.id
JOIN categoria_usuarios cu ON u.CATEGORIA_USUARIOS_id = cu.id
WHERE cur.CURSOS_id = @id_especifico
GROUP BY u.CATEGORIA_USUARIOS_id;
