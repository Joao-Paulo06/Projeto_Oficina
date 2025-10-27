# Projeto de Banco de Dados para Oficina Mecânica

## Contexto do Projeto

Este projeto foi desenvolvido como parte de um desafio de modelagem e implementação de Banco de Dados, focado no contexto de uma **Oficina Mecânica**. O objetivo principal foi traduzir um esquema conceitual (Modelo Entidade-Relacionamento) em um **Esquema Lógico Relacional** completo e, posteriormente, implementar este esquema em SQL, popular o banco com dados de teste e demonstrar a capacidade de análise de dados através de queries complexas.

## Esquema Lógico Relacional

O esquema lógico foi projetado para gerenciar as principais entidades e seus relacionamentos dentro de uma oficina, conforme detalhado abaixo.

### Visão Geral das Entidades

| Entidade | Descrição | Chave Primária | Chaves Estrangeiras |
| :--- | :--- | :--- | :--- |
| `Cliente` | Informações dos proprietários dos veículos. | `id_cliente` | - |
| `Veiculo` | Dados dos veículos que recebem serviço. | `id_veiculo` | `id_cliente` (Proprietário) |
| `Mecanico` | Informações da equipe de trabalho. | `id_mecanico` | - |
| `Ordem_Servico` (OS) | Registro de um trabalho aberto na oficina. | `id_os` | `id_veiculo` |
| `Servico` | Catálogo de serviços de mão de obra. | `id_servico` | - |
| `Peca` | Catálogo de peças em estoque. | `id_peca` | - |
| `OS_Servico` | Relacionamento N:N entre OS e Serviço. | `id_os`, `id_servico` | `id_os`, `id_servico` |
| `OS_Peca` | Relacionamento N:N entre OS e Peça utilizada. | `id_os`, `id_peca` | `id_os`, `id_peca` |
| `Equipe_Mecanico` | Relacionamento N:N entre OS e Mecânico. | `id_os`, `id_mecanico` | `id_os`, `id_mecanico` |

### Detalhes do Esquema

O arquivo `esquema_logico.md` contém a descrição completa de cada tabela, incluindo atributos, tipos de dados e restrições.

## Estrutura do Repositório

O projeto está organizado nos seguintes arquivos SQL:

| Arquivo | Conteúdo | Propósito |
| :--- | :--- | :--- |
| `esquema_logico.md` | Documentação do Esquema Lógico. | Detalha as tabelas, atributos e relacionamentos. |
| `schema.sql` | Script de Criação de Tabelas. | Contém todos os `CREATE TABLE` com chaves primárias e estrangeiras. |
| `data.sql` | Script de Persistência de Dados. | Contém todos os `INSERT INTO` para popular o banco para testes. |
| `queries.sql` | Queries de Análise de Dados. | Demonstra o uso de `SELECT`, `WHERE`, `ORDER BY`, `HAVING`, atributos derivados e `JOIN`s complexos. |

## Queries de Análise (Demonstração)

O arquivo `queries.sql` demonstra a capacidade de análise do esquema, incluindo os seguintes requisitos:

1.  **Recuperações Simples:** Seleção de nomes e especialidades de mecânicos.
2.  **Filtros (`WHERE`):** Veículos da marca 'Fiat' e ano anterior a 2015.
3.  **Atributos Derivados:** Cálculo do custo total de peças por Ordem de Serviço.
4.  **Ordenação (`ORDER BY`):** Listagem de clientes e veículos em ordem alfabética.
5.  **Filtros em Grupos (`HAVING`):** Identificação de mecânicos com mais de 3 horas de trabalho total.
6.  **Junções Complexas (`JOIN`):** Cálculo do valor total de mão de obra e peças para Ordens de Serviço concluídas, juntando dados de 6 tabelas.

Exemplo de Query Complexa (Cálculo de Custo Total por OS Concluída):

```sql


WITH TotalPecas AS (
   
),
TotalServicos AS (
   
)
SELECT
    OS.id_os,
    C.nome AS nome_cliente,
    V.placa,
    OS.status_os,
    COALESCE(TS.custo_mao_obra, 0.00) AS total_mao_de_obra,
    COALESCE(TP.custo_pecas, 0.00) AS total_pecas,
    (COALESCE(TS.custo_mao_obra, 0.00) + COALESCE(TP.custo_pecas, 0.00)) AS valor_calculado_total,
    OS.valor_total AS valor_registrado_total
FROM Ordem_Servico OS
JOIN Veiculo V ON OS.id_veiculo = V.id_veiculo
JOIN Cliente C ON V.id_cliente = C.id_cliente
LEFT JOIN TotalServicos TS ON OS.id_os = TS.id_os
LEFT JOIN TotalPecas TP ON OS.id_os = TP.id_os
WHERE OS.status_os = 'Concluída'
ORDER BY OS.id_os;
```

