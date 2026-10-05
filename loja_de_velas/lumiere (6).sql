-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05-Out-2026 às 16:44
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `lumiere`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(80) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id`, `nome`, `descricao`, `ativo`, `criado_em`) VALUES
(1, 'Velas de pote', 'Velas aromáticas em potes de vidro', 1, '2026-09-29 17:11:39'),
(2, 'Velas decorativas', 'Velas em formatos e cores especiais', 1, '2026-09-29 17:11:39'),
(3, 'Kits e presentes', 'Kits e caixas para presente', 1, '2026-09-29 17:11:39'),
(4, 'Aromatizantes', 'Home spray, difusores e refis', 1, '2026-09-29 17:11:39');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` char(11) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `cidade` varchar(80) DEFAULT NULL,
  `uf` char(2) DEFAULT NULL,
  `cep` char(8) DEFAULT NULL,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `entrada`
--

CREATE TABLE `entrada` (
  `id` int(10) UNSIGNED NOT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `fornecedor` varchar(120) NOT NULL,
  `numero_documento` varchar(40) DEFAULT NULL,
  `data_entrada` date NOT NULL,
  `valor_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `observacao` varchar(255) DEFAULT NULL,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `itens_entrada`
--

CREATE TABLE `itens_entrada` (
  `id` int(10) UNSIGNED NOT NULL,
  `entrada_id` int(10) UNSIGNED NOT NULL,
  `produto_id` int(10) UNSIGNED NOT NULL,
  `quantidade` int(11) NOT NULL,
  `custo_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Acionadores `itens_entrada`
--
DELIMITER $$
CREATE TRIGGER `trg_itens_entrada_ai` AFTER INSERT ON `itens_entrada` FOR EACH ROW BEGIN
    UPDATE produto
       SET estoque_atual = estoque_atual + NEW.quantidade,
           preco_custo   = NEW.custo_unitario
     WHERE id = NEW.produto_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `itens_notafiscal`
--

CREATE TABLE `itens_notafiscal` (
  `id` int(10) UNSIGNED NOT NULL,
  `nota_fiscal_id` int(10) UNSIGNED NOT NULL,
  `produto_id` int(10) UNSIGNED NOT NULL,
  `quantidade` int(11) NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `desconto` decimal(10,2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(12,2) GENERATED ALWAYS AS (`quantidade` * `preco_unitario` - `desconto`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Acionadores `itens_notafiscal`
--
DELIMITER $$
CREATE TRIGGER `trg_itens_notafiscal_ai` AFTER INSERT ON `itens_notafiscal` FOR EACH ROW BEGIN
    UPDATE produto
       SET estoque_atual = estoque_atual - NEW.quantidade
     WHERE id = NEW.produto_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_itens_notafiscal_bi` BEFORE INSERT ON `itens_notafiscal` FOR EACH ROW BEGIN
    DECLARE v_estoque INT;
    SELECT estoque_atual INTO v_estoque FROM produto WHERE id = NEW.produto_id FOR UPDATE;
    IF v_estoque < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente para o produto.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `nota_fiscal`
--

CREATE TABLE `nota_fiscal` (
  `id` int(10) UNSIGNED NOT NULL,
  `venda_id` int(10) UNSIGNED NOT NULL,
  `numero` int(10) UNSIGNED NOT NULL,
  `serie` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `chave_acesso` char(44) DEFAULT NULL,
  `data_emissao` datetime NOT NULL DEFAULT current_timestamp(),
  `valor_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('emitida','cancelada') NOT NULL DEFAULT 'emitida'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pagamentos`
--

CREATE TABLE `pagamentos` (
  `id` int(10) UNSIGNED NOT NULL,
  `venda_id` int(10) UNSIGNED NOT NULL,
  `forma_pagamento` enum('dinheiro','pix','cartao_credito','cartao_debito','boleto') NOT NULL,
  `valor` decimal(12,2) NOT NULL,
  `parcelas` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `status` enum('pendente','pago','cancelado') NOT NULL DEFAULT 'pendente',
  `data_pagamento` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `id` int(10) UNSIGNED NOT NULL,
  `categoria_id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(120) NOT NULL,
  `descricao` text DEFAULT NULL,
  `aroma` varchar(60) DEFAULT NULL,
  `preco_custo` decimal(10,2) NOT NULL DEFAULT 0.00,
  `preco_venda` decimal(10,2) NOT NULL,
  `estoque_atual` int(11) NOT NULL DEFAULT 0,
  `estoque_minimo` int(11) NOT NULL DEFAULT 5,
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `perfil` enum('admin','vendedor') NOT NULL DEFAULT 'vendedor',
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `criado_em` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `venda`
--

CREATE TABLE `venda` (
  `id` int(10) UNSIGNED NOT NULL,
  `cliente_id` int(10) UNSIGNED DEFAULT NULL,
  `usuario_id` int(10) UNSIGNED NOT NULL,
  `data_venda` datetime NOT NULL DEFAULT current_timestamp(),
  `desconto` decimal(10,2) NOT NULL DEFAULT 0.00,
  `valor_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('aberta','concluida','cancelada') NOT NULL DEFAULT 'aberta'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Índices para tabela `entrada`
--
ALTER TABLE `entrada`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_entrada_usuario` (`usuario_id`),
  ADD KEY `idx_entrada_data` (`data_entrada`);

--
-- Índices para tabela `itens_entrada`
--
ALTER TABLE `itens_entrada`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_itens_entrada_entrada` (`entrada_id`),
  ADD KEY `fk_itens_entrada_produto` (`produto_id`);

--
-- Índices para tabela `itens_notafiscal`
--
ALTER TABLE `itens_notafiscal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_itens_nf_nota` (`nota_fiscal_id`),
  ADD KEY `fk_itens_nf_produto` (`produto_id`);

--
-- Índices para tabela `nota_fiscal`
--
ALTER TABLE `nota_fiscal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `venda_id` (`venda_id`),
  ADD UNIQUE KEY `uq_nf_numero_serie` (`numero`,`serie`),
  ADD UNIQUE KEY `chave_acesso` (`chave_acesso`);

--
-- Índices para tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pagamentos_venda` (`venda_id`),
  ADD KEY `idx_pagamentos_status` (`status`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_produto_categoria` (`categoria_id`),
  ADD KEY `idx_produto_nome` (`nome`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices para tabela `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_venda_cliente` (`cliente_id`),
  ADD KEY `fk_venda_usuario` (`usuario_id`),
  ADD KEY `idx_venda_data` (`data_venda`),
  ADD KEY `idx_venda_status` (`status`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `entrada`
--
ALTER TABLE `entrada`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `itens_entrada`
--
ALTER TABLE `itens_entrada`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `itens_notafiscal`
--
ALTER TABLE `itens_notafiscal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `nota_fiscal`
--
ALTER TABLE `nota_fiscal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `venda`
--
ALTER TABLE `venda`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `entrada`
--
ALTER TABLE `entrada`
  ADD CONSTRAINT `fk_entrada_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Limitadores para a tabela `itens_entrada`
--
ALTER TABLE `itens_entrada`
  ADD CONSTRAINT `fk_itens_entrada_entrada` FOREIGN KEY (`entrada_id`) REFERENCES `entrada` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_itens_entrada_produto` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`);

--
-- Limitadores para a tabela `itens_notafiscal`
--
ALTER TABLE `itens_notafiscal`
  ADD CONSTRAINT `fk_itens_nf_nota` FOREIGN KEY (`nota_fiscal_id`) REFERENCES `nota_fiscal` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_itens_nf_produto` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`);

--
-- Limitadores para a tabela `nota_fiscal`
--
ALTER TABLE `nota_fiscal`
  ADD CONSTRAINT `fk_nf_venda` FOREIGN KEY (`venda_id`) REFERENCES `venda` (`id`);

--
-- Limitadores para a tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD CONSTRAINT `fk_pagamentos_venda` FOREIGN KEY (`venda_id`) REFERENCES `venda` (`id`);

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_produto_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`);

--
-- Limitadores para a tabela `venda`
--
ALTER TABLE `venda`
  ADD CONSTRAINT `fk_venda_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_venda_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
