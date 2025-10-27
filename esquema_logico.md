# Esquema Lógico - Oficina Mecânica

Este documento descreve o esquema lógico do banco de dados para o contexto de uma oficina mecânica. O modelo relacional foi projetado para gerenciar clientes, veículos, ordens de serviço, peças, serviços e a equipe de mecânicos.

## Entidades e Atributos

### 1. Cliente
Gerencia as informações dos clientes que utilizam os serviços da oficina.
| Atributo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id_cliente` | INT | PK, NOT NULL, AUTO_INCREMENT | Identificador único do cliente. |
| `nome` | VARCHAR(100) | NOT NULL | Nome completo do cliente. |
| `cpf` | CHAR(11) | NOT NULL, UNIQUE | Cadastro de Pessoa Física. |
| `endereco` | VARCHAR(255) | | Endereço completo do cliente. |
| `telefone` | VARCHAR(15) | | Telefone de contato. |
| `email` | VARCHAR(100) | UNIQUE | E-mail do cliente. |

### 2. Veiculo
Armazena os dados dos veículos pertencentes aos clientes.
| Atributo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id_veiculo` | INT | PK, NOT NULL, AUTO_INCREMENT | Identificador único do veículo. |
| `placa` | CHAR(7) | NOT NULL, UNIQUE | Placa do veículo. |
| `marca` | VARCHAR(50) | NOT NULL | Marca do veículo (ex: Fiat, Ford). |
| `modelo` | VARCHAR(50) | NOT NULL | Modelo do veículo (ex: Palio, Fiesta). |
| `ano` | INT | | Ano de fabricação. |
| `cor` | VARCHAR(20) | | Cor do veículo. |
| `id_cliente` | INT | FK (Cliente) | Cliente proprietário do veículo. |

### 3. Mecanico
Gerencia os dados dos mecânicos que trabalham na oficina.
| Atributo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id_mecanico` | INT | PK, NOT NULL, AUTO_INCREMENT | Identificador único do mecânico. |
| `nome` | VARCHAR(100) | NOT NULL | Nome completo do mecânico. |
| `especialidade` | VARCHAR(50) | NOT NULL | Área de especialidade (ex: Motor, Elétrica). |
| `salario` | DECIMAL(10, 2) | | Salário base. |

### 4. Ordem_Servico (OS)
Representa a abertura de um trabalho na oficina.
| Atributo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id_os` | INT | PK, NOT NULL, AUTO_INCREMENT | Identificador único da Ordem de Serviço. |
| `data_emissao` | DATE | NOT NULL | Data de abertura da OS. |
| `data_conclusao` | DATE | | Data de conclusão do serviço. |
| `valor_total` | DECIMAL(10, 2) | DEFAULT 0.00 | Valor total da OS (serviços + peças). |
| `status_os` | ENUM | NOT NULL | Status da OS (Ex: Aberta, Em Andamento, Concluída, Cancelada). |
| `id_veiculo` | INT | FK (Veiculo) | Veículo associado à OS. |

### 5. Servico
Catálogo de serviços oferecidos pela oficina.
| Atributo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id_servico` | INT | PK, NOT NULL, AUTO_INCREMENT | Identificador único do serviço. |
| `descricao` | VARCHAR(100) | NOT NULL, UNIQUE | Nome ou descrição breve do serviço. |
| `valor_mao_obra` | DECIMAL(10, 2) | NOT NULL | Custo da mão de obra para o serviço. |

### 6. Peca
Catálogo de peças utilizadas nos reparos.
| Atributo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id_peca` | INT | PK, NOT NULL, AUTO_INCREMENT | Identificador único da peça. |
| `nome_peca` | VARCHAR(100) | NOT NULL | Nome da peça. |
| `valor_unitario` | DECIMAL(10, 2) | NOT NULL | Preço de venda da peça. |
| `quantidade_estoque` | INT | NOT NULL | Quantidade em estoque. |

## Relacionamentos (Tabelas Associativas)

### 7. OS_Servico
Associa uma Ordem de Serviço a um ou mais Serviços.
| Atributo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id_os` | INT | PK, FK (Ordem_Servico) | Chave estrangeira para Ordem de Serviço. |
| `id_servico` | INT | PK, FK (Servico) | Chave estrangeira para Serviço. |
| `quantidade` | INT | NOT NULL | Quantidade de vezes que o serviço foi realizado (ex: horas). |

### 8. OS_Peca
Associa uma Ordem de Serviço a uma ou mais Peças utilizadas.
| Atributo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id_os` | INT | PK, FK (Ordem_Servico) | Chave estrangeira para Ordem de Serviço. |
| `id_peca` | INT | PK, FK (Peca) | Chave estrangeira para Peça. |
| `quantidade` | INT | NOT NULL | Quantidade de peças utilizadas. |
| `valor_peca_unitario` | DECIMAL(10, 2) | NOT NULL | Valor unitário da peça no momento da OS (para histórico). |

### 9. Equipe_Mecanico
Associa um ou mais Mecânicos a uma Ordem de Serviço.
| Atributo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id_os` | INT | PK, FK (Ordem_Servico) | Chave estrangeira para Ordem de Serviço. |
| `id_mecanico` | INT | PK, FK (Mecanico) | Chave estrangeira para Mecânico. |
| `horas_trabalhadas` | DECIMAL(5, 2) | | Horas dedicadas pelo mecânico à OS. |

## Diagrama Relacional (Resumo)

- **Cliente** (1) -- (N) **Veiculo**
- **Veiculo** (1) -- (N) **Ordem_Servico**
- **Ordem_Servico** (N) -- (N) **Servico** (via `OS_Servico`)
- **Ordem_Servico** (N) -- (N) **Peca** (via `OS_Peca`)
- **Ordem_Servico** (N) -- (N) **Mecanico** (via `Equipe_Mecanico`)
