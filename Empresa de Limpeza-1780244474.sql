DROP DATABASE IF EXISTS limpeza;

CREATE DATABASE IF NOT EXISTS limpeza;

USE limpeza;

-- =========================
-- TABELA CLIENTES
-- =========================
CREATE TABLE IF NOT EXISTS cliente
(
    id_cliente INT(4) PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    data_cadastro DATE NOT NULL
);

-- Inserção de registros
INSERT INTO cliente VALUES
(1,'João Pedro Almeida','147.258.369-00','joao@gmail.com','(11)99999-1111','2025-01-10'),
(2,'Maria Eduarda Souza','258.369.147-11','maria@hotmail.com','(21)99999-2222','2025-01-12'),
(3,'Carlos Henrique Lima','369.147.258-22','carlos@yahoo.com','(31)99999-3333','2025-01-15'),
(4,'Ana Clara Ferreira','741.852.963-33','ana@outlook.com','(41)99999-4444','2025-01-18'),
(5,'Lucas Gabriel Martins','852.963.741-44','lucas@gmail.com','(51)99999-5555','2025-01-20');

-- =========================
-- TABELA CATEGORIA
-- =========================
CREATE TABLE IF NOT EXISTS categoria
(
    id_categoria INT(4) PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL,
    setor VARCHAR(50) NOT NULL,
    nivel_prioridade INT NOT NULL,
    observacao VARCHAR(150) NOT NULL,
    data_criacao DATE NOT NULL
);

-- Inserção de registros
INSERT INTO categoria VALUES
(1,'Detergentes','Limpeza Doméstica',1,'Produtos para lavar louças','2025-01-10'),
(2,'Desinfetantes','Limpeza Doméstica',1,'Produtos para higienização de ambientes','2025-01-11'),
(3,'Sabões','Lavanderia',2,'Produtos para lavagem de roupas','2025-01-12'),
(4,'Limpeza Pesada','Industrial',1,'Produtos de limpeza concentrados','2025-01-13'),
(5,'Higiene','Higiene e Limpeza',2,'Produtos de higiene pessoal','2025-01-14');

-- =========================
-- TABELA PRODUTO
-- =========================
CREATE TABLE IF NOT EXISTS produto
(
    id_produto INT(4) PRIMARY KEY AUTO_INCREMENT,
    descricao_produto VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    estoque_atual INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    id_categoria INT(4),

    FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
);

-- Inserção de registros
INSERT INTO produto VALUES
(1,'Detergente Neutro 500ml','Ypê',150,3.99,1),
(2,'Desinfetante Lavanda 2L','Veja',100,8.50,2),
(3,'Sabão em Pó 1kg','OMO',80,15.90,3),
(4,'Cloro Ativo 5L','Brilhante',50,22.90,4),
(5,'Álcool Líquido 70% 1L','Tupi',120,9.99,5);

-- =========================
-- TABELA PEDIDO
-- =========================
CREATE TABLE IF NOT EXISTS pedido
(
    id_pedido INT(6) PRIMARY KEY AUTO_INCREMENT,
    data_emissao DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    status_pedido VARCHAR(30) NOT NULL,
    id_cliente INT(4),

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

-- Inserção de registros
INSERT INTO pedido VALUES
(1,'2025-05-01',39.90,'Pix','Entregue',1),
(2,'2025-05-03',25.50,'Cartão de Crédito','Em andamento',2),
(3,'2025-05-05',45.80,'Boleto','Pago',3),
(4,'2025-05-08',22.90,'Pix','Entregue',4),
(5,'2025-05-10',19.98,'Cartão de Débito','Em andamento',5);

-- =========================
-- TABELA ITEM_PEDIDO
-- =========================
CREATE TABLE IF NOT EXISTS item_pedido
(
    id_item INT(6) PRIMARY KEY AUTO_INCREMENT,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    observacao VARCHAR(100) NOT NULL,
    id_pedido INT(6),
    id_produto INT(4),

    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto)
);

-- Inserção de registros
INSERT INTO item_pedido VALUES
(1,10,3.99,'Entrega imediata',1,1),
(2,3,8.50,'Sem observações',2,2),
(3,2,15.90,'Sem observações',3,3),
(4,1,22.90,'Uso industrial',4,4),
(5,2,9.99,'Cliente solicitou embalagem reforçada',5,5);