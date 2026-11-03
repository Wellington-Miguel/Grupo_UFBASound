-- Projeto: UFBASound - Gestao de Estudio Musical
-- Disciplina: MATB09 - Laboratorio de Banco de Dados (UFBA)
-- Script 01: Criacao do esquema relacional (DDL)

-- Tabela de artistas e bandas clientes do estudio
CREATE TABLE artista (
    id_artista INT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    nome_artistico VARCHAR(100),
    documento_identificacao VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    genero_musical VARCHAR(50) NOT NULL
);

-- Tabela de salas fisicas disponiveis para ensaio e gravacao
CREATE TABLE sala_ensaio (
    id_sala INT PRIMARY KEY,
    nome_sala VARCHAR(80) NOT NULL UNIQUE,
    capacidade_musicos INT NOT NULL CHECK (capacidade_musicos > 0),
    valor_hora NUMERIC(10, 2) NOT NULL CHECK (valor_hora >= 0),
    possui_isolamento_acustico BOOLEAN NOT NULL DEFAULT TRUE
);

-- Tabela de equipamentos disponiveis para locacao avulsa nas sessoes
CREATE TABLE equipamento (
    id_equipamento INT PRIMARY KEY,
    nome_equipamento VARCHAR(120) NOT NULL,
    categoria VARCHAR(60) NOT NULL,
    numero_serie VARCHAR(60) NOT NULL UNIQUE,
    preco_diaria NUMERIC(10, 2) NOT NULL CHECK (preco_diaria >= 0),
    estoque INT NOT NULL CHECK (estoque >= 0)
);

-- Tabela de reservas de salas (relacionamentos 1:N com artista e sala_ensaio)
CREATE TABLE reserva (
    id_reserva INT PRIMARY KEY,
    id_artista INT NOT NULL,
    id_sala INT NOT NULL,
    data_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    horas_duracao INT NOT NULL CHECK (horas_duracao > 0),
    status VARCHAR(20) NOT NULL CHECK (status IN ('AGENDADA', 'CONFIRMADA', 'REALIZADA', 'CANCELADA')),
    observacoes VARCHAR(255),
    FOREIGN KEY (id_artista) REFERENCES artista(id_artista),
    FOREIGN KEY (id_sala) REFERENCES sala_ensaio(id_sala)
);

-- Tabela associativa que resolve o relacionamento N:N entre reserva e equipamento
CREATE TABLE item_locacao_equipamento (
    id_reserva INT NOT NULL,
    id_equipamento INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    valor_unitario_cobrado NUMERIC(10, 2) NOT NULL CHECK (valor_unitario_cobrado >= 0),
    PRIMARY KEY (id_reserva, id_equipamento),
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
    FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento)
);
