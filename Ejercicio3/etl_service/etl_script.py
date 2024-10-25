import requests
import psycopg2
import os
import logging
import time
from contextlib import contextmanager

# Configuración de logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Configuración de la conexión a PostgreSQL desde las variables de entorno
DB_CONFIG = {
    'dbname': os.getenv('DB_NAME'),
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'host': os.getenv('DB_HOST'),
    'port': os.getenv('DB_PORT')
}

# URLs de la API
API_URLS = {
    'users': 'https://jsonplaceholder.typicode.com/users',
    'posts': 'https://jsonplaceholder.typicode.com/posts'
}

@contextmanager
def get_db_connection():
    """Context manager para la conexión a la base de datos."""
    conn = None
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        yield conn
    except Exception as e:
        logging.error(f"Error en la conexión a la base de datos: {e}")
        if conn:
            conn.rollback()
    finally:
        if conn:
            conn.close()

def wait_for_postgres():
    """Función para esperar a que PostgreSQL esté listo para aceptar conexiones."""
    while True:
        try:
            with psycopg2.connect(**DB_CONFIG):
                logging.info("PostgreSQL está listo para aceptar conexiones.")
                break  # Conexión exitosa
        except psycopg2.OperationalError:
            logging.info("Esperando a que PostgreSQL esté listo...")
            time.sleep(5)  # Esperar 5 segundos antes de volver a intentar

def fetch_data_from_api(url):
    """Función para extraer datos de la API JSONPlaceholder."""
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        logging.error(f"Error al obtener datos de la API: {e}")
        return []

def load_users_into_db(users):
    """Inserta los usuarios en la base de datos."""
    insert_user_query = """
    INSERT INTO dim_usuarios (id, nombre_usuario, email)
    VALUES (%s, %s, %s)
    ON CONFLICT (id) DO NOTHING;
    """
    
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            for user in users:
                cur.execute(insert_user_query, (user['id'], user['name'], user['email']))
            conn.commit()
            logging.info(f"Usuarios cargados correctamente: {len(users)} registros intentados.")

def load_posts_into_db(posts):
    """Inserta las publicaciones en la base de datos."""
    insert_post_query = """
    INSERT INTO fact_publicaciones (id, id_usuario, titulo, cuerpo)
    VALUES (%s, %s, %s, %s)
    ON CONFLICT (id) DO NOTHING;
    """
    
    with get_db_connection() as conn:
        with conn.cursor() as cur:
            for post in posts:
                cur.execute("SELECT 1 FROM dim_usuarios WHERE id = %s", (post['userId'],))
                if cur.fetchone():  # Verifica si el usuario existe
                    cur.execute(insert_post_query, (post['id'], post['userId'], post['title'], post['body']))
                else:
                    logging.warning(f"Usuario con id {post['userId']} no encontrado, omitiendo publicación {post['id']}.")
            conn.commit()
            logging.info(f"Publicaciones cargadas correctamente: {len(posts)} registros intentados.")

def etl_process():
    """Proceso ETL principal."""
    logging.info("Iniciando el proceso ETL...")

    # Extraer los datos
    users = fetch_data_from_api(API_URLS['users'])
    posts = fetch_data_from_api(API_URLS['posts'])

    # Cargar los datos en la base de datos
    if users:
        load_users_into_db(users)
    if posts:
        load_posts_into_db(posts)

    logging.info("Proceso ETL completado.")

if __name__ == "__main__":
    wait_for_postgres()  # Esperar a que PostgreSQL esté listo
    etl_process()
