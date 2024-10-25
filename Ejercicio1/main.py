# main.py
import csv
from api_client import APIClient
from config import API_URL

def save_to_csv(books, filename):
    with open(filename, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        # Escribir encabezados
        writer.writerow(['Título', 'Autor(es)'])
        
        # Escribir datos de los libros
        for book in books:
            title = book.get('title', 'Sin título')
            authors = ', '.join(author['name'] for author in book.get('authors', []))
            writer.writerow([title, authors])

def main():
    client = APIClient(API_URL)
    all_books = []

    # Obtener libros de las dos primeras páginas
    for page in range(1, 3):
        data = client.get_books(page)
        if data:
            all_books.extend(data.get('results', []))

    # Calcular el número total de libros
    total_books = len(all_books)
    print(f"Número total de libros en las 2 primeras páginas: {total_books}")

    # Guardar los datos en un archivo CSV
    save_to_csv(all_books, 'books.csv')
    print("Datos guardados en 'books.csv'.")

if __name__ == "__main__":
    main()
