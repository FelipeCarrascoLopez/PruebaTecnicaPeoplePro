-- Crear tabla Autores
CREATE TABLE IF NOT EXISTS Autores (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(100)
);

-- Crear tabla Categorías
CREATE TABLE IF NOT EXISTS Categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear tabla Libros
CREATE TABLE IF NOT EXISTS Libros (
    id_libro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor_id INT REFERENCES Autores(id_autor) ON DELETE CASCADE,
    categoria_id INT REFERENCES Categorias(id_categoria) ON DELETE SET NULL,
    precio DECIMAL(10, 2) NOT NULL
);

-- Insertar datos en Autores
INSERT INTO Autores (nombre, nacionalidad)
VALUES
('Gabriel García Márquez', 'Colombiana'),
('J.K. Rowling', 'Británica'),
('Haruki Murakami', 'Japonesa'),
('Isabel Allende', 'Chilena'),
('George Orwell', 'Británica');

-- Insertar datos en Categorías
INSERT INTO Categorias (nombre)
VALUES
('Novela'),
('Fantasía'),
('Ciencia Ficción'),
('Realismo Mágico'),
('Distopía'),
('Ficción');

-- Insertar datos en Libros
INSERT INTO Libros (titulo, autor_id, categoria_id, precio)
VALUES
('Cien Años de Soledad', 1, 4, 15000),
('Harry Potter y la Piedra Filosofal', 2, 2, 12000),
('Kafka en la Orilla', 3, 1, 10000),
('La Casa de los Espíritus', 4, 4, 14000),
('1984', 5, 5, 9000),
('Animal Farm', 5, 6, 9500);


SELECT Libros.titulo, Autores.nombre
FROM Libros
JOIN Autores ON Libros.autor_id = Autores.id_autor
JOIN Categorias ON Libros.categoria_id = Categorias.id_categoria
WHERE Categorias.nombre = 'Ficción';

SELECT AVG(precio) AS precio_promedio
FROM Libros;

UPDATE Libros
SET precio = precio * 0.90
WHERE autor_id = 5;

SELECT * FROM Libros WHERE autor_id = 5;
