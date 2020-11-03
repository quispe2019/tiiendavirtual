-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-06-2019 a las 01:32:48
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdtiendavirtual`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `cat_id` int(11) NOT NULL,
  `cat_nombre` varchar(255) NOT NULL,
  `cat_slug` varchar(255) NOT NULL,
  `cat_descripcion` text NOT NULL,
  `cat_color` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `cli_id` int(11) NOT NULL,
  `cli_dni` varchar(8) NOT NULL,
  `cli_apellidos` varchar(100) NOT NULL,
  `cli_nombres` varchar(100) NOT NULL,
  `cli_email` varchar(100) DEFAULT NULL,
  `cli_direccion` text,
  `cli_telefono` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleventas`
--

CREATE TABLE `detalleventas` (
  `dv_idventa` int(11) NOT NULL,
  `dv_idproducto` int(11) NOT NULL,
  `dv_cantidad` int(11) NOT NULL,
  `dv_total` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Disparadores `detalleventas`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalleventas` FOR EACH ROW BEGIN
	UPDATE productos SET prod_stock = prod_stock -
NEW.dv_cantidad
	WHERE productos.prod_id = NEW.dV_idproducto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `prod_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `prod_nombre` varchar(100) NOT NULL,
  `prod_slug` varchar(255) NOT NULL,
  `prod_descripcion` text NOT NULL,
  `prod_extract` varchar(255) NOT NULL,
  `prod_precio` decimal(6,2) NOT NULL,
  `prod_imagen` varchar(255) NOT NULL,
  `prod_visible` int(11) NOT NULL DEFAULT '1',
  `prod_stock` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `usuario` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Virtual', 'Virtual', NULL, '2019-06-03 05:00:00', '2019-06-03 05:00:00'),
(70327395, '70327395', '$2y$10$TEoy4sjPDIs82.zCkWtYvuBEykJ6dhy/2XW6ZaH1D41QuGDSk5yv.', NULL, '2019-05-05 01:49:29', '2019-05-05 01:49:29'),
(70345671, '70345671', '$2y$10$4pdZj0.V8HVNJBQpKDjI5.v1lB92vZey0fngvwcwifEAxrEU7oRsW', NULL, '2019-05-05 07:33:08', '2019-05-05 07:33:08'),
(73666122, '73666122', '$2y$10$XYKnMUZOJJJDOOHv10OZFesjB2vMjlhJRxBlmzlc.ivEYkf4ryQ/C', NULL, '2019-05-05 01:43:56', '2019-05-05 01:43:56'),
(75200120, '75200120', '$2y$10$Aa3UVU7eNBy.A8zuFOgFCOz9R363ZHcZCdI34eSr82Kk4rBH2XaQ.', NULL, '2019-05-04 21:42:59', '2019-05-04 21:42:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `ven_id` int(11) NOT NULL,
  `ven_idcliente` int(11) NOT NULL,
  `ven_fecha` date NOT NULL,
  `ven_envio` decimal(6,2) DEFAULT NULL,
  `ven_total` decimal(6,2) NOT NULL,
  `ven_idusuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cli_id`);

--
-- Indices de la tabla `detalleventas`
--
ALTER TABLE `detalleventas`
  ADD PRIMARY KEY (`dv_idventa`,`dv_idproducto`),
  ADD KEY `dv_idventa` (`dv_idventa`),
  ADD KEY `dv_idproducto` (`dv_idproducto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`prod_id`),
  ADD KEY `cat_id` (`cat_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`ven_id`),
  ADD KEY `ven_idcliente` (`ven_idcliente`),
  ADD KEY `ven_idusuario` (`ven_idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `cli_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `prod_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `ven_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalleventas`
--
ALTER TABLE `detalleventas`
  ADD CONSTRAINT `detalleventas_ibfk_1` FOREIGN KEY (`dv_idproducto`) REFERENCES `productos` (`prod_id`),
  ADD CONSTRAINT `detalleventas_ibfk_2` FOREIGN KEY (`dv_idventa`) REFERENCES `ventas` (`ven_id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`cat_id`) REFERENCES `categorias` (`cat_id`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`ven_idcliente`) REFERENCES `clientes` (`cli_id`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`ven_idusuario`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
