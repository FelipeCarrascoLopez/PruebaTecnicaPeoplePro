CREATE TABLE IF NOT EXISTS dim_usuarios (
    id SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS fact_publicaciones (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES dim_usuarios(id),
    titulo VARCHAR(200) NOT NULL,
    cuerpo TEXT NOT NULL
);
