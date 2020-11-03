-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-06-2019 a las 21:02:14
-- Versión del servidor: 10.1.35-MariaDB
-- Versión de PHP: 7.2.9

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

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`cat_id`, `cat_nombre`, `cat_slug`, `cat_descripcion`, `cat_color`) VALUES
(1, 'Bebidas', 'bebidas', 'Liquido para el consumo humano.', 'varios'),
(2, 'Lacteos', 'lacteos', 'A base de leche.', 'varios'),
(3, 'Yogurts', 'yogurts', 'A base de leche y frutas.', 'varios'),
(4, 'Cereales', 'cereales', 'Hecho a base de maiz', 'varios'),
(5, 'Snacks', 'snacks', 'Piqueos.', 'varios'),
(6, 'Aguas', 'aguas', 'Agua de mesa.', 'varios'),
(7, 'Lenceria', 'lenceria', 'Productos intimos para el placer sexual.', 'varios'),
(8, 'Galletas', 'galletas', 'Aperitivos cortos.', 'varios'),
(9, 'Mermeladas', 'mermeladas', 'Dulce a base de frutas.', 'varios'),
(10, 'Atunes', 'atunes', 'Filetes y trozos de pescados.', 'varios'),
(11, 'Abarrotes', 'abarrotes', 'Productos para el hogar.', 'varios'),
(12, 'Golosinas', 'golosinas', 'Productos dulces.', 'varios'),
(13, 'Frutas y Verduras', 'frutasyverduras', 'Productos organicos.', 'varios');

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

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cli_id`, `cli_dni`, `cli_apellidos`, `cli_nombres`, `cli_email`, `cli_direccion`, `cli_telefono`) VALUES
(2, '70327395', 'rodriguez richarte', 'joseph joqtan', 'joqtan.jr@gmail.com', 'mz p lt 16 villas de oquendo etapa II', '941160145'),
(3, '70345671', 'Rodriguez', 'Alejandro', 'alex98rodriguehbhbzromero@gmail.com', 'Psj Copacabana - 200 Millas, 29', '938171489');

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
-- Volcado de datos para la tabla `detalleventas`
--

INSERT INTO `detalleventas` (`dv_idventa`, `dv_idproducto`, `dv_cantidad`, `dv_total`) VALUES
(1, 1, 25, '1.50'),
(1, 23, 5, '2.40'),
(2, 3, 1, '10.45'),
(2, 5, 2, '1.40'),
(3, 3, 33, '344.85'),
(3, 5, 3, '2.10'),
(4, 2, 3, '5.10'),
(5, 3, 2, '20.90'),
(6, 5, 2, '1.40'),
(7, 2, 4, '1.70'),
(7, 3, 4, '10.45');

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

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`prod_id`, `cat_id`, `prod_nombre`, `prod_slug`, `prod_descripcion`, `prod_extract`, `prod_precio`, `prod_imagen`, `prod_visible`, `prod_stock`, `created_at`, `updated_at`) VALUES
(1, 1, 'Coca Cola', 'cocacola', 'Coca Cola', 'Coca Cola', '1.50', 'https://www.superama.com.mx/Content/images/products/img_large/0750105530208L.jpg', 1, 50, NULL, NULL),
(2, 2, 'Laive en caja', 'laive', 'Hecha en base a leche en las mejores granjas.', '100% leche.', '1.70', 'https://vivanda.vteximg.com.br/arquivos/ids/164896-1000-1000/489553.jpg?v=636137788268170000', 1, 25, NULL, NULL),
(3, 7, 'Condon Durex', 'condondurex', 'Condon Durex Azul', 'Condon Durex azul', '10.45', 'https://cdn.shopify.com/s/files/1/0005/1930/7329/products/durex-es-condoms-durex-preservativos-natural-comfort-12-unidades-condones-6200155766849_1000x.jpg?v=1552505675', 1, 1, NULL, NULL),
(4, 8, 'Galleta Oreo', 'oreo', 'Galleta de chocolate', 'Galleta de chocolate', '0.80', 'https://i5.walmartimages.com/asr/324ff536-aeb9-4e14-bad4-59c230523e21_1.81fa866b27d2480b10664b1b453ae56e.jpeg?odnHeight=450&odnWidth=450&odnBg=FFFFFF', 1, 50, NULL, NULL),
(5, 8, 'Galleta coronitas', 'coronitas', 'Galleta coronita fresa', 'Galleta coronita fresa', '0.70', 'http://www.corporacionliderperu.com/shop/29345-thickbox_default/coronita-galletas-x-228-gr-six-pack-chocolate.jpg', 1, 33, NULL, NULL),
(6, 10, 'Atun Real', 'atunreal', 'Lomitos en aceite', 'Lomitos en aceite', '3.30', 'https://mimercadoenlinea.ec/2190-large_default/atun-real-lomitos-aceite-354-gr.jpg', 1, 63, NULL, NULL),
(7, 3, 'Yogurt Gloria de 1L', 'yogurtgloriaunlitro', 'Yogurt de fresa de 1 litro listo para el consumo', 'Yogur de fresa', '2.70', 'https://plazavea.vteximg.com.br/arquivos/ids/173145-1000-1000/1000777004.jpg?v=635785248066370000', 1, 93, NULL, NULL),
(8, 1, 'Six Pack de Corona', 'corona', 'Bebida alcoholica', 'corona', '10.50', 'https://www.beverage-distributors.com/wp-content/uploads/2016/11/557842_orig.jpg', 1, 150, NULL, NULL),
(9, 5, 'Papas LAYS', 'papaslays', 'Papas extra grandes saladas crujientes.', 'Papas saladas crujientes', '1.50', 'https://wongfood.vteximg.com.br/arquivos/ids/286080-750-750/250576-1.jpg?v=636904283906030000', 1, 90, NULL, NULL),
(12, 1, 'Pilsen Callao', 'pilsencallao', 'Bebidas con alcohol para celebrar', 'Bebidas con alcohol', '4.90', 'https://www.que-rico.nl/wp-content/uploads/2019/02/pilsen.jpg', 1, 29, NULL, NULL),
(13, 6, 'Agua Cielo Sin gas', 'aguacielosingas', 'Agua de mesa sin gas de 625 ml', 'Agua Cielo', '1.50', 'https://wongfood.vteximg.com.br/arquivos/ids/223153-750-750/frontal-4590.jpg?v=636621876221070000', 1, 69, NULL, NULL),
(14, 6, 'Agua San Mateo', '3', '7', '6', '-1.70', 'http://www.corporacionliderperu.com/shop/28074-thickbox_default/san-mateo-agua-mineral-x-2-5-lt-sin-gas.jpg', 1, -29, NULL, NULL),
(15, 12, 'Chupetin Globopop', 'chupetinglobopop', 'Chupetin Globopop', 'Chupetin Globopop', '0.50', 'https://s7d2.scene7.com/is/image/TottusPE/41286323?$S7Product$&wid=458&hei=458&op_sharpen=0', 1, 150, NULL, NULL),
(16, 9, 'Mermelada Gloria', 'mermegloria', 'Mermelada Gloria', 'Mermelada Gloria', '1.50', 'https://vivanda.vteximg.com.br/arquivos/ids/171521-1000-1000/20047257.jpg?v=636228473689130000', 1, 80, NULL, NULL),
(17, 12, 'Caramelo de limon', 'caramelodelimon', 'Bolsa de caramelos de limon', 'Bolsa de caramelos de limon', '9.30', 'https://plazavea.vteximg.com.br/arquivos/ids/178648-450-450/703512.jpg?v=635909117866830000', 1, 63, NULL, NULL),
(18, 8, 'Galletas Animalitos', 'galletasanimalitos', 'Deliciosas galletas para el paladar humano', 'Deliciosas galletas', '1.00', 'https://www.chedraui.com.mx/medias/750100064941-00-CH515Wx515H?context=bWFzdGVyfHJvb3R8NjI3NDl8aW1hZ2UvanBlZ3xoOWUvaDYzLzg4MjAzODYxNjg4NjIuanBnfDc4ZTIxOWI2MGMyYmMzMGExNjI3ZTZmOGM2ODQzY2QyNWI5MDIxNGY5YzczMDM0MDEzYjNiNWIwNThmODQ2NGQ', 1, 19, NULL, NULL),
(19, 10, 'Filete de Atun Florida', 'filetedeatun', 'Filete de Atun Florida', 'Filete de Atun Florida', '6.80', 'https://wongfood.vteximg.com.br/arquivos/ids/287044-230-230/frontal-3314.jpg?v=636909696552300000', 1, 453, NULL, NULL),
(23, 1, 'INKA KOLA', 'inkakola', 'INKA KOLA', 'INKA KOLA', '2.40', 'https://wongfood.vteximg.com.br/arquivos/ids/223458-1000-1000/frontal-4833.jpg?v=636622740201330000', 1, 151, NULL, NULL),
(24, 13, 'Manzana', 'manzana', 'Manzana jugosa', 'Manzana jugosa', '0.60', 'https://www.huertosostenible.com/tietar/wp-content/uploads/2017/06/Manzana-Royal-ecologica-600x600-600x600.jpg', 1, 36, NULL, NULL),
(25, 4, 'Cereales Ángel Zuck 200g', 'cerealesángelzuck', 'Cerales Ángel crocantes con polvo de azúcar', 'Cerales Ángel crocantes', '1.90', 'https://wongfood.vteximg.com.br/arquivos/ids/156058-1000-1000/Cereal-Angel-Zuck-Bolsa-200-g-80989.jpg?v=636052218688030000', 1, 90, NULL, NULL),
(27, 4, 'Cereales Fruit de Colores', 'ceralesfruitdecolores', 'Cereales Fruit dulce de colores', 'Cereales Fruit dulce de colores', '2.00', 'https://vivanda.vteximg.com.br/arquivos/ids/161123-1000-1000/1058668003.jpg?v=636137717562930000', 1, 20, NULL, NULL),
(28, 1, 'Ron Cartavio', 'Roncartavio', 'Ron cartavio 750ml', 'Ron Cartavio', '21.00', 'https://vivanda.vteximg.com.br/arquivos/ids/161006-1000-1000/1040164002.jpg?v=636137716356100000', 1, 19, NULL, NULL);

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
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`ven_id`, `ven_idcliente`, `ven_fecha`, `ven_envio`, `ven_total`, `ven_idusuario`) VALUES
(1, 2, '2019-06-04', '0.00', '12.00', 1),
(2, 2, '2019-06-04', NULL, '344.85', 70327395),
(3, 3, '2019-06-04', NULL, '344.85', 70327395);

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
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `cli_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `prod_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `ven_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
