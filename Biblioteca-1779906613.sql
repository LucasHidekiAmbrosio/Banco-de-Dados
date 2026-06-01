
DROP DATABASE IF EXISTS biblioteca;

CREATE DATABASE IF NOT EXISTS biblioteca;

USE biblioteca;

-- =========================
-- TABELA CATEGORIAS
-- =========================
CREATE TABLE IF NOT EXISTS categorias
(
    id_categoria INT(4) PRIMARY KEY AUTO_INCREMENT,
    codigo_categoria VARCHAR(10) UNIQUE,
    descricao VARCHAR(100),
    area_conhecimento VARCHAR(50) NOT NULL,
    data_cadastro DATE NOT NULL,
    status_categoria VARCHAR(20) NOT NULL
);

-- Inserção de registros
INSERT INTO categorias VALUES
(1,'CAT001', 'Literatura Brasileira', 'Literatura', '2025-01-10', 'Ativa'),
(2,'CAT002', 'Ficção Distópica', 'Literatura', '2025-01-11', 'Ativa'),
(3,'CAT003', 'Fantasia', 'Literatura', '2025-01-12', 'Ativa'),
(4,'CAT004', 'História', 'Ciências Humanas', '2025-01-13', 'Ativa'),
(5,'CAT005', 'Tecnologia', 'Tecnologia', '2025-01-14', 'Ativa');

-- =========================
-- TABELA AUTORES
-- =========================
CREATE TABLE IF NOT EXISTS autores
(
    id_autor INT(4) PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50),
    data_nascimento DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    status_autor VARCHAR(20) NOT NULL
);

-- Inserção de registros
INSERT INTO autores VALUES
(1,'Machado de Assis', 'Brasileira', '1839-06-21', 'machado@academia.com', 'falecido'),
(2,'George Orwell', 'Britânica', '1903-06-25', 'orwell@classicos.com', 'falecido'),
(3,'J. K. Rowling', 'Britânica', '1965-07-31', 'jkrowling@hogwarts.com', 'Ativo'),
(4,'Yuval Noah Harari', 'Israelense', '1976-02-24', 'harari@history.com', 'Ativo'),
(5,'Robert C. Martin', 'Americana', '1952-12-05', 'unclebob@cleancode.com', 'Ativo');

-- =========================
-- TABELA EDITORAS
-- =========================
CREATE TABLE IF NOT EXISTS editoras
(
    id_editora INT(4) PRIMARY KEY AUTO_INCREMENT,
    nome_editora VARCHAR(100) NOT NULL,
    pais_origem VARCHAR(50) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    ano_fundacao INT NOT NULL
);

-- Inserção de registros
INSERT INTO editoras VALUES
(1,'Companhia das Letras', 'Brasil', '(11)3707-3500', 'contato@companhiadasletras.com.br', 1986),
(2,'Penguin Books', 'Reino Unido', '(44)0207139000', 'contact@penguin.co.uk', 1935),
(3,'Bloomsbury Publishing', 'Reino Unido', '(44)02076314900', 'info@bloomsbury.com', 1986),
(4,'HarperCollins', 'Estados Unidos', '(1)2122077000', 'contact@harpercollins.com', 1989),
(5,'Prentice Hall', 'Estados Unidos', '(1)8009220579', 'info@prenticehall.com', 1913);

-- =========================
-- TABELA LIVROS
-- =========================
CREATE TABLE IF NOT EXISTS livros
(
    isbn VARCHAR(20) PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    ano_publicacao INT NOT NULL,
    id_editora INT(4),
    id_categoria INT(4),
    id_autor INT(4),

    FOREIGN KEY (id_editora)
        REFERENCES editoras(id_editora),

    FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria),

    FOREIGN KEY (id_autor)
        REFERENCES autores(id_autor)
);

-- Inserção de registros
INSERT INTO livros VALUES
('9788535914849', 'Dom Casmurro', 1899, 1, 1, 1),
('9780451524935', '1984', 1949, 2, 2, 2),
('9788532530783', 'Harry Potter e a Pedra Filosofal', 1997, 3, 3, 3),
('9788535925692', 'Sapiens: Uma Breve História da Humanidade', 2011, 4, 4, 4),
('9780132350884', 'Clean Code', 2008, 5, 5, 5);

-- =========================
-- TABELA USUARIO
-- =========================

CREATE TABLE IF NOT EXISTS usuario
(
    id_usuario INT(11) PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf DECIMAL(11) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    data_cadastro DATE,
    status_usuario VARCHAR(20)
);

-- Inserção de registros
INSERT INTO usuario VALUES
(1,'João Pedro Almeida', '147.258.369-00', 'joao.almeida@gmail.com', '(11)99872-5521', '2025-01-10', 'Ativo'),
(2,'Maria Eduarda Souza', '284.731.596-11', 'maria.souza@hotmail.com', '(21)99711-8834', '2025-01-12', 'Ativo'),
(3,'Carlos Henrique Lima', '395.842.617-22', 'carlos.lima@yahoo.com', '(31)99654-1122', '2025-01-15', 'Inativo'),
(4,'Ana Clara Ferreira', '518.274.963-33', 'ana.ferreira@outlook.com', '(41)99988-7711', '2025-01-18', 'Ativo'),
(5,'Lucas Gabriel Martins', '726.381.495-44', 'lucas.martins@gmail.com', '(51)99777-6655', '2025-01-20', 'Suspenso');

-- =========================
-- TABELA EMPRESTIMOS
-- =========================
CREATE TABLE IF NOT EXISTS emprestimos
(
    id_emprestimo INT(6) PRIMARY KEY AUTO_INCREMENT,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE NOT NULL,
    status_emprestimo VARCHAR(20) NOT NULL,
    isbn VARCHAR(20),
    id_usuario INT(11),

    FOREIGN KEY (isbn) REFERENCES livros(isbn),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)

);

-- Inserção de registros
INSERT INTO emprestimos VALUES
(1, '2025-05-01', '2025-05-10', 'Devolvido', '9788535914849', 1),
(2, '2025-05-03', '2025-05-15', 'Em andamento', '9780451524935', 2),
(3, '2025-05-05', '2025-05-20', 'Atrasado', '9788532530783', 3),
(4, '2025-05-08', '2025-05-18', 'Devolvido', '9788535925692', 4),
(5, '2025-05-10', '2025-05-25', 'Em andamento', '9780132350884', 5);


