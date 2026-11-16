# Home Server — Stack Docker

Infraestrutura local gerenciada via Docker Compose e `Makefile` para mídia, downloads, bloqueio de anúncios na rede e painel de controle.

## Serviços

| Serviço | Imagem | Porta | Descrição |
| :--- | :--- | :--- | :--- |
| **Jellyfin** | `jellyfin/jellyfin:latest` | `8096` | Servidor de mídia. |
| **AdGuard Home** | `adguard/adguardhome:latest` | `host` | DNS local e bloqueador de anúncios/rastreadores. |
| **Transmission** | `lscr.io/linuxserver/transmission:latest` | `9091`, `51413` | Cliente BitTorrent para gerenciamento de downloads. |
| **Homarr** | `ghcr.io/homarr-labs/homarr:latest` | `7575` | Dashboard central para monitoramento e acesso rápido aos serviços. |
| **TinyMediaManager** | `jlesage/tinymediamanager:latest` | `5800` | Organizador de metadados e arquivos de mídia (profile `manual`). |

## Estrutura do Projeto

```text
.
├── .env                 # Variáveis de ambiente locais (ignorado pelo Git)
├── .env.example         # Modelo de variáveis de ambiente
├── .gitignore           # Regras de arquivos ignorados
├── docker-compose.yml   # Definição dos serviços e volumes
├── Makefile             # Atalhos de gerenciamento dos containers
└── README.md            # Documentação do projeto

```

## Configuração Inicial

1. **Crie o arquivo de variáveis de ambiente** a partir do modelo:
```bash
cp .env.example .env

```


2. **Edite o arquivo `.env**` preenchendo as credenciais, IDs de usuário e o caminho da biblioteca de mídia:
```env
PUID=1000
PGID=1000
TZ=America/Sao_Paulo
MEDIA_PATH=/home/user/media

TRANSMISSION_USER=seu_usuario
TRANSMISSION_PASS=sua_senha

HOMARR_SECRET_KEY=sua_chave_secreta_hex

```


3. **Inicie os serviços principais:**
```bash
make up

```



## Comandos Disponíveis (`Makefile`)

Execute `make help` na raiz do projeto para listar os atalhos:

| Comando | Ação |
| --- | --- |
| `make up` | Inicia todos os serviços padrão em background. |
| `make down` | Para e remove os containers padrão. |
| `make restart` | Reinicia os serviços em execução. |
| `make ps` | Lista os containers ativos e suas portas. |
| `make status` | Exibe os processos em execução dentro dos containers. |
| `make logs` | Acompanha os logs em tempo real (`Ctrl+C` para sair). |
| `make pull` | Baixa as versões mais recentes das imagens. |
| `make up-tmm` | Inicia o **TinyMediaManager** sob demanda. |
| `make down-tmm` | Para e remove apenas o container do **TinyMediaManager**. |
| `make clean` | Para os containers e **remove todos os volumes** (apaga configurações). |
| `make prune` | Limpa containers parados, redes ociosas e cache não utilizado. |

## Persistência de Dados

* **Configurações e Cache:** Armazenados em *Named Volumes* gerenciados pelo Docker (`jellyfin_config`, `jellyfin_cache`, `adguard_work`, `adguard_conf`, `transmission_config`, `homarr_appdata`, `tmm_config`).
* **Biblioteca de Mídia:** Mapeada via *bind mount* através da variável `MEDIA_PATH` para `/media` nos containers do Jellyfin, Transmission e TinyMediaManager.

