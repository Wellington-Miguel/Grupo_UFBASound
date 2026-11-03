-- Projeto: UFBASound - Gestao de Estudio Musical
-- Disciplina: MATB09 - Laboratorio de Banco de Dados (UFBA)
-- Script 02: Insercao de dados de teste (DML)

-- Insercao de artistas (artista 1 possui varias reservas; artistas 4 e 5 nao possuem reservas)
INSERT INTO artista (id_artista, nome, nome_artistico, documento_identificacao, telefone, email, genero_musical) VALUES
(1, 'Lucas Nascimento Silva', 'Banda Retrovisor', '111.222.333-44', '(71) 98888-1001', 'contato@retrovisor.com.br', 'Rock Alternativo'),
(2, 'Beatriz Santos Oliveira', 'Bia Jazz Trio', '222.333.444-55', '(71) 98777-2002', 'bia.jazz@gmail.com', 'Jazz'),
(3, 'Rafael Gomes de Freitas', 'MC Falcao', '333.444.555-66', '(71) 98666-3003', 'falcao.prod@hotmail.com', 'Trap'),
(4, 'Mariana Lima dos Santos', 'Mari & Violao', '444.555.666-77', '(71) 98555-4004', 'mari.acustico@yahoo.com', 'MPB'),
(5, 'Danilo Caymmi Ribeiro', 'AfroSons Coletivo', '555.666.777-88', '(71) 98444-5005', 'afrosons.salvador@gmail.com', 'Afrobeat'),
(6, 'Juliana Mendes Duarte', 'Duo Harmonia', '666.777.888-99', '(71) 98333-6006', 'duo.harmonia@gmail.com', 'Choro');

-- Insercao de salas de ensaio (salas 4 e 5 nao possuem reservas vinculadas)
INSERT INTO sala_ensaio (id_sala, nome_sala, capacidade_musicos, valor_hora, possui_isolamento_acustico) VALUES
(1, 'Sala Acustica Alpha', 8, 75.00, TRUE),
(2, 'Sala Master Beta', 12, 120.00, TRUE),
(3, 'Studio Live Jam Gamma', 6, 60.00, TRUE),
(4, 'Sala Blackout Delta', 10, 95.00, TRUE),
(5, 'Cabine de Locucao Epsilon', 2, 45.00, TRUE);

-- Insercao de equipamentos do acervo
INSERT INTO equipamento (id_equipamento, nome_equipamento, categoria, numero_serie, preco_diaria, estoque) VALUES
(1, 'Microfone Condensador Neumann U87', 'Microfones', 'NM-U87-9910', 180.00, 3),
(2, 'Microfone Dinamico Shure SM58', 'Microfones', 'SH-SM58-3341', 40.00, 10),
(3, 'Amplificador Valvulado Marshall JCM800', 'Amplificadores', 'MSH-JCM-2021', 110.00, 2),
(4, 'Mesa Digital Behringer X32 Producer', 'Mesas de Som', 'BH-X32P-7744', 150.00, 2),
(5, 'Bateria Acustica Pearl Masters Complete', 'Instrumentos', 'PRL-MC-8812', 130.00, 1),
(6, 'Caixa Ativa JBL EON 715', 'Monitores', 'JBL-EON-5523', 70.00, 4);

-- Insercao de reservas (artista 1 possui as reservas 1 e 3)
INSERT INTO reserva (id_reserva, id_artista, id_sala, data_reserva, hora_inicio, horas_duracao, status, observacoes) VALUES
(1, 1, 1, '2026-03-10', '14:00:00', 3, 'REALIZADA', 'Ensaio geral para gravacao de EP'),
(2, 2, 2, '2026-03-12', '18:00:00', 4, 'CONFIRMADA', 'Gravacao de trio acustico'),
(3, 1, 2, '2026-03-15', '09:00:00', 5, 'AGENDADA', 'Captacao de bateria e guitarras'),
(4, 3, 3, '2026-03-16', '19:00:00', 2, 'AGENDADA', 'Sessao de voz'),
(5, 6, 1, '2026-03-18', '15:00:00', 3, 'AGENDADA', 'Passagem de som');

-- Insercao de equipamentos alugados nas reservas
INSERT INTO item_locacao_equipamento (id_reserva, id_equipamento, quantidade, valor_unitario_cobrado) VALUES
(1, 2, 3, 40.00),
(1, 3, 1, 110.00),
(2, 1, 2, 180.00),
(2, 4, 1, 150.00),
(3, 1, 1, 180.00),
(3, 5, 1, 130.00),
(4, 1, 1, 180.00);
