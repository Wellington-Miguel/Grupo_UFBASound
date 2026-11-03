-- Projeto: UFBASound - Gestao de Estudio Musical
-- Disciplina: MATB09 - Laboratorio de Banco de Dados (UFBA)
-- Script 03: Consultas de negocio (DQL)

-- Q1. Quais equipamentos possuem valor de diaria a partir de R$ 80,00, ordenados do mais caro para o mais barato?
SELECT 
    id_equipamento,
    nome_equipamento,
    categoria,
    numero_serie,
    preco_diaria,
    estoque
FROM 
    equipamento
WHERE 
    preco_diaria >= 80.00
ORDER BY 
    preco_diaria DESC;

-- Q2. Quais sao as reservas agendadas no estudio, informando os dados do artista responsavel e a sala utilizada?
SELECT 
    r.id_reserva,
    r.data_reserva,
    r.hora_inicio,
    r.horas_duracao,
    r.status,
    a.nome_artistico,
    a.nome AS nome_responsavel,
    a.telefone,
    s.nome_sala,
    s.capacidade_musicos,
    s.valor_hora
FROM 
    reserva r
INNER JOIN 
    artista a ON r.id_artista = a.id_artista
INNER JOIN 
    sala_ensaio s ON r.id_sala = s.id_sala
ORDER BY 
    r.data_reserva ASC, r.hora_inicio ASC;

-- Q3. Quais sao todos os artistas cadastrados e suas respectivas reservas, incluindo aqueles que nunca realizaram agendamentos?
SELECT 
    a.id_artista,
    a.nome_artistico,
    a.nome AS nome_completo,
    a.email,
    a.genero_musical,
    r.id_reserva,
    r.data_reserva,
    r.status
FROM 
    artista a
LEFT JOIN 
    reserva r ON a.id_artista = r.id_artista
ORDER BY 
    a.id_artista ASC;

-- Q4. Qual o valor subtotal cobrado por cada item de equipamento locado nas reservas?
SELECT 
    r.id_reserva,
    r.data_reserva,
    a.nome_artistico,
    e.nome_equipamento,
    e.categoria,
    ite.quantidade,
    ite.valor_unitario_cobrado,
    (ite.quantidade * ite.valor_unitario_cobrado) AS subtotal
FROM 
    item_locacao_equipamento ite
INNER JOIN 
    reserva r ON ite.id_reserva = r.id_reserva
INNER JOIN 
    artista a ON r.id_artista = a.id_artista
INNER JOIN 
    equipamento e ON ite.id_equipamento = e.id_equipamento
ORDER BY 
    r.id_reserva ASC, subtotal DESC;
