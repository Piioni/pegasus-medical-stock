-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: mysql
-- Tiempo de generación: 06-06-2025 a las 19:08:46
-- Versión del servidor: 8.0.42
-- Versión de PHP: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `stock_hospitalario`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenes`
--

CREATE TABLE `almacenes` (
  `id_almacen` int NOT NULL,
  `nombre` varchar(35) NOT NULL,
  `tipo` enum('GENERAL','PLANTA') NOT NULL,
  `id_hospital` int NOT NULL,
  `id_planta` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `almacenes`
--

INSERT INTO `almacenes` (`id_almacen`, `nombre`, `tipo`, `id_hospital`, `id_planta`) VALUES
(1, 'Almacen Central Importante 2', 'GENERAL', 1, NULL),
(5, 'Almacen de Enfermeria', 'PLANTA', 1, 4),
(6, 'Almace Nacional ', 'GENERAL', 7, NULL),
(8, 'Almacen de pana', 'PLANTA', 1, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `botiquines`
--

CREATE TABLE `botiquines` (
  `id_botiquin` int NOT NULL,
  `id_planta` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `capacidad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `botiquines`
--

INSERT INTO `botiquines` (`id_botiquin`, `id_planta`, `nombre`, `capacidad`) VALUES
(1, 4, 'Botiquin de Paracetamols ', 50),
(2, 5, 'Botiquin de ibuprofenos', 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hospitales`
--

CREATE TABLE `hospitales` (
  `id_hospital` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `activo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `hospitales`
--

INSERT INTO `hospitales` (`id_hospital`, `nombre`, `ubicacion`, `activo`) VALUES
(1, 'Hospital de Fuentenueva ', 'Calle fuentenueva ', 1),
(6, 'Hospsital Nacional', 'Gran Via', 0),
(7, 'Hospital Nacional', 'Gran via del colon', 1),
(8, 'Hospital de prueba', 'Prueba', 0),
(9, 'Juan', 'asdasd', 0),
(10, 'Hospital de Washington', 'Washington xd', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lecturas`
--

CREATE TABLE `lecturas` (
  `id_lectura` int NOT NULL,
  `id_botiquin` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `fecha_lectura` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_usuario` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `lecturas`
--

INSERT INTO `lecturas` (`id_lectura`, `id_botiquin`, `id_producto`, `cantidad`, `fecha_lectura`, `id_usuario`) VALUES
(1, 1, 1, 2, '2025-06-04 13:38:07', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `id_movimiento` int NOT NULL,
  `tipo_movimiento` enum('TRASLADO','ENTRADA','DEVOLUCION') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `id_origen` int DEFAULT NULL,
  `id_botiquin_origen` int DEFAULT NULL,
  `id_destino` int NOT NULL,
  `fecha_movimiento` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('PENDIENTE','COMPLETADO','CANCELADO') NOT NULL,
  `id_responsable` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plantas`
--

CREATE TABLE `plantas` (
  `id_planta` int NOT NULL,
  `id_hospital` int NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `activo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `plantas`
--

INSERT INTO `plantas` (`id_planta`, `id_hospital`, `nombre`, `activo`) VALUES
(1, 1, 'Planta de pediatria ', 0),
(2, 1, 'Planta de Enfermeria ', 1),
(3, 1, 'Planta de prueba 2', 0),
(4, 1, 'Planta de Enfermeria 2', 1),
(5, 1, 'Planta de Manuel', 1),
(6, 7, 'Planta de prueba', 0),
(7, 7, 'Planta de prueba 2', 0),
(8, 1, 'Planta de pruebaa', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int NOT NULL,
  `codigo` varchar(30) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(80) NOT NULL,
  `unidad_medida` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `codigo`, `nombre`, `descripcion`, `unidad_medida`) VALUES
(1, 'PAR20178', 'Paracetamol', 'Medicamento sencillo para dolores comunes ', 'gr'),
(3, 'IBU702', 'Ibuprofeno', 'Medicamento ligeralmente fuerte para dolores comunes.', 'gr');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reposiciones`
--

CREATE TABLE `reposiciones` (
  `id_reposicion` int NOT NULL,
  `id_almacen` int NOT NULL,
  `id_botiquin` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `fecha_reposicion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('PENDIENTE','COMPLETADO','CANCELADO') NOT NULL,
  `id_usuario` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int NOT NULL,
  `nombre` enum('ADMINISTRADOR','GESTOR_GENERAL','GESTOR_HOSPITAL','GESTOR_PLANTA','USUARIO_BOTIQUIN') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
(1, 'ADMINISTRADOR'),
(2, 'GESTOR_GENERAL'),
(3, 'GESTOR_HOSPITAL'),
(4, 'GESTOR_PLANTA'),
(5, 'USUARIO_BOTIQUIN');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock_almacenes`
--

CREATE TABLE `stock_almacenes` (
  `id_stock` int NOT NULL,
  `id_almacen` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `stock_almacenes`
--

INSERT INTO `stock_almacenes` (`id_stock`, `id_almacen`, `id_producto`, `cantidad`) VALUES
(2, 5, 3, 100),
(3, 8, 1, 82);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock_botiquines`
--

CREATE TABLE `stock_botiquines` (
  `id_stock` int NOT NULL,
  `id_botiquin` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id_usuario` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(80) NOT NULL,
  `id_rol` int NOT NULL,
  `activo` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id_usuario`, `nombre`, `email`, `password`, `id_rol`, `activo`) VALUES
(1, 'Juan Rangel', 'juan@gmail.com', '$2y$10$9.3fzx6PQL8MxAphoPDGhue1JyLsuAvdIN.yNAPHDPsPt0.xxLrmG', 1, 1),
(2, 'Erick Quispe', 'erick@gmail.com', '$2y$10$Lzjumt4ft73K4IXwlSR4FuxokW47D261NbSv0szpFzvog.VT55ee.', 2, 1),
(3, 'Manu', 'manu@gmail.com', '$2y$10$bE/EDEooJCE94umkXjKzZuxDkATn2u2HQ6X8pwTU.EWXtDy5Js8t.', 3, 1),
(4, 'Alejandro', 'alejandro@gmail.com', '$2y$10$AhYMEH014TyxLkoJIs6NXeSnpM4Bptzvd/Rv7015BV6SEL9jTOemK', 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_botiquines`
--

CREATE TABLE `user_botiquines` (
  `id_usuario` int NOT NULL,
  `id_botiquin` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_hospitales`
--

CREATE TABLE `user_hospitales` (
  `id_usuario` int NOT NULL,
  `id_hospital` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `user_hospitales`
--

INSERT INTO `user_hospitales` (`id_usuario`, `id_hospital`) VALUES
(3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_plantas`
--

CREATE TABLE `user_plantas` (
  `id_usuario` int NOT NULL,
  `id_planta` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  ADD PRIMARY KEY (`id_almacen`),
  ADD KEY `fk_almacen-id_hospital` (`id_hospital`),
  ADD KEY `fk_almacen-id_planta` (`id_planta`);

--
-- Indices de la tabla `botiquines`
--
ALTER TABLE `botiquines`
  ADD PRIMARY KEY (`id_botiquin`),
  ADD KEY `fk_botiquin-id_planta` (`id_planta`);

--
-- Indices de la tabla `hospitales`
--
ALTER TABLE `hospitales`
  ADD PRIMARY KEY (`id_hospital`);

--
-- Indices de la tabla `lecturas`
--
ALTER TABLE `lecturas`
  ADD PRIMARY KEY (`id_lectura`),
  ADD KEY `fk_consumo-id_botiquin` (`id_botiquin`),
  ADD KEY `fk_consumo-id_producto` (`id_producto`),
  ADD KEY `fk_consumo-id_usuario` (`id_usuario`);

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `fk_movimientos-id_producto` (`id_producto`),
  ADD KEY `fk_movimientos-id_almacen_destino` (`id_destino`),
  ADD KEY `fk_movimientos-id_almacen_origen` (`id_origen`),
  ADD KEY `fk_id_botiquin` (`id_botiquin_origen`);

--
-- Indices de la tabla `plantas`
--
ALTER TABLE `plantas`
  ADD PRIMARY KEY (`id_planta`),
  ADD KEY `fk_planta-id_hospital` (`id_hospital`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `reposiciones`
--
ALTER TABLE `reposiciones`
  ADD PRIMARY KEY (`id_reposicion`),
  ADD KEY `fk_reposiciones-id_almacen` (`id_almacen`),
  ADD KEY `fk_reposiciones-id_botiquin` (`id_botiquin`),
  ADD KEY `fk_reposiciones-id_producto` (`id_producto`),
  ADD KEY `fk_reposiciones-id_usuario` (`id_usuario`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `stock_almacenes`
--
ALTER TABLE `stock_almacenes`
  ADD PRIMARY KEY (`id_stock`),
  ADD KEY `fk_stock_almacen_id` (`id_almacen`);

--
-- Indices de la tabla `stock_botiquines`
--
ALTER TABLE `stock_botiquines`
  ADD PRIMARY KEY (`id_stock`),
  ADD KEY `fk_stock_botiquin_id` (`id_botiquin`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `user_botiquines`
--
ALTER TABLE `user_botiquines`
  ADD KEY `fk_botiquin` (`id_botiquin`),
  ADD KEY `fk_usuario_botiquin` (`id_usuario`);

--
-- Indices de la tabla `user_hospitales`
--
ALTER TABLE `user_hospitales`
  ADD KEY `fk_hospital` (`id_hospital`),
  ADD KEY `fk_usuario_hopsital` (`id_usuario`);

--
-- Indices de la tabla `user_plantas`
--
ALTER TABLE `user_plantas`
  ADD KEY `fk_planta` (`id_planta`),
  ADD KEY `fk_usuario_planta` (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  MODIFY `id_almacen` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `botiquines`
--
ALTER TABLE `botiquines`
  MODIFY `id_botiquin` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `hospitales`
--
ALTER TABLE `hospitales`
  MODIFY `id_hospital` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `lecturas`
--
ALTER TABLE `lecturas`
  MODIFY `id_lectura` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  MODIFY `id_movimiento` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `plantas`
--
ALTER TABLE `plantas`
  MODIFY `id_planta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `reposiciones`
--
ALTER TABLE `reposiciones`
  MODIFY `id_reposicion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `stock_almacenes`
--
ALTER TABLE `stock_almacenes`
  MODIFY `id_stock` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `stock_botiquines`
--
ALTER TABLE `stock_botiquines`
  MODIFY `id_stock` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id_usuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `almacenes`
--
ALTER TABLE `almacenes`
  ADD CONSTRAINT `fk_almacen-id_planta` FOREIGN KEY (`id_planta`) REFERENCES `plantas` (`id_planta`) ON DELETE SET NULL ON UPDATE RESTRICT;

--
-- Filtros para la tabla `botiquines`
--
ALTER TABLE `botiquines`
  ADD CONSTRAINT `fk_botiquin-id_planta` FOREIGN KEY (`id_planta`) REFERENCES `plantas` (`id_planta`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `lecturas`
--
ALTER TABLE `lecturas`
  ADD CONSTRAINT `fk_consumo-id_botiquin` FOREIGN KEY (`id_botiquin`) REFERENCES `botiquines` (`id_botiquin`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_consumo-id_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_consumo-id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD CONSTRAINT `fk_id_botiquin` FOREIGN KEY (`id_botiquin_origen`) REFERENCES `botiquines` (`id_botiquin`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_movimientos-id_almacen_destino` FOREIGN KEY (`id_destino`) REFERENCES `almacenes` (`id_almacen`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_movimientos-id_almacen_origen` FOREIGN KEY (`id_origen`) REFERENCES `almacenes` (`id_almacen`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_movimientos-id_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `plantas`
--
ALTER TABLE `plantas`
  ADD CONSTRAINT `fk_planta-id_hospital` FOREIGN KEY (`id_hospital`) REFERENCES `hospitales` (`id_hospital`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `reposiciones`
--
ALTER TABLE `reposiciones`
  ADD CONSTRAINT `fk_reposiciones-id_almacen` FOREIGN KEY (`id_almacen`) REFERENCES `almacenes` (`id_almacen`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_reposiciones-id_botiquin` FOREIGN KEY (`id_botiquin`) REFERENCES `botiquines` (`id_botiquin`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_reposiciones-id_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_reposiciones-id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `stock_almacenes`
--
ALTER TABLE `stock_almacenes`
  ADD CONSTRAINT `fk_stock_almacen_id` FOREIGN KEY (`id_almacen`) REFERENCES `almacenes` (`id_almacen`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `stock_botiquines`
--
ALTER TABLE `stock_botiquines`
  ADD CONSTRAINT `fk_stock_botiquin_id` FOREIGN KEY (`id_botiquin`) REFERENCES `botiquines` (`id_botiquin`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `user_botiquines`
--
ALTER TABLE `user_botiquines`
  ADD CONSTRAINT `fk_botiquin` FOREIGN KEY (`id_botiquin`) REFERENCES `botiquines` (`id_botiquin`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_usuario_botiquin` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `user_hospitales`
--
ALTER TABLE `user_hospitales`
  ADD CONSTRAINT `fk_hospital` FOREIGN KEY (`id_hospital`) REFERENCES `hospitales` (`id_hospital`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_usuario_hopsital` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `user_plantas`
--
ALTER TABLE `user_plantas`
  ADD CONSTRAINT `fk_planta` FOREIGN KEY (`id_planta`) REFERENCES `plantas` (`id_planta`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_usuario_planta` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
