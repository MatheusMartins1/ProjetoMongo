from requests import Request, Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
from pymongo import MongoClient
import urllib.parse
import datetime
import json
import pandas as pd
import re
import time

today = datetime.datetime.today()
yesterday = today - datetime.timedelta(days=1)

MONGO_HOST = "localhost" 
MONGO_PORT = "27017"
MONGO_DB = "database"
MONGO_USER = urllib.parse.quote_plus("root")
MONGO_PASS = urllib.parse.quote_plus("P@ssw0rd!")

uri = "mongodb://{}:{}@{}:{}/{}?authSource=admin".format(MONGO_USER, MONGO_PASS, MONGO_HOST, MONGO_PORT, MONGO_DB)
client = MongoClient(uri)
CarteiraDigital = client['CarteiraDigital']
portfolio_ativos = CarteiraDigital['portfolio_ativos']
cotacoes = CarteiraDigital['cotacoes']
info_ativos = CarteiraDigital['info_ativos']


def getCotacaoMercado(stock, contador):
    
    #get API Key - https://www.alphavantage.co/support/#api-key
    apikey = "#"

    url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=' + stock + '&outputsize=full' + '&apikey=' + apikey

    session = Session()
    print("N° request: ", contador, stock, url)
    try:
        response = session.get(url)
        data = json.loads(response.text)
        # print(data)
    except (ConnectionError, Timeout, TooManyRedirects) as e:
        print("Erro: ",e)

    return data


ativos = ['IBM', 'TSLA', 'AAPL', 'MSFT','PETR4.SAO', 'ITSA4.SAO', 'BBDC4.SAO']

resposta = {}
limpar = re.compile('[1-9][.]\s')
contador = 1
for ativo in ativos:

    # Faz consulta
    resposta[ativo] = getCotacaoMercado(ativo, contador)

    # Inclui novo ativo
    for dia in resposta[ativo]['Time Series (Daily)']:

        row_cotacao = {}
        row_cotacao = {
            'Código do Ativo': ativo,
            'Data da cotação': datetime.datetime.fromisoformat(dia),
        }

        for y in resposta[ativo]['Time Series (Daily)'][dia]:
            old_key = y
            new_key = re.sub(limpar, '', y)
            row_cotacao[new_key] = float(
                resposta[ativo]['Time Series (Daily)'][dia][old_key])

        cotacoes.insert_one(row_cotacao)

    if (contador % 4) == 0:
        time.sleep(60)
    contador = contador + 1