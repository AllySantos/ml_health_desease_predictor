# MLFlow Docker Setup

Este diretório contém a configuração do Docker para executar o servidor MLFlow em um container.

## Arquivos

- **Dockerfile**: Define a imagem Docker para o MLFlow
- **docker-compose.yml**: Orquestra o container MLFlow com volumes persistentes
- **.dockerignore**: Especifica arquivos a ignorar ao construir a imagem

## Pré-requisitos

- Docker instalado e em execução
- Docker Compose instalado (opcional, mas recomendado)

## Como usar

### Opção 1: Usando Docker Compose (Recomendado)

```bash
# Navegar até o diretório do projeto
cd ml_health_desease_predictor

# Construir e iniciar o container
docker-compose up --build

# Em outro terminal, para parar o container
docker-compose down
```

### Opção 2: Usando Docker CLI

```bash
# Construir a imagem
docker build -t mlflow-server .

# Executar o container
docker run -p 5000:5000 \
  -v $(pwd)/mlartifacts:/app/mlartifacts \
  -v $(pwd)/mlflow.db:/app/mlflow.db \
  mlflow-server
```

No Windows PowerShell, use:
```powershell
docker run -p 5000:5000 `
  -v ${PWD}/mlartifacts:/app/mlartifacts `
  -v ${PWD}/mlflow.db:/app/mlflow.db `
  mlflow-server
```

## Acessar o MLFlow UI

Após iniciar o container, acesse a interface web do MLFlow em:

```
http://localhost:5000
```

## Estrutura de Volumes

- **mlartifacts**: Diretório para armazenar artefatos de modelos
- **mlflow.db**: Banco de dados SQLite para rastrear experimentos e runs

## Variáveis de Ambiente

Você pode customizar o comportamento modificando as variáveis de ambiente no `docker-compose.yml`:

- `MLFLOW_BACKEND_STORE_URI`: URI do backend de armazenamento (padrão: sqlite)
- `MLFLOW_DEFAULT_ARTIFACT_ROOT`: Diretório raiz para artefatos

## Troubleshooting

### Porta 5000 já em uso
Se a porta 5000 já está em uso, altere o mapeamento no `docker-compose.yml`:
```yaml
ports:
  - "8000:5000"  # Mapear para porta 8000 localmente
```

### Permissões de arquivo
Se encontrar problemas de permissão com volumes, verifique se o usuário tem permissão de leitura/escrita nos diretórios `mlartifacts` e `mlflow.db`.
