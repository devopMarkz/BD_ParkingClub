-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS parkingClub DEFAULT CHARACTER SET utf8 ;
USE parkingClub;

-- Tabela de Tipos de Usuário
CREATE TABLE TiposUsuario (
    tipo_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);

-- Preenchendo a tabela de Tipos de Usuário com os tipos
INSERT INTO TiposUsuario (tipo) VALUES
('Cliente'),
('Funcionário'),
('Desconhecido'),
('Administrador');

-- Tabela de Usuários
CREATE TABLE Usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    tipo_de_usuario INT,
    FOREIGN KEY (tipo_de_usuario) REFERENCES TiposUsuario(tipo_id)
);

-- Tabela de Carros
CREATE TABLE Carros (
    carro_id INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(20) UNIQUE NOT NULL
);

-- Tabela de Estacionamento para controlar entrada e saída em tempo real
CREATE TABLE Estacionamento (
    estacionamento_id INT AUTO_INCREMENT PRIMARY KEY,
    carro_id INT,
    usuario_id INT,
    data_entrada DATETIME NOT NULL,
    data_saida DATETIME,
    valor_pago DECIMAL(10,2),  -- Supondo um valor em decimal para o pagamento
    FOREIGN KEY (carro_id) REFERENCES Carros(carro_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabela de Registro de Entrada/Saída
CREATE TABLE RegistroEntradaSaida (
    registro_id INT AUTO_INCREMENT PRIMARY KEY,
    carro_id INT,
    usuario_id INT,
    data_entrada DATETIME NOT NULL,
    data_saida DATETIME,
    valor_pago DECIMAL(10,2),
    FOREIGN KEY (carro_id) REFERENCES Carros(carro_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);



select * from usuarios;
select * from TiposUsuario;
select * from estacionamento;
select * from carros;
select * from registroentradasaida;


-- /Primero o Cadastro/
INSERT INTO Usuarios (nome, cpf, email, senha, tipo_de_usuario)
VALUES ('Marcos', '61713947340', 'marcosandre@gmail.com', '123456', 1);


-- /Segundo o cadastro da placa no momento da reserva/
INSERT INTO carros (placa)
VALUES ('ROG0A32');

/*Terceiro o é momento em o carro é registrado pela cancela */
INSERT INTO estacionamento (carro_id, usuario_id, data_entrada, data_saida, valor_pago)
VALUES ('1', '1', '2024-05-08 10:30:00', null, null);

/*Quarto o é momento em que a cancela sai do estacionamento */
-- Atualizar a data de saída e o valor pago para um registro específico na tabela Estacionamento
UPDATE Estacionamento
SET data_saida = '2024-05-08 15:45:00', valor_pago = 25.50
WHERE estacionamento_id = 1;

/*Quinto é o momento que passa as informações para tabela registro */