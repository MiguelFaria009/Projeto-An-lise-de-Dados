
# 📊 Projeto: Análise de Dados de Impressões e Clicks com Dados de Perfil no Google BigQuery

Este projeto SQL tem como objetivo realizar uma análise combinada de impressões e cliques de campanhas publicitárias, cruzando informações com dados de segmentação comportamental (Krux/OGNCluster) dentro do ecossistema de dados do Google BigQuery.

## ⚙️ Funcionalidades

- Consolidação de dados de impressões (`admanager_prepimpressions`).
- Enriquecimento das impressões com dados de metadados (`ambient`) e clusters (`krux`).
- Cálculo do volume de cliques atrelados a cada impressão.
- Desconstrução do campo de cluster comportamental (`krux.list`) para análise individualizada.
- Enriquecimento cruzado com uma tabela auxiliar (`tabela_krux`) contendo detalhes adicionais dos clusters.
- Possibilidade de filtrar por campanhas específicas (`OrderId`).

## 🔗 Estrutura do Script SQL

Ver o arquivo `script.sql` incluído neste repositório.

## 🔐 Observações Importantes

- Todos os nomes de projetos e datasets foram anonimizados no script.
- Substitua `projeto.dataset` pelos valores do seu ambiente no Google BigQuery.
- O filtro `OrderId IN (123456789)` deve ser ajustado para a campanha que você deseja analisar.
- O campo `krux` é tratado como uma lista separada por vírgulas e desconstruído utilizando `SPLIT()`.

## 📁 Estrutura Esperada das Tabelas

### 🔸 Tabela: `admanager_prepimpressions`
- pdate
- OrderId
- LineItemId
- City
- DeviceCategory
- CreativeSize
- GloboMetadata (RECORD com campo `key_value`)
- ognCluster (RECORD com campo `key_value`)
- TimeUsec2
- KeyPart

### 🔸 Tabela: `admanager_prepclicks`
- pdate
- OrderId
- TimeUsec2
- KeyPart

### 🔸 Tabela: `tabela_krux`
- ID (identificador do cluster)
- Outros campos descritivos do cluster (nome, categoria, etc.)

## 🚀 Como Executar

1. Acesse seu projeto no Google BigQuery.
2. Crie uma nova consulta SQL.
3. Cole o script disponível em `script.sql`.
4. Substitua os nomes dos datasets e IDs conforme seu ambiente.
5. Execute a consulta.

## 📜 Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
