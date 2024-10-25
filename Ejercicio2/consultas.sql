-- Consultas
SELECT Libros.titulo, Autores.nombre
FROM Libros
JOIN Autores ON Libros.autor_id = Autores.id_autor
JOIN Categorias ON Libros.categoria_id = Categorias.id_categoria
WHERE Categorias.nombre = 'Ficción';

SELECT AVG(precio) AS precio_promedio FROM Libros;

UPDATE Libros SET precio = precio * 0.90 WHERE autor_id = 5;

SELECT * FROM Libros WHERE autor_id = 5;