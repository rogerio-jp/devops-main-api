FROM python:3.13.5-alpine3.22


# Defina variáveis ​​de ambiente para melhorar o comportamento do contêiner
# PYTHONDONTWRITEBYTECODE: Impede que o Python grave arquivos .pyc no disco
# PYTHONUNBUFFERED: Garante que a saída do Python seja enviada diretamente para o terminal sem ser armazenada em buffer primeiro
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie o arquivo de dependências primeiro para aproveitar o cache de camada do Docker
COPY requirements.txt .

# Instale as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copie o restante do código do aplicativo para o diretório de trabalho
COPY . .

# Exponha a porta na qual o aplicativo é executado
EXPOSE 8000

# Defina o comando para executar o aplicativo quando o contêiner iniciar
# Use 0.0.0.0 para torná-lo acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


