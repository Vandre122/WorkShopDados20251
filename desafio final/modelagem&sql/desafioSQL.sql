CREATE SCHEMA LojaDepartamentos;
USE LojaDepartamentos;
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE Departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE ItemPedido (
    id_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Inserir Clientes
INSERT INTO Cliente (nome, cpf, email) VALUES
('João Silva', '123.456.789-00', 'joao.silva@email.com'),
('Maria Oliveira', '987.654.321-00', 'maria.oliveira@email.com');

-- Inserir Departamentos
INSERT INTO Departamento (nome, descricao) VALUES
('Eletrônicos', 'Produtos eletrônicos em geral'),
('Vestuário', 'Roupas e acessórios');

-- Inserir Produtos
INSERT INTO Produto (nome, preco, quantidade_estoque, id_departamento) VALUES
('Smartphone', 1500.00, 10, 1),
('Notebook', 3500.00, 5, 1),
('Camiseta', 50.00, 20, 2);

-- Inserir Pedidos
INSERT INTO Pedido (id_cliente, data_pedido, valor_total) VALUES
(1, '2023-10-01', 1500.00),
(2, '2023-10-02', 3550.00);

-- Inserir Itens de Pedido
INSERT INTO ItemPedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 1500.00),
(2, 2, 1, 3500.00),
(2, 3, 1, 50.00);

-- Total de produtos em estoque por departamento
SELECT d.nome AS Departamento, SUM(p.quantidade_estoque) AS Total_Estoque
FROM Produto p
JOIN Departamento d ON p.id_departamento = d.id_departamento
GROUP BY d.nome;

-- Valor total gasto por cliente
SELECT c.nome AS Cliente, SUM(p.valor_total) AS Total_Gasto
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
GROUP BY c.nome;

-- Quantidade de pedidos por cliente
SELECT c.nome AS Cliente, COUNT(p.id_pedido) AS Total_Pedidos
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
GROUP BY c.nome;

-- Listar todos os pedidos com detalhes do cliente
SELECT c.nome AS Cliente, p.data_pedido, p.valor_total
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente;

-- Listar todos os itens de pedido com detalhes do produto
SELECT ip.id_pedido, pr.nome AS Produto, ip.quantidade, ip.preco_unitario
FROM ItemPedido ip
JOIN Produto pr ON ip.id_produto = pr.id_produto;