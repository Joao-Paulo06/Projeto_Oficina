
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE
);


CREATE TABLE Mecanico (
    id_mecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2)
);


CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa CHAR(7) NOT NULL UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT,
    cor VARCHAR(20),
    id_cliente INT,
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);


CREATE TABLE Ordem_Servico (
    id_os INT PRIMARY KEY AUTO_INCREMENT,
    data_emissao DATE NOT NULL,
    data_conclusao DATE,
    valor_total DECIMAL(10, 2) DEFAULT 0.00,
    status_os ENUM('Aberta', 'Em Andamento', 'Concluída', 'Cancelada') NOT NULL,
    id_veiculo INT,
    CONSTRAINT fk_os_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
);


CREATE TABLE Servico (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL UNIQUE,
    valor_mao_obra DECIMAL(10, 2) NOT NULL
);


CREATE TABLE Peca (
    id_peca INT PRIMARY KEY AUTO_INCREMENT,
    nome_peca VARCHAR(100) NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL
);


CREATE TABLE OS_Servico (
    id_os INT,
    id_servico INT,
    quantidade INT NOT NULL, 
    PRIMARY KEY (id_os, id_servico),
    CONSTRAINT fk_oss_os FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    CONSTRAINT fk_oss_servico FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);


CREATE TABLE OS_Peca (
    id_os INT,
    id_peca INT,
    quantidade INT NOT NULL, 
    valor_peca_unitario DECIMAL(10, 2) NOT NULL, 
    PRIMARY KEY (id_os, id_peca),
    CONSTRAINT fk_osp_os FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    CONSTRAINT fk_osp_peca FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);


CREATE TABLE Equipe_Mecanico (
    id_os INT,
    id_mecanico INT,
    horas_trabalhadas DECIMAL(5, 2),
    PRIMARY KEY (id_os, id_mecanico),
    CONSTRAINT fk_em_os FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os),
    CONSTRAINT fk_em_mecanico FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico)
);
