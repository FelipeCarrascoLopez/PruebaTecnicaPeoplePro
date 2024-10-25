sudo -i -u postgres

psql

CREATE USER test_db WITH PASSWORD '1243';

CREATE DATABASE nombre_base_de_datos OWNER nombre_usuario;

GRANT ALL PRIVILEGES ON DATABASE nombre_base_de_datos TO nombre_usuario;

\q

exit


