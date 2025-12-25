CREATE DATABASE IF NOT EXISTS lanchonete;
USE lanchonete;
--
-- Tabela: users
--
CREATE TABLE users (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    cpf VARCHAR(255) NOT NULL UNIQUE,
    telefone VARCHAR(255) NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Tabela: password_reset_tokens
--
CREATE TABLE password_reset_tokens (
    email VARCHAR(255) NOT NULL PRIMARY KEY,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Tabela: sessions
--
CREATE TABLE sessions (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL,
    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,
    payload LONGTEXT NOT NULL,
    last_activity INTEGER NOT NULL,
    INDEX sessions_user_id_index (user_id),
    INDEX sessions_last_activity_index (last_activity)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Tabela: categorias
--
CREATE TABLE categorias (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO categorias (id, nome, created_at, updated_at) VALUES
(1, 'Lanches', NOW(), NOW()),
(2, 'Bebidas', NOW(), NOW()),
(3, 'Porções', NOW(), NOW()),
(4, 'Combos', NOW(), NOW());
--
-- Tabela: produtos
--
CREATE TABLE produtos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    categoria_id BIGINT UNSIGNED NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NULL,
    preco DECIMAL(8, 2) NOT NULL,
    imagem VARCHAR(255) NULL,
    estoque INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    CONSTRAINT produtos_categoria_id_foreign FOREIGN KEY (categoria_id) REFERENCES categorias (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO produtos (id, categoria_id, nome, descricao, preco, imagem, estoque, created_at, updated_at) VALUES
-- 15 Produtos: Categoria Lanches (ID 1)
(1, 1, 'X-Salada Clássico', 'Hambúrguer, queijo prato, alface, tomate e maionese da casa.', 22.50, 'storage/imagens/lanche.jpg', 50, NOW(), NOW()),
(2, 1, 'X-Bacon Supremo', 'Hambúrguer duplo, muito bacon crocante e cheddar cremoso.', 28.90, 'storage/imagens/lanche.jpg', 45, NOW(), NOW()),
(3, 1, 'Sanduíche Vegetariano', 'Pão integral, queijo coalho, abobrinha e berinjela grelhadas.', 19.90, 'storage/imagens/lanche.jpg', 60, NOW(), NOW()),
(4, 1, 'Cheeseburger Duplo', 'Dois hambúrgueres de carne com queijo muçarela derretido.', 32.00, 'storage/imagens/lanche.jpg', 40, NOW(), NOW()),
(5, 1, 'X-Tudo Monstro', 'Todos os acompanhamentos: ovo, bacon, calabresa e queijo.', 45.00, 'storage/imagens/lanche.jpg', 25, NOW(), NOW()),
(6, 1, 'Frango Crispy', 'Filé de frango empanado, alface americana e molho honey mustard.', 26.50, 'storage/imagens/lanche.jpg', 55, NOW(), NOW()),
(7, 1, 'Hambúrguer Gourmet Trufado', 'Hambúrguer Wagyu, queijo suíço e azeite trufado.', 48.90, 'storage/imagens/lanche.jpg', 15, NOW(), NOW()),
(8, 1, 'Misto Quente Simples', 'Pão na chapa com queijo e presunto.', 12.00, 'storage/imagens/lanche.jpg', 70, NOW(), NOW()),
(9, 1, 'Pão com Mortadela', 'Pão francês com fatias de mortadela e queijo.', 15.50, 'storage/imagens/lanche.jpg', 65, NOW(), NOW()),
(10, 1, 'X-Picanha', 'Bife de picanha grelhada com queijo provolone.', 38.00, 'storage/imagens/lanche.jpg', 30, NOW(), NOW()),
(11, 1, 'Lanche de Pernil', 'Pernil assado desfiado com vinagrete e queijo.', 31.00, 'storage/imagens/lanche.jpg', 35, NOW(), NOW()),
(12, 1, 'Hot Dog Completo', 'Salsicha, purê de batata, milho, vinagrete e batata palha.', 18.00, 'storage/imagens/lanche.jpg', 75, NOW(), NOW()),
(13, 1, 'X-Egg Bacon', 'Hambúrguer, queijo, ovo e bacon.', 27.00, 'storage/imagens/lanche.jpg', 40, NOW(), NOW()),
(14, 1, 'X-Calabresa', 'Hambúrguer, queijo e calabresa fatiada.', 25.00, 'storage/imagens/lanche.jpg', 45, NOW(), NOW()),
(15, 1, 'Sanduíche de Metro (Grande)', 'Sanduíche frio de 50cm, ideal para compartilhar.', 59.90, 'storage/imagens/lanche.jpg', 10, NOW(), NOW()),
-- 15 Produtos: Categoria Bebidas (ID 2)
(16, 2, 'Refrigerante Lata (Coca-Cola)', 'Lata de 350ml.', 6.00, 'storage/imagens/lanche.jpg', 120, NOW(), NOW()),
(17, 2, 'Refrigerante Lata (Guaraná)', 'Lata de 350ml.', 6.00, 'storage/imagens/lanche.jpg', 100, NOW(), NOW()),
(18, 2, 'Suco Natural de Laranja', 'Copo de 300ml.', 8.50, 'storage/imagens/lanche.jpg', 80, NOW(), NOW()),
(19, 2, 'Suco Natural de Abacaxi com Hortelã', 'Copo de 300ml.', 9.00, 'storage/imagens/lanche.jpg', 75, NOW(), NOW()),
(20, 2, 'Água Mineral sem Gás', 'Garrafa de 500ml.', 4.50, 'storage/imagens/lanche.jpg', 150, NOW(), NOW()),
(21, 2, 'Água Mineral com Gás', 'Garrafa de 500ml.', 5.00, 'storage/imagens/lanche.jpg', 130, NOW(), NOW()),
(22, 2, 'Cerveja Long Neck Pilsen', 'Garrafa 355ml.', 12.00, 'storage/imagens/lanche.jpg', 90, NOW(), NOW()),
(23, 2, 'Cerveja Artesanal IPA', 'Garrafa 500ml.', 22.00, 'storage/imagens/lanche.jpg', 40, NOW(), NOW()),
(24, 2, 'Chá Gelado de Pêssego', 'Garrafa 500ml.', 7.50, 'storage/imagens/lanche.jpg', 85, NOW(), NOW()),
(25, 2, 'Milkshake de Chocolate', 'Copo de 400ml.', 18.00, 'storage/imagens/lanche.jpg', 50, NOW(), NOW()),
(26, 2, 'Limonada Suíça', 'Copo de 300ml.', 7.00, 'storage/imagens/lanche.jpg', 60, NOW(), NOW()),
(27, 2, 'Refrigerante 2 Litros (Guaraná)', 'Garrafa de 2 litros.', 15.00, 'storage/imagens/lanche.jpg', 30, NOW(), NOW()),
(28, 2, 'Refrigerante 2 Litros (Fanta)', 'Garrafa de 2 litros.', 15.00, 'storage/imagens/lanche.jpg', 25, NOW(), NOW()),
(29, 2, 'Energético', 'Lata de 250ml.', 9.50, 'storage/imagens/lanche.jpg', 70, NOW(), NOW()),
(30, 2, 'Café Expresso', 'Dose única.', 5.00, 'storage/imagens/lanche.jpg', 999, NOW(), NOW()),
-- 10 Produtos: Categoria Porções (ID 3)
(31, 3, 'Batata Frita Grande', 'Porção de 500g de batatas rústicas com alecrim.', 15.00, 'storage/imagens/lanche.jpg', 60, NOW(), NOW()),
(32, 3, 'Anéis de Cebola', 'Porção de anéis de cebola empanados (300g).', 18.00, 'storage/imagens/lanche.jpg', 55, NOW(), NOW()),
(33, 3, 'Mini Pastéis (Queijo e Carne)', '12 unidades variadas.', 25.00, 'storage/imagens/lanche.jpg', 40, NOW(), NOW()),
(34, 3, 'Mandioca Frita com Bacon', 'Porção de mandioca com queijo coalho e bacon.', 29.90, 'storage/imagens/lanche.jpg', 35, NOW(), NOW()),
(35, 3, 'Isca de Frango à Milanesa', '300g de iscas de frango crocantes.', 27.50, 'storage/imagens/lanche.jpg', 50, NOW(), NOW()),
(36, 3, 'Polenta Frita', 'Polenta cremosa frita e polvilhada com parmesão.', 16.00, 'storage/imagens/lanche.jpg', 45, NOW(), NOW()),
(37, 3, 'Provolone à Milanesa', 'Queijo provolone empanado e frito.', 34.00, 'storage/imagens/lanche.jpg', 30, NOW(), NOW()),
(38, 3, 'Aipim Frito', 'Mandioca frita simples (400g).', 17.00, 'storage/imagens/lanche.jpg', 50, NOW(), NOW()),
(39, 3, 'Tiras de Picanha Acebolada', '250g de tiras de picanha servidas na chapa com cebola.', 55.00, 'storage/imagens/lanche.jpg', 20, NOW(), NOW()),
(40, 3, 'Coxinha de Frango (Unidade)', 'Coxinha tradicional de frango com catupiry.', 8.00, 'storage/imagens/lanche.jpg', 80, NOW(), NOW()),
-- 10 Produtos: Categoria Combos (ID 4)
(41, 4, 'Combo Executivo', '1 X-Salada Clássico + Batata Média + Refrigerante Lata.', 35.00, 'storage/imagens/lanche.jpg', 40, NOW(), NOW()),
(42, 4, 'Combo Duplo Bacon', '2 X-Bacon Supremo + 1 Porção de Anéis de Cebola + 2 Refrigerantes.', 69.90, 'storage/imagens/lanche.jpg', 30, NOW(), NOW()),
(43, 4, 'Combo Família Clássico', '4 X-Salada Clássico + Batata Grande + 1 Refri 2L.', 99.90, 'storage/imagens/lanche.jpg', 25, NOW(), NOW()),
(44, 4, 'Combo Vegetariano', '1 Sanduíche Vegetariano + 1 Polenta Frita + 1 Suco Natural.', 42.00, 'storage/imagens/lanche.jpg', 35, NOW(), NOW()),
(45, 4, 'Combo Gourmet', '1 Hambúrguer Trufado + 1 Batata Rústica Pequena + 1 Cerveja IPA.', 75.00, 'storage/imagens/lanche.jpg', 15, NOW(), NOW()),
(46, 4, 'Combo Porções Mistas', '1 Isca de Frango + 1 Batata Grande + 1 Mandioca Frita.', 65.00, 'storage/imagens/lanche.jpg', 20, NOW(), NOW()),
(47, 4, 'Combo Simples', '1 Hot Dog Completo + 1 Refrigerante Lata.', 22.00, 'storage/imagens/lanche.jpg', 50, NOW(), NOW()),
(48, 4, 'Combo Max-Lanche', '1 X-Tudo Monstro + 1 Milkshake de Chocolate.', 59.00, 'storage/imagens/lanche.jpg', 18, NOW(), NOW()),
(49, 4, 'Combo do Dia', 'Lanche sazonal + Suco do dia (Preço Promocional).', 30.00, 'storage/imagens/lanche.jpg', 45, NOW(), NOW()),
(50, 4, 'Combo de Pernil', '1 Lanche de Pernil + 1 Porção de Aipim Frito + 1 Refrigerante.', 52.00, 'storage/imagens/lanche.jpg', 28, NOW(), NOW());
--
-- Tabela: adicionais
--
CREATE TABLE adicionais (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    produto_id BIGINT UNSIGNED NOT NULL,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    CONSTRAINT adicionais_produto_id_foreign FOREIGN KEY (produto_id) REFERENCES produtos (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
--
-- Tabela: ingredientes
--
CREATE TABLE ingredientes (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    produto_id BIGINT UNSIGNED NOT NULL,
    nome VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    CONSTRAINT ingredientes_produto_id_foreign FOREIGN KEY (produto_id) REFERENCES produtos (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tabela: enderecos
--
CREATE TABLE enderecos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    rua VARCHAR(255) NOT NULL,
    numero VARCHAR(255) NOT NULL,
    bairro VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    estado VARCHAR(255) NOT NULL,
    cep VARCHAR(255) NOT NULL,
    complemento VARCHAR(255) NULL, -- Adicionei o complemento aqui para consistência
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    CONSTRAINT enderecos_user_id_foreign FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tabela: pagamento
--
CREATE TABLE pagamentos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pedido_id BIGINT NOT NULL,
    metodo ENUM('pix', 'cartao', 'dinheiro') NOT NULL,
    status ENUM('pendente', 'aprovado', 'recusado') DEFAULT 'pendente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
--
-- Tabela: carrinhos
--
CREATE TABLE carrinhos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    produto_id BIGINT UNSIGNED NOT NULL,
    quantidade INTEGER NOT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    CONSTRAINT carrinhos_user_id_foreign FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT carrinhos_produto_id_foreign FOREIGN KEY (produto_id) REFERENCES produtos (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Tabela principal de PEDIDOS
CREATE TABLE pedidos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    status ENUM('pendente', 'confirmado', 'preparando', 'entregue', 'cancelado') DEFAULT 'pendente',
    metodo_pagamento ENUM('pix', 'cartao', 'dinheiro') NOT NULL,
    endereco_entrega TEXT NOT NULL,
    observacoes TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Chave estrangeira para usuários (se sua tabela users existir)
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Tabela de ITENS DO PEDIDO
CREATE TABLE pedido_itens (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    pedido_id BIGINT UNSIGNED NOT NULL,
    produto_id BIGINT UNSIGNED NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    personalizacao JSON NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Chaves estrangeiras
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);

-- Índices para melhor performance
CREATE INDEX idx_pedidos_user_id ON pedidos(user_id);
CREATE INDEX idx_pedidos_status ON pedidos(status);
CREATE INDEX idx_pedido_itens_pedido_id ON pedido_itens(pedido_id);
CREATE INDEX idx_pedido_itens_produto_id ON pedido_itens(produto_id);

