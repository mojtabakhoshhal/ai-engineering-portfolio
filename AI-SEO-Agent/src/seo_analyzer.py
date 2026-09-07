import requests
from bs4 import BeautifulSoup


def analyze_url(url):

    response = requests.get(url, timeout=10)

    soup = BeautifulSoup(
        response.text,
        "html.parser"
    )

    title = soup.title.text if soup.title else "No title"

    return {
        "url": url,
        "status_code": response.status_code,
        "title": title
    }