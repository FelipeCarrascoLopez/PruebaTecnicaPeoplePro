# api_client.py
import requests
from config import API_URL

class APIClient:
    def __init__(self, base_url):
        self.base_url = base_url

    def get_books(self, page=1):
        try:
            response = requests.get(self.base_url, params={'page': page}, timeout=10)
            response.raise_for_status()
            return response.json()
        except requests.Timeout:
            print("La solicitud ha superado el tiempo de espera.")
            return None
        except requests.RequestException as e:
            print(f"Error al realizar la solicitud: {e}")
            return None
