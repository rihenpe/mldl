SELECT u.username
     , u.id AS 'id_usuario'
     , u.sexo
     , u.cargo
     , u.city
     , u.classe
     , u.data_admissao
     , u.data_nascimento
     , u.estado
     , u.exercicio
     , u.matricula
     , u.lotacao
     , c.id AS 'id_evento'
     , c.fullname AS 'evento'
     , c.category AS 'id_categoria'
     , ct.name as 'Nome Categoria'
     , FROM_UNIXTIME(c.startdate, '%Y-%m-%d') AS 'data_inicio'
     , FROM_UNIXTIME(c.enddate, '%Y-%m-%d') AS 'data_termino'
     , gg.finalgrade AS 'nota_final' 
FROM mdl_grade_grades gg 
LEFT JOIN mdl_grade_items gi ON gg.itemid=gi.id 
LEFT JOIN mdl_user u  ON gg.userid=u.id 
LEFT JOIN mdl_course c ON gi.courseid=c.id 
LEFT JOIN mdl_course_categories ct on ct.id = c.category
WHERE gg.itemid IN (
   SELECT id FROM mdl_grade_items WHERE courseid IN (
      SELECT id FROM mdl_course WHERE startdate>=1514772000 -- '2018-01-01'
      ) AND itemtype='course'
) and c.category in (4,5,41,42,50,52,59,67,68,69,70) -- cursos autoinstrucionais, com acompanhamento docente e esses arquivados