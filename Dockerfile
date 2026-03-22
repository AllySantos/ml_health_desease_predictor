# Use a imagem oficial do Python
FROM python:3.11-slim

# Definir o diretório de trabalho no container
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copiar os arquivos de requisitos
COPY requirements.txt .

# Instalar as dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# Instalar MLFlow
RUN pip install --no-cache-dir mlflow

# Copiar o código da aplicação
COPY . .

# Expor a porta padrão do MLFlow
EXPOSE 5000

# Comando para iniciar o servidor MLFlow
CMD ["mlflow", "server", "--host", "0.0.0.0", "--port", "5000", "--backend-store-uri", "sqlite:///mlflow.db", "--default-artifact-root", "./mlartifacts"]
