
INSERT INTO Cliente (nome, cpf, endereco, telefone, email) VALUES
('João Silva', '12345678901', 'Rua A, 100, Centro', '11987654321', 'joao.silva@email.com'),
('Maria Oliveira', '98765432109', 'Av. B, 250, Bairro Novo', '21998765432', 'maria.o@email.com'),
('Pedro Souza', '11223344556', 'Rua C, 50, Vila Velha', '31988776655', 'pedro.souza@email.com');


INSERT INTO Mecanico (nome, especialidade, salario) VALUES
('Carlos Mendes', 'Motor', 3500.00),
('Ana Lúcia', 'Elétrica', 3200.00),
('Ricardo Gomes', 'Suspensão', 3100.00);


INSERT INTO Veiculo (placa, marca, modelo, ano, cor, id_cliente) VALUES
('ABC1234', 'Fiat', 'Palio', 2010, 'Prata', 1),
('XYZ9876', 'Ford', 'Fiesta', 2015, 'Vermelho', 2),
('DEF5678', 'Chevrolet', 'Onix', 2020, 'Preto', 3),
('GHI0000', 'Fiat', 'Uno', 2005, 'Branco', 1);


INSERT INTO Ordem_Servico (data_emissao, data_conclusao, status_os, id_veiculo) VALUES
('2023-10-01', '2023-10-05', 'Concluída', 1), 
('2023-10-10', NULL, 'Em Andamento', 2), 
('2023-10-15', '2023-10-15', 'Concluída', 3), 
('2023-10-20', NULL, 'Aberta', 4); 


INSERT INTO Servico (descricao, valor_mao_obra) VALUES
('Troca de Óleo e Filtro', 80.00),
('Revisão Completa do Motor', 450.00),
('Reparo Elétrico', 120.00),
('Alinhamento e Balanceamento', 90.00);


INSERT INTO Peca (nome_peca, valor_unitario, quantidade_estoque) VALUES
('Filtro de Óleo', 25.00, 100),
('Óleo Motor 5W30 (Litro)', 40.00, 500),
('Vela de Ignição', 30.00, 200),
('Pneu Aro 15', 350.00, 50);


INSERT INTO OS_Servico (id_os, id_servico, quantidade) VALUES
(1, 1, 1),
(1, 2, 1);


INSERT INTO OS_Servico (id_os, id_servico, quantidade) VALUES
(2, 3, 2); 


INSERT INTO OS_Servico (id_os, id_servico, quantidade) VALUES
(3, 4, 1);


INSERT INTO OS_Servico (id_os, id_servico, quantidade) VALUES
(4, 1, 1);


INSERT INTO OS_Peca (id_os, id_peca, quantidade, valor_peca_unitario) VALUES
(1, 1, 1, 25.00),
(1, 2, 4, 40.00);


INSERT INTO OS_Peca (id_os, id_peca, quantidade, valor_peca_unitario) VALUES
(2, 3, 2, 30.00);


INSERT INTO OS_Peca (id_os, id_peca, quantidade, valor_peca_unitario) VALUES
(4, 1, 1, 25.00),
(4, 2, 3, 40.00);


INSERT INTO Equipe_Mecanico (id_os, id_mecanico, horas_trabalhadas) VALUES
(1, 1, 5.0),
(1, 2, 3.5);


INSERT INTO Equipe_Mecanico (id_os, id_mecanico, horas_trabalhadas) VALUES
(2, 2, 2.0);


INSERT INTO Equipe_Mecanico (id_os, id_mecanico, horas_trabalhadas) VALUES
(3, 3, 1.0);


INSERT INTO Equipe_Mecanico (id_os, id_mecanico, horas_trabalhadas) VALUES
(4, 1, 1.5);


UPDATE Ordem_Servico SET valor_total = 715.00 WHERE id_os = 1;


UPDATE Ordem_Servico SET valor_total = 300.00, data_conclusao = '2023-10-12', status_os = 'Concluída' WHERE id_os = 2;


UPDATE Ordem_Servico SET valor_total = 90.00 WHERE id_os = 3;


UPDATE Ordem_Servico SET valor_total = 225.00 WHERE id_os = 4;
