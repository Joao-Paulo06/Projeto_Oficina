
SELECT nome, especialidade FROM Mecanico;


SELECT placa, modelo, ano FROM Veiculo
WHERE marca = 'Fiat' AND ano < 2015;


SELECT
    id_os,
    SUM(quantidade * valor_peca_unitario) AS custo_total_pecas
FROM OS_Peca
GROUP BY id_os;


SELECT
    C.nome AS nome_cliente,
    V.placa,
    V.marca,
    V.modelo
FROM Cliente C
JOIN Veiculo V ON C.id_cliente = V.id_cliente
ORDER BY C.nome ASC, V.modelo ASC;


SELECT
    M.nome AS nome_mecanico,
    SUM(EM.horas_trabalhadas) AS total_horas_trabalhadas
FROM Mecanico M
JOIN Equipe_Mecanico EM ON M.id_mecanico = EM.id_mecanico
GROUP BY M.nome
HAVING SUM(EM.horas_trabalhadas) > 3.0
ORDER BY total_horas_trabalhadas DESC;


WITH TotalPecas AS (
    SELECT
        id_os,
        SUM(quantidade * valor_peca_unitario) AS custo_pecas
    FROM OS_Peca
    GROUP BY id_os
),

TotalServicos AS (
    SELECT
        OSS.id_os,
        SUM(OSS.quantidade * S.valor_mao_obra) AS custo_mao_obra
    FROM OS_Servico OSS
    JOIN Servico S ON OSS.id_servico = S.id_servico
    GROUP BY OSS.id_os
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


SELECT
    OS.id_os,
    M.nome AS nome_mecanico,
    EM.horas_trabalhadas,
    M.salario,
    (M.salario / 160) AS custo_hora_estimado, 
    (EM.horas_trabalhadas * (M.salario / 160)) AS custo_mao_obra_mecanico 
FROM Ordem_Servico OS
JOIN Equipe_Mecanico EM ON OS.id_os = EM.id_os
JOIN Mecanico M ON EM.id_mecanico = M.id_mecanico
ORDER BY OS.id_os, M.nome;


SELECT DISTINCT
    M.nome AS nome_mecanico,
    M.especialidade
FROM Mecanico M
JOIN Equipe_Mecanico EM ON M.id_mecanico = EM.id_mecanico
JOIN Ordem_Servico OS ON EM.id_os = OS.id_os
WHERE OS.valor_total > 300.00;
