-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 04/08/2026 às 21:54
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `atlas_desk`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `c1_categorias`
--

CREATE TABLE `c1_categorias` (
  `c1_id` varchar(32) NOT NULL,
  `c1_nome` varchar(150) NOT NULL,
  `c1_descricao` text DEFAULT NULL,
  `c1_cor` varchar(10) NOT NULL DEFAULT '#6C757D',
  `c1_ativo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `c2_chamados`
--

CREATE TABLE `c2_chamados` (
  `c2_id` varchar(32) NOT NULL,
  `c2_titulo` varchar(255) NOT NULL,
  `c2_descricao` text NOT NULL,
  `c2_prioridade` enum('BAIXA','MEDIA','ALTA','CRITICA') NOT NULL DEFAULT 'MEDIA',
  `c2_status` enum('ABERTO','EM ANDAMENTO','RESOLVIDO','FECHADO') NOT NULL DEFAULT 'ABERTO',
  `c2_categoria_id` varchar(32) DEFAULT NULL,
  `c2_solicitante_id` varchar(32) DEFAULT NULL,
  `c2_atribuido_para` varchar(32) NOT NULL,
  `c2_nota_solucao` text DEFAULT NULL,
  `c2_resolvido_em` datetime DEFAULT NULL,
  `c2_fechado_em` datetime DEFAULT NULL,
  `c2_created_at` datetime DEFAULT NULL,
  `c2_updated_at` datetime DEFAULT NULL,
  `c2_deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `c3_comentarios`
--

CREATE TABLE `c3_comentarios` (
  `c3_id` varchar(32) NOT NULL,
  `c3_chamado_id` varchar(32) NOT NULL,
  `c3_usuario_id` varchar(32) NOT NULL,
  `c3_conteudo` text DEFAULT NULL,
  `c3_interno` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = Público; 1 Interno (só técnicos/admins podem visualizar)',
  `c2_created_at` datetime DEFAULT NULL,
  `c2_updated_at` datetime DEFAULT NULL,
  `c3_deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `c4_configuracoes`
--

CREATE TABLE `c4_configuracoes` (
  `c4_id` varchar(32) NOT NULL,
  `c4_chave` varchar(100) NOT NULL,
  `c4_valor` text DEFAULT NULL,
  `c4_descricao` varchar(255) DEFAULT NULL,
  `c4_created_at` datetime DEFAULT NULL,
  `c4_updated_at` datetime DEFAULT NULL,
  `c4_deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `h1_historico_status`
--

CREATE TABLE `h1_historico_status` (
  `h1_id` varchar(32) NOT NULL,
  `h1_chamado_id` varchar(32) NOT NULL,
  `h1_usuario_id` varchar(32) NOT NULL,
  `h1_status_anterior` enum('ABERTO','EM ANDAMENTO','RESOLVIDO','FECHADO') DEFAULT NULL,
  `h1_status_novo` enum('ABERTO','EM ANDAMENTO','RESOLVIDO','FECHADO') DEFAULT NULL,
  `h1_nota` text DEFAULT NULL,
  `h1_tipo_acao` enum('MUDANÇA STATUS','ATRIBUIÇÃO') NOT NULL DEFAULT 'MUDANÇA STATUS',
  `h1_created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `l1_logs`
--

CREATE TABLE `l1_logs` (
  `l1_id` varchar(32) NOT NULL,
  `l1_usuario_id` varchar(32) NOT NULL,
  `l1_acao` varchar(50) NOT NULL,
  `l1_tabela` varchar(50) NOT NULL,
  `l1_registro_id` varchar(32) NOT NULL,
  `l1_dados_anteriores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`l1_dados_anteriores`)),
  `l1_dados_novos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`l1_dados_novos`)),
  `l1_ip` varchar(50) NOT NULL,
  `l1_user_agent` varchar(255) NOT NULL,
  `l1_created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `n1_notificacoes`
--

CREATE TABLE `n1_notificacoes` (
  `n1_id` varchar(32) NOT NULL,
  `n1_usuario_id` varchar(32) NOT NULL,
  `n1_chamado_id` varchar(32) NOT NULL,
  `n1_titulo` varchar(100) NOT NULL,
  `n1_mensagem` text DEFAULT NULL,
  `n1_lida` tinyint(1) NOT NULL DEFAULT 0,
  `n1_tipo` enum('STATUS','ATRIBUICAO','COMENTARIO','SISTEMA') NOT NULL DEFAULT 'SISTEMA',
  `n1_link` varchar(255) DEFAULT NULL,
  `n1_created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `u1_usuarios`
--

CREATE TABLE `u1_usuarios` (
  `u1_id` varchar(32) NOT NULL,
  `u1_nome` varchar(255) NOT NULL,
  `u1_senha` varchar(50) NOT NULL,
  `u1_perfil` enum('ADMIN','TECNICO','SOLICITANTE') NOT NULL DEFAULT 'SOLICITANTE',
  `u1_ativo` tinyint(1) NOT NULL DEFAULT 1,
  `u1_ultimo_login` datetime DEFAULT NULL,
  `u1_token` varchar(255) DEFAULT NULL,
  `u1_created_at` datetime DEFAULT NULL,
  `u1_updated_at` datetime DEFAULT NULL,
  `u1_deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `c1_categorias`
--
ALTER TABLE `c1_categorias`
  ADD PRIMARY KEY (`c1_id`);

--
-- Índices de tabela `c2_chamados`
--
ALTER TABLE `c2_chamados`
  ADD PRIMARY KEY (`c2_id`),
  ADD KEY `fk_chamado_categoria` (`c2_categoria_id`),
  ADD KEY `fk_chamado_solicitante` (`c2_solicitante_id`),
  ADD KEY `fk_chamado_atribuicao` (`c2_atribuido_para`);

--
-- Índices de tabela `c3_comentarios`
--
ALTER TABLE `c3_comentarios`
  ADD PRIMARY KEY (`c3_id`);

--
-- Índices de tabela `c4_configuracoes`
--
ALTER TABLE `c4_configuracoes`
  ADD PRIMARY KEY (`c4_id`);

--
-- Índices de tabela `h1_historico_status`
--
ALTER TABLE `h1_historico_status`
  ADD PRIMARY KEY (`h1_id`),
  ADD KEY `fk_historico_chamado` (`h1_chamado_id`),
  ADD KEY `fk_historico_usuario` (`h1_usuario_id`);

--
-- Índices de tabela `l1_logs`
--
ALTER TABLE `l1_logs`
  ADD PRIMARY KEY (`l1_id`);

--
-- Índices de tabela `n1_notificacoes`
--
ALTER TABLE `n1_notificacoes`
  ADD PRIMARY KEY (`n1_id`),
  ADD KEY `fk_notificacao_chamado` (`n1_chamado_id`),
  ADD KEY `fk_notificacao_usuario` (`n1_usuario_id`);

--
-- Índices de tabela `u1_usuarios`
--
ALTER TABLE `u1_usuarios`
  ADD PRIMARY KEY (`u1_id`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `c2_chamados`
--
ALTER TABLE `c2_chamados`
  ADD CONSTRAINT `fk_chamado_atribuicao` FOREIGN KEY (`c2_atribuido_para`) REFERENCES `u1_usuarios` (`u1_id`),
  ADD CONSTRAINT `fk_chamado_categoria` FOREIGN KEY (`c2_categoria_id`) REFERENCES `c1_categorias` (`c1_id`),
  ADD CONSTRAINT `fk_chamado_solicitante` FOREIGN KEY (`c2_solicitante_id`) REFERENCES `u1_usuarios` (`u1_id`);

--
-- Restrições para tabelas `h1_historico_status`
--
ALTER TABLE `h1_historico_status`
  ADD CONSTRAINT `fk_historico_chamado` FOREIGN KEY (`h1_chamado_id`) REFERENCES `c2_chamados` (`c2_id`),
  ADD CONSTRAINT `fk_historico_usuario` FOREIGN KEY (`h1_usuario_id`) REFERENCES `u1_usuarios` (`u1_id`);

--
-- Restrições para tabelas `n1_notificacoes`
--
ALTER TABLE `n1_notificacoes`
  ADD CONSTRAINT `fk_notificacao_chamado` FOREIGN KEY (`n1_chamado_id`) REFERENCES `c2_chamados` (`c2_id`),
  ADD CONSTRAINT `fk_notificacao_usuario` FOREIGN KEY (`n1_usuario_id`) REFERENCES `u1_usuarios` (`u1_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
