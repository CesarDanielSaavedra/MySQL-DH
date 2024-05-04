-- Schema DH-Playground
-- -----------------------------------------------------
-- Micro desafío 1 - Los usuarios y los cursos:
-- 
-- Queremos tener usuarios, los usuarios tendrán nombre, apellido, email, contraseña y
-- categoría. Los usuarios podrán tener categoría de estudiantes, docentes, editores o
-- administradores.
-- 
-- Lo siguiente que queremos es poder almacenar los cursos, que tendrán un título, una
-- descripción, una imagen, una fecha de inicio, una fecha de finalización y un cupo máximo.
-- Los cursos tendrán unidades (para organizar el contenido) que tendrán un título, una
-- descripción y una fecha de inicio.
-- Los usuarios (de cualquier tipo) podrán estar asociados a cursos.
-- 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DH-Playground` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `DH-Playground` ;

-- -----------------------------------------------------
-- CREACION DE LAS TABLAS
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Table `DH-Playground`.`CATEGORIA_USUARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH-Playground`.`CATEGORIA_USUARIOS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `categoria_UNIQUE` (`categoria` ASC),
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DH-Playground`.`USUARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH-Playground`.`USUARIOS` (
   `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
   `nombre` VARCHAR(45) NOT NULL,
   `apellido` VARCHAR(45) NOT NULL,
   `email` VARCHAR(45) NOT NULL,
   `password_hash` VARCHAR(255) NOT NULL,
   `CATEGORIA_USUARIOS_id` INT NOT NULL,
   PRIMARY KEY (`id`),
   INDEX `fk_USUARIOS_CATEGORIA_USUARIOS_idx` (`CATEGORIA_USUARIOS_id`),
   CONSTRAINT `fk_USUARIOS_CATEGORIA_USUARIOS`
     FOREIGN KEY (`CATEGORIA_USUARIOS_id`)
     REFERENCES `DH-Playground`.`CATEGORIA_USUARIOS` (`id`)
     ON DELETE NO ACTION
     ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DH-Playground`.`IMAGENES_CURSOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH-Playground`.`IMAGENES_CURSOS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo_archivo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DH-Playground`.`CURSOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH-Playground`.`CURSOS` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `IMAGENES_CURSOS_id` INT NOT NULL,
  `fecha_inicio` DATE NULL,
  `fecha_finalizacion` DATE NULL,
  `cupo_maximo` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC),
  INDEX `fk_CURSOS_IMAGENES_CURSOS1_idx` (`IMAGENES_CURSOS_id` ASC),
  CONSTRAINT `fk_CURSOS_IMAGENES_CURSOS1`
    FOREIGN KEY (`IMAGENES_CURSOS_id`)
    REFERENCES `DH-Playground`.`IMAGENES_CURSOS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DH-Playground`.`CURSOS_USUARIOS_REL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH-Playground`.`CURSOS_USUARIOS_REL` (
    `CURSOS_id` INT UNSIGNED NOT NULL,
    `USUARIOS_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`CURSOS_id`, `USUARIOS_id`),
    INDEX `fk_CURSOS_has_USUARIOS_USUARIOS_idx` (`USUARIOS_id`),
    INDEX `fk_CURSOS_has_USUARIOS_CURSOS_idx` (`CURSOS_id`),
    CONSTRAINT `fk_CURSOS_has_USUARIOS_CURSOS`
      FOREIGN KEY (`CURSOS_id`)
      REFERENCES `DH-Playground`.`CURSOS` (`id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `fk_CURSOS_has_USUARIOS_USUARIOS`
      FOREIGN KEY (`USUARIOS_id`)
      REFERENCES `DH-Playground`.`USUARIOS` (`id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `DH-Playground`.`UNIDADES_CURSOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH-Playground`.`UNIDADES_CURSOS` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`titulo` VARCHAR(100) NOT NULL,
	`descripcion` TEXT NOT NULL,
	`fecha_inicio` DATE NULL,
	`CURSOS_id` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC),
    INDEX `fk_CURSOS_idx` (`CURSOS_id` ASC),
	CONSTRAINT `fk_CURSOS`
		FOREIGN KEY (`CURSOS_id`)
		REFERENCES `DH-Playground`.`CURSOS` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- INSERT A LAS TABLAS
-- -----------------------------------------------------
-- -----------------------------------------------------
-- INSERT de usuarios
-- -----------------------------------------------------
INSERT INTO `dh-playground`.`usuarios`
(`id`,
`nombre`,
`apellido`,
`email`,
`password_hash`,
`CATEGORIA_USUARIOS_id`)
VALUES
(<{id: }>,
<{nombre: }>,
<{apellido: }>,
<{email: }>,
<{password_hash: }>,
<{CATEGORIA_USUARIOS_id: }>);

INSERT INTO `dh-playground`.`usuarios`
(`nombre`,
`apellido`,
`email`,
`password_hash`,
`CATEGORIA_USUARIOS_id`)
VALUES
('Juan', 'Garcia', 'juan@example.com', 'aB3$cD6^eF9@hI2*kL5', 1),
('Maria', 'Lopez', 'maria@example.com', 'gH8$jK4*lN1%pR7@sU3', 2),
('Pedro', 'Martinez', 'pedro@example.com', 'qS5&vT9(wX2)zA4#eD3', 1),
('Laura', 'Rodriguez', 'laura@example.com', 'bC7$dE4%fG1^hI5*jK3', 3),
('Diego', 'Hernandez', 'diego@example.com', 'rT9(uW2*yZ4!xQ7#mP5', 4),
('Ana', 'Perez', 'ana@example.com', 'pO2!rE5@sT8#uI3&jK6', 2),
('Carlos', 'Gonzalez', 'carlos@example.com', 'dF9@gH3#jK6$lM1*nP4', 1),
('Sofia', 'Diaz', 'sofia@example.com', 'fG6*hJ3@kL9$mP2#oR5', 3),
('Pablo', 'Sanchez', 'pablo@example.com', 'lN1!qR7$tU4*vX8(wZ2', 4),
('Elena', 'Gomez', 'elena@example.com', 'tU7(wX2#zA5$bC8@dE3', 1),
('Lucas', 'Torres', 'lucas@example.com', 'mP4%nS1&pQ8^rT5(uW2', 2),
('Julia', 'Vazquez', 'julia@example.com', 'sU1!wX4@eD7#gH3$jK6', 3),
('Manuel', 'Fernandez', 'manuel@example.com', 'kL5^mP2(oR9*pS3#uW6', 1),
('Carmen', 'Molina', 'carmen@example.com', 'vX8$wZ2!eD5^rT3@sU7', 2),
('Marcos', 'Ruiz', 'marcos@example.com', 'oR1!pS5@qW9#tY2(uI7', 3),
('Marta', 'Jimenez', 'marta@example.com', 'jK8@lM3*nP7#rT1%sU6', 1),
('Jorge', 'Alvarez', 'jorge@example.com', 'pS4#qW7$tY2(uI9*vX6', 2),
('Luisa', 'Moreno', 'luisa@example.com', 'qW3$rT6!uI9*vX2#zA4', 3),
('Raul', 'Iglesias', 'raul@example.com', 'kL9(lM6*nP3#oR7$pS2', 1),
('Natalia', 'Ortega', 'natalia@example.com', 'mP5$nS1#oR8*pS3^rT7', 2),
('Alejandro', 'Navarro', 'alejandro@example.com', 'sU2@uI6!vX3#wZ9(yZ4', 3),
('Valentina', 'Cruz', 'valentina@example.com', 'wX7$xQ2*yZ9#bC5%nS3', 1),
('Gabriel', 'Santos', 'gabriel@example.com', 'tU4!vX7(wZ1#oR8*pS3', 2),
('Adriana', 'Flores', 'adriana@example.com', 'vX3!wZ8@bC5%cD1^fG6', 3),
('Nicolas', 'Reyes', 'nicolas@example.com', 'yZ2#zA5$bC8%dE4^gH9', 1),
('Isabel', 'Ramirez', 'isabel@example.com', 'qW9$rT4$sU7(tY2#oR5', 2),
('Mateo', 'Gutierrez', 'mateo@example.com', 'lM3*nP7#rT2%sU5&tY8', 3),
('Camila', 'Serrano', 'camila@example.com', 'mP6*nS3#qW9$rT2%uI5', 1),
('Dario', 'Luna', 'dario@example.com', 'pS7$qW2!rT8@sU3^vX5', 2),
('Lorena', 'Delgado', 'lorena@example.com', 'lM4*nP9#oR3$pS7&qW2', 3),
('Maximiliano', 'Castro', 'maximiliano@example.com', 'tY2*uI5#vX8(wZ1$xQ6', 1),
('Valeria', 'Herrera', 'valeria@example.com', 'uI7#vX3(wZ9%xQ5$yZ2', 2),
('Facundo', 'Peralta', 'facundo@example.com', 'oR8*pS3#qW6$rT9%sU5', 3),
('Antonella', 'Rojas', 'antonella@example.com', 'pS4#rT7$sU2@tY5^vX8', 1),
('Tomas', 'Acosta', 'tomas@example.com', 'qW2$rT5%sU9&tY1(uI8', 2),
('Agustina', 'Blanco', 'agustina@example.com', 'rT3$sU7%tY1(uI9*vX6', 3),
('Ezequiel', 'Suarez', 'ezequiel@example.com', 'wZ7*xQ2&cD5#eF9(gH3', 4),
('Federico', 'Martinez', 'federico@example.com', 'cD5#eF9(gH2*jK7', 4),
('Julieta', 'Lopez', 'julieta@example.com', 'uI9*vX6(wZ3$xQ7', 1),
('Juan Pablo', 'Garcia', 'juanpablo@example.com', 'pQ2$rT8%sU5&tY1', 2),
('Cecilia', 'Rodriguez', 'cecilia@example.com', 'rT7%sU4&tY9(uI1', 3),
('Martin', 'Fernandez', 'martin@example.com', 'tY8(uI2*vX5(wZ9', 1),
('Antonio', 'Perez', 'antonio@example.com', 'sU3&tY6(uI8*vX2', 2),
('Victoria', 'Sanchez', 'victoria@example.com', 'tY4(uI7*vX3(wZ9', 3),
('Guadalupe', 'Gomez', 'guadalupe@example.com', 'qW2&rT9(sU4&tY1', 1),
('Santiago', 'Alvarez', 'santiago@example.com', 'wZ5(xQ2$eF9(gH6', 2),
('Dolores', 'Suarez', 'dolores@example.com', 'eF7(gH4*hJ9$jK1', 3),
('Javier', 'Torres', 'javier@example.com', 'rT3@sU7$tY1*uI9', 1),
('Paula', 'Moreno', 'paula@example.com', 'sU5&tY2(uI8*vX4', 2),
('Roberto', 'Rojas', 'roberto@example.com', 'tY7(uI2*vX8(wZ3', 3);

select * from usuarios;

-- -----------------------------------------------------
-- INSERT de categoria_usuarios
-- -----------------------------------------------------
INSERT INTO `dh-playground`.`categoria_usuarios`
(`id`,
`categoria`)
VALUES
(<{id: }>,
<{categoria: }>);

INSERT INTO `dh-playground`.`categoria_usuarios`
(`categoria`)
VALUES
('estudiantes'),
('docentes'),
('editores'),
('administradores');

select * from categoria_usuarios;

-- -----------------------------------------------------
-- INSERT de cursos
-- -----------------------------------------------------
INSERT INTO `dh-playground`.`cursos`
(`id`,
`titulo`,
`descripcion`,
`fecha_inicio`,
`fecha_finalizacion`,
`cupo_maximo`)
VALUES
(<{id: }>,
<{titulo: }>,
<{descripcion: }>,
<{fecha_inicio: }>,
<{fecha_finalizacion: }>,
<{cupo_maximo: }>);

INSERT INTO `dh-playground`.`cursos`
(`id`, `titulo`, `descripcion`, `fecha_inicio`, `fecha_finalizacion`, `cupo_maximo`)
VALUES
(1, 'Curso de Full Stack - Introducción', 'Aprende los fundamentos del desarrollo Full Stack desde cero', '2024-05-01', '2024-06-30', 20),
(2, 'Curso de Full Stack - Avanzado', 'Profundiza en el desarrollo Full Stack y domina tecnologías avanzadas', '2024-06-01', '2024-07-31', 25),
(3, 'Curso de Desarrollo en React', 'Domina el desarrollo de aplicaciones web con React.js', '2024-05-15', '2024-07-15', 15),
(4, 'Curso de Técnicas Avanzadas de CSS', 'Explora técnicas avanzadas de CSS para diseñar sitios web impresionantes', '2024-05-20', '2024-07-20', 20),
(5, 'Curso de Desarrollo en Angular', 'Aprende a crear aplicaciones web dinámicas con Angular', '2024-06-10', '2024-08-10', 20),
(6, 'Curso de Ruby', 'Introducción al lenguaje de programación Ruby y su uso en el desarrollo web', '2024-06-15', '2024-08-15', 20),
(7, 'Curso de Python para Desarrollo Web', 'Aprende a utilizar Python en el desarrollo web y construye aplicaciones escalables', '2024-06-20', '2024-08-20', 25),
(8, 'Curso de Node.js y Express', 'Descubre cómo utilizar Node.js y Express para crear aplicaciones web modernas y eficientes', '2024-07-01', '2024-09-01', 15),
(9, 'Curso de Desarrollo de APIs RESTful', 'Aprende a diseñar, desarrollar y documentar APIs RESTful utilizando las mejores prácticas', '2024-07-10', '2024-09-10', 20),
(10, 'Curso de Vue.js', 'Aprende a construir interfaces de usuario interactivas y dinámicas con Vue.js', '2024-07-15', '2024-09-15', 20);

select * from cursos;

-- -----------------------------------------------------
-- INSERT de imagenes_cursos
-- -----------------------------------------------------
INSERT INTO `dh-playground`.`imagenes_cursos`
(`id`,
`nombre`,
`tipo_archivo`,
`cursos_id`)
VALUES
(<{id: }>,
<{nombre: }>,
<{tipo_archivo: }>,
<{cursos_id: }>);

INSERT INTO `dh-playground`.`imagenes_cursos`
(`id`,
`nombre`,
`tipo_archivo`,
`cursos_id`)
VALUES
(1, 'full_stack_introduccion.jpg', 'jpg', 1),
(2, 'full_stack_avanzado.png', 'png', 2),
(3, 'desarrollo_react.jpeg', 'jpeg', 3),
(4, 'tecnicas_css.gif', 'gif', 4),
(5, 'desarrollo_angular.png', 'png', 5),
(6, 'ruby.jpg', 'jpg', 6),
(7, 'python_web.png', 'png', 7),
(8, 'nodejs_express.jpeg', 'jpeg', 8),
(9, 'apis_restful.gif', 'gif', 9),
(10, 'vuejs.jpg', 'jpg', 10),
(11, 'marketing_digital.png', 'png', 1),
(12, 'fotografia.jpg', 'jpg', 2),
(13, 'react.jpg', 'jpg', 3),
(14, 'css.gif', 'gif', 4),
(15, 'angular.png', 'png', 5),
(16, 'ruby_on_rails.jpg', 'jpg', 6),
(17, 'python_programming.png', 'png', 7),
(18, 'nodejs.jpg', 'jpg', 8),
(19, 'restful_api.gif', 'gif', 9),
(20, 'vuejs_framework.jpg', 'jpg', 10);

select * from imagenes_cursos;

-- -----------------------------------------------------
-- INSERT de cursos_usuarios_rel (tabla de relacion muchos a muchos)
-- -----------------------------------------------------
INSERT INTO `dh-playground`.`cursos_usuarios_rel`
(`CURSOS_id`,
`USUARIOS_id`)
VALUES
(<{CURSOS_id: }>,
<{USUARIOS_id: }>);

INSERT INTO `dh-playground`.`cursos_usuarios_rel` (`CURSOS_id`, `USUARIOS_id`)
VALUES
-- Curso 1: 10 usuarios
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
-- Curso 2: 8 usuarios
(2, 11), (2, 12), (2, 13), (2, 14), (2, 15),
(2, 16), (2, 17), (2, 18),
-- Curso 3: 12 usuarios
(3, 19), (3, 20), (3, 21), (3, 22), (3, 23),
(3, 24), (3, 25), (3, 26), (3, 27), (3, 28),
(3, 29), (3, 30),
-- Curso 4: 6 usuarios
(4, 31), (4, 32), (4, 33), (4, 34), (4, 35),
(4, 36),
-- Curso 5: 15 usuarios
(5, 37), (5, 38), (5, 39), (5, 40), (5, 41),
(5, 42), (5, 43), (5, 44), (5, 45), (5, 46),
(5, 47), (5, 48), (5, 49), (5, 50), (5, 1),
-- Curso 6: 7 usuarios
(6, 2), (6, 3), (6, 4), (6, 5), (6, 6),
(6, 7), (6, 8),
-- Curso 7: 11 usuarios
(7, 9), (7, 10), (7, 11), (7, 12), (7, 13),
(7, 14), (7, 15), (7, 16), (7, 17), (7, 18),
(7, 19),
-- Curso 8: 9 usuarios
(8, 20), (8, 21), (8, 22), (8, 23), (8, 24),
(8, 25), (8, 26), (8, 27), (8, 28),
-- Curso 9: 14 usuarios
(9, 29), (9, 30), (9, 31), (9, 32), (9, 33),
(9, 34), (9, 35), (9, 36), (9, 37), (9, 38),
(9, 39), (9, 40), (9, 41), (9, 42),
-- Curso 10: 13 usuarios
(10, 43), (10, 44), (10, 45), (10, 46), (10, 47),
(10, 48), (10, 49), (10, 50), (10, 1), (10, 2),
(10, 3), (10, 4), (10, 5);

-- -----------------------------------------------------
-- INSERT de unidades_cursos
-- -----------------------------------------------------
INSERT INTO `dh-playground`.`unidades_cursos`
(`id`,
`titulo`,
`descripcion`,
`fecha_inicio`,
`CURSOS_id`)
VALUES
(<{id: }>,
<{titulo: }>,
<{descripcion: }>,
<{fecha_inicio: }>,
<{CURSOS_id: }>);

INSERT INTO `dh-playground`.`unidades_cursos`
(`titulo`,
`descripcion`,
`fecha_inicio`,
`CURSOS_id`)
VALUES
-- Unidades para el Curso 1: Full Stack - Introducción
('Introducción a HTML y CSS', 'Aprende los fundamentos de HTML y CSS para crear páginas web básicas.', '2024-05-01', 1),
('Introducción a JavaScript', 'Conoce los conceptos básicos de JavaScript y cómo interactúa con HTML y CSS.', '2024-05-10', 1),
('Estructuras de datos en JavaScript', 'Explora las estructuras de datos fundamentales en JavaScript como arrays y objetos.', '2024-05-20', 1),

-- Unidades para el Curso 2: Full Stack - Avanzado
('Node.js y Express', 'Aprende a construir servidores web con Node.js y Express.', '2024-06-01', 2),
('Bases de datos SQL', 'Introducción a las bases de datos relacionales y SQL.', '2024-06-10', 2),
('Desarrollo de aplicaciones web completas', 'Aprende a integrar todas las tecnologías aprendidas para desarrollar aplicaciones web completas.', '2024-06-20', 2),

-- Unidades para el Curso 3: Desarrollo en React
('Fundamentos de React.js', 'Introducción a React.js y el desarrollo de interfaces de usuario.', '2024-05-15', 3),
('Componentes en React', 'Aprende a crear y reutilizar componentes en React.', '2024-05-25', 3),
('Rutas y Navegación', 'Gestiona la navegación en tu aplicación React con React Router.', '2024-06-05', 3),

-- Unidades para el Curso 4: Técnicas Avanzadas de CSS
('Flexbox y Grid', 'Domina las técnicas de posicionamiento y diseño flexible con Flexbox y Grid.', '2024-05-20', 4),
('Animaciones CSS', 'Crea animaciones impresionantes con CSS y Keyframes.', '2024-06-01', 4),
('Preprocesadores CSS', 'Introducción a preprocesadores CSS como Sass para mejorar la eficiencia en el desarrollo.', '2024-06-15', 4),

-- Unidades para el Curso 5: Desarrollo en Angular
('Introducción a Angular', 'Aprende los conceptos básicos de Angular y cómo crear componentes.', '2024-06-10', 5),
('Directivas en Angular', 'Explora el uso de directivas en Angular para crear componentes reutilizables.', '2024-06-20', 5),
('Servicios y Dependency Injection', 'Comprende la inyección de dependencias y la creación de servicios en Angular.', '2024-07-01', 5),

-- Unidades para el Curso 6: Ruby
('Introducción a Ruby', 'Aprende los fundamentos del lenguaje de programación Ruby.', '2024-06-15', 6),
('Ruby on Rails', 'Desarrollo de aplicaciones web con el framework Ruby on Rails.', '2024-06-25', 6),
('Testing en Ruby', 'Conoce las mejores prácticas para realizar pruebas unitarias y de integración en Ruby.', '2024-07-05', 6),

-- Unidades para el Curso 7: Python para Desarrollo Web
('Introducción a Python', 'Aprende los conceptos básicos de Python y su sintaxis.', '2024-06-20', 7),
('Desarrollo de aplicaciones web con Flask', 'Construye aplicaciones web con el microframework Flask en Python.', '2024-07-01', 7),
('Django: Framework MVC', 'Explora el framework Django para el desarrollo web en Python.', '2024-07-15', 7),

-- Unidades para el Curso 8: Node.js y Express
('Introducción a Node.js', 'Comprende los fundamentos de Node.js y su modelo de E/S no bloqueante.', '2024-07-01', 8),
('Express.js: Framework web', 'Desarrollo de servidores web con el framework Express.js.', '2024-07-15', 8),
('Manejo de archivos y datos en Node.js', 'Aprende a manejar archivos y datos en Node.js con módulos como fs y path.', '2024-07-30', 8),

-- Unidades para el Curso 9: Desarrollo de APIs RESTful
('Conceptos de API y REST', 'Introducción a los conceptos de API y el estilo arquitectónico REST.', '2024-07-10', 9),

-- Unidades para el Curso 10: Curso de Vue.js
('Introducción a Vue.js', 'Aprende los conceptos básicos de Vue.js y cómo construir aplicaciones interactivas.', '2024-07-15', 10),
('Componentes en Vue.js', 'Explora el concepto de componentes en Vue.js para construir aplicaciones modulares y reutilizables.', '2024-07-25', 10),
('Routing en Vue.js', 'Gestiona la navegación en tu aplicación Vue.js con Vue Router.', '2024-08-05', 10),
('Gestión de Estado con Vuex', 'Comprende y utiliza Vuex para la gestión centralizada del estado en aplicaciones Vue.js.', '2024-08-15', 10),
('Desarrollo de Aplicaciones Complejas', 'Aprende a desarrollar aplicaciones web complejas con Vue.js integrando todas las funcionalidades aprendidas.', '2024-08-25', 10);

select * from unidades_cursos;


-- -----------------------------------------------------
-- Micro desafío 2 - El contenido del curso:
-- Las unidades contendrán clases que también tendrán un título, una descripción, una
-- fecha de inicio, y una marca de visibilidad (si el bloque está visible o no).
-- Las clases contendrán bloques. Los bloques tendrán un título y una marca de visibilidad.
-- Los bloques podrán ser de diferente tipo: texto, video, presentación, PDF o archivo.
-- Los bloques también tendrán que poder guardar el contenido, sea texto o una URL, en
-- caso de que el tipo sea video, presentación, PDF o archivo.
--
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `DH-Playground`.`CLASES_UNIDADES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH-Playground`.`CLASES_UNIDADES` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`titulo` VARCHAR(100) NOT NULL,
	`descripcion` TEXT NOT NULL,
	`fecha_inicio` DATE NULL,
	`UNIDAD_id` INT UNSIGNED NOT NULL,
    `visibilidad` TINYINT(1) NOT NULL DEFAULT 1, -- (1: Visible, 0: No visible)
	PRIMARY KEY (`id`),
	UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC),
    INDEX `fk_UNIDAD_CURSOS_idx` (`UNIDAD_id` ASC),
	CONSTRAINT `fk_UNIDAD`
		FOREIGN KEY (`UNIDAD_id`)
		REFERENCES `DH-Playground`.`UNIDADES_CURSOS` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- INSERT a la tabla CLASES_UNIDADES
-- -----------------------------------------------------
INSERT INTO `dh-playground`.`clases_unidades`
(`id`,
`titulo`,
`descripcion`,
`fecha_inicio`,
`UNIDAD_id`,
`visibilidad`)
VALUES
(<{id: }>,
<{titulo: }>,
<{descripcion: }>,
<{fecha_inicio: }>,
<{UNIDAD_id: }>,
<{visibilidad: 1}>);

INSERT INTO `dh-playground`.`clases_unidades`
(`titulo`,
`descripcion`,
`fecha_inicio`,
`UNIDAD_id`,
`visibilidad`)
VALUES
-- Clases para la Unidad 1: Introducción a HTML y CSS
('Clase 1 Unidad 1', 'Descripción de la Clase 1 Unidad 1', '2024-05-01', 1, 0),
('Clase 2 Unidad 1', 'Descripción de la Clase 2 Unidad 1', '2024-05-05', 1, 0),
('Clase 3 Unidad 1', 'Descripción de la Clase 3 Unidad 1', '2024-05-10', 1, 0),
('Clase 4 Unidad 1', 'Descripción de la Clase 4 Unidad 1', '2024-05-15', 1, 0),

-- Clases para la Unidad 2: Introducción a JavaScript
('Clase 1 Unidad 2', 'Descripción de la Clase 1 Unidad 2', '2024-05-10', 2, 0),
('Clase 2 Unidad 2', 'Descripción de la Clase 2 Unidad 2', '2024-05-15', 2, 0),

-- Clases para la Unidad 3: Estructuras de datos en JavaScript
('Clase 1 Unidad 3', 'Descripción de la Clase 1 Unidad 3', '2024-05-20', 3, 0),

-- Clases para la Unidad 4: Node.js y Express
('Clase 1 Unidad 4', 'Descripción de la Clase 1 Unidad 4', '2024-06-01', 4, 0),
('Clase 2 Unidad 4', 'Descripción de la Clase 2 Unidad 4', '2024-06-05', 4, 0),
('Clase 3 Unidad 4', 'Descripción de la Clase 3 Unidad 4', '2024-06-10', 4, 0),

-- Clases para la Unidad 5: Bases de datos SQL
('Clase 1 Unidad 5', 'Descripción de la Clase 1 Unidad 5', '2024-06-10', 5, 0),
('Clase 2 Unidad 5', 'Descripción de la Clase 2 Unidad 5', '2024-06-15', 5, 0),
('Clase 3 Unidad 5', 'Descripción de la Clase 3 Unidad 5', '2024-06-20', 5, 0),

-- Clases para la Unidad 6: Desarrollo de aplicaciones web con Flask
('Clase 1 Unidad 6', 'Descripción de la Clase 1 Unidad 6', '2024-06-25', 6, 0),
('Clase 2 Unidad 6', 'Descripción de la Clase 2 Unidad 6', '2024-07-01', 6, 0),
('Clase 3 Unidad 6', 'Descripción de la Clase 3 Unidad 6', '2024-07-05', 6, 0),

-- Clases para la Unidad 7: Django: Framework MVC
('Clase 1 Unidad 7', 'Descripción de la Clase 1 Unidad 7', '2024-07-15', 7, 0),
('Clase 2 Unidad 7', 'Descripción de la Clase 2 Unidad 7', '2024-07-20', 7, 0),
('Clase 3 Unidad 7', 'Descripción de la Clase 3 Unidad 7', '2024-07-25', 7, 0),

-- Clases para la Unidad 8: Introducción a Node.js
('Clase 1 Unidad 8', 'Descripción de la Clase 1 Unidad 8', '2024-07-30', 8, 0),
('Clase 2 Unidad 8', 'Descripción de la Clase 2 Unidad 8', '2024-08-05', 8, 0),
('Clase 3 Unidad 8', 'Descripción de la Clase 3 Unidad 8', '2024-08-10', 8, 0),

-- Clases para la Unidad 9: Introducción a Vue.js
('Clase 1 Unidad 9', 'Descripción de la Clase 1 Unidad 9', '2024-08-15', 9, 0),
('Clase 2 Unidad 9', 'Descripción de la Clase 2 Unidad 9', '2024-08-20', 9, 0),
('Clase 3 Unidad 9', 'Descripción de la Clase 3 Unidad 9', '2024-08-25', 9, 0),

-- Clases para la Unidad 10: Desarrollo de Aplicaciones Complejas
('Clase 1 Unidad 10', 'Descripción de la Clase 1 Unidad 10', '2024-09-01', 10, 0),
('Clase 2 Unidad 10', 'Descripción de la Clase 2 Unidad 10', '2024-09-05', 10, 0),
('Clase 3 Unidad 10', 'Descripción de la Clase 3 Unidad 10', '2024-09-10', 10, 0),

-- Clases para la Unidad 11: Conceptos de API y REST
('Clase 1 Unidad 11', 'Descripción de la Clase 1 Unidad 11', '2024-09-15', 11, 0),
('Clase 2 Unidad 11', 'Descripción de la Clase 2 Unidad 11', '2024-09-20', 11, 0),
('Clase 3 Unidad 11', 'Descripción de la Clase 3 Unidad 11', '2024-09-25', 11, 0),

-- Clases para la Unidad 12: Introducción a Ruby
('Clase 1 Unidad 12', 'Descripción de la Clase 1 Unidad 12', '2024-09-30', 12, 0),
('Clase 2 Unidad 12', 'Descripción de la Clase 2 Unidad 12', '2024-10-05', 12, 0),
('Clase 3 Unidad 12', 'Descripción de la Clase 3 Unidad 12', '2024-10-10', 12, 0),

-- Clases para la Unidad 13: Introducción a Python
('Clase 1 Unidad 13', 'Descripción de la Clase 1 Unidad 13', '2024-10-15', 13, 0),
('Clase 2 Unidad 13', 'Descripción de la Clase 2 Unidad 13', '2024-10-20', 13, 0),
('Clase 3 Unidad 13', 'Descripción de la Clase 3 Unidad 13', '2024-10-25', 13, 0),

-- Clases para la Unidad 14: Desarrollo de aplicaciones web completas
('Clase 1 Unidad 14', 'Descripción de la Clase 1 Unidad 14', '2024-10-30', 14, 0),
('Clase 2 Unidad 14', 'Descripción de la Clase 2 Unidad 14', '2024-11-05', 14, 0),
('Clase 3 Unidad 14', 'Descripción de la Clase 3 Unidad 14', '2024-11-10', 14, 0),

-- Clases para la Unidad 15: Flexbox y Grid
('Clase 1 Unidad 15', 'Descripción de la Clase 1 Unidad 15', '2024-11-15', 15, 0),
('Clase 2 Unidad 15', 'Descripción de la Clase 2 Unidad 15', '2024-11-20', 15, 0),
('Clase 3 Unidad 15', 'Descripción de la Clase 3 Unidad 15', '2024-11-25', 15, 0),

-- Clases para la Unidad 16: Animaciones CSS
('Clase 1 Unidad 16', 'Descripción de la Clase 1 Unidad 16', '2024-12-01', 16, 0),
('Clase 2 Unidad 16', 'Descripción de la Clase 2 Unidad 16', '2024-12-05', 16, 0),
('Clase 3 Unidad 16', 'Descripción de la Clase 3 Unidad 16', '2024-12-10', 16, 0),

-- Clases para la Unidad 17: Desarrollo de aplicaciones web con Flask
('Clase 1 Unidad 17', 'Descripción de la Clase 1 Unidad 17', '2024-12-15', 17, 0),
('Clase 2 Unidad 17', 'Descripción de la Clase 2 Unidad 17', '2024-12-20', 17, 0),
('Clase 3 Unidad 17', 'Descripción de la Clase 3 Unidad 17', '2024-12-25', 17, 0),

-- Clases para la Unidad 18: Django: Framework MVC
('Clase 1 Unidad 18', 'Descripción de la Clase 1 Unidad 18', '2024-12-30', 18, 0),
('Clase 2 Unidad 18', 'Descripción de la Clase 2 Unidad 18', '2025-01-05', 18, 0),
('Clase 3 Unidad 18', 'Descripción de la Clase 3 Unidad 18', '2025-01-10', 18, 0),

-- Clases para la Unidad 19: Introducción a Node.js
('Clase 1 Unidad 19', 'Descripción de la Clase 1 Unidad 19', '2025-01-15', 19, 0),
('Clase 2 Unidad 19', 'Descripción de la Clase 2 Unidad 19', '2025-01-20', 19, 0),
('Clase 3 Unidad 19', 'Descripción de la Clase 3 Unidad 19', '2025-01-25', 19, 0),

-- Clases para la Unidad 20: Express.js: Framework web
('Clase 1 Unidad 20', 'Descripción de la Clase 1 Unidad 20', '2025-01-30', 20, 0),
('Clase 2 Unidad 20', 'Descripción de la Clase 2 Unidad 20', '2025-02-05', 20, 0),
('Clase 3 Unidad 20', 'Descripción de la Clase 3 Unidad 20', '2025-02-10', 20, 0),

-- Clases para la Unidad 21: Manejo de archivos y datos en Node.js
('Clase 1 Unidad 21', 'Descripción de la Clase 1 Unidad 21', '2025-02-15', 21, 0),
('Clase 2 Unidad 21', 'Descripción de la Clase 2 Unidad 21', '2025-02-20', 21, 0),
('Clase 3 Unidad 21', 'Descripción de la Clase 3 Unidad 21', '2025-02-25', 21, 0),

-- Clases para la Unidad 22: Conceptos de API y REST
('Clase 1 Unidad 22', 'Descripción de la Clase 1 Unidad 22', '2025-03-01', 22, 0),
('Clase 2 Unidad 22', 'Descripción de la Clase 2 Unidad 22', '2025-03-05', 22, 0),
('Clase 3 Unidad 22', 'Descripción de la Clase 3 Unidad 22', '2025-03-10', 22, 0),

-- Clases para la Unidad 23: Introducción a Vue.js
('Clase 1 Unidad 23', 'Descripción de la Clase 1 Unidad 23', '2025-03-15', 23, 0),
('Clase 2 Unidad 23', 'Descripción de la Clase 2 Unidad 23', '2025-03-20', 23, 0),
('Clase 3 Unidad 23', 'Descripción de la Clase 3 Unidad 23', '2025-03-25', 23, 0),

-- Clases para la Unidad 24: Componentes en Vue.js
('Clase 1 Unidad 24', 'Descripción de la Clase 1 Unidad 24', '2025-03-30', 24, 0),
('Clase 2 Unidad 24', 'Descripción de la Clase 2 Unidad 24', '2025-04-05', 24, 0),
('Clase 3 Unidad 24', 'Descripción de la Clase 3 Unidad 24', '2025-04-10', 24, 0),

-- Clases para la Unidad 25: Routing en Vue.js
('Clase 1 Unidad 25', 'Descripción de la Clase 1 Unidad 25', '2025-04-15', 25, 0),
('Clase 2 Unidad 25', 'Descripción de la Clase 2 Unidad 25', '2025-04-20', 25, 0),
('Clase 3 Unidad 25', 'Descripción de la Clase 3 Unidad 25', '2025-04-25', 25, 0),

-- Clases para la Unidad 26: Gestión de Estado con Vuex
('Clase 1 Unidad 26', 'Descripción de la Clase 1 Unidad 26', '2025-05-01', 26, 0),
('Clase 2 Unidad 26', 'Descripción de la Clase 2 Unidad 26', '2025-05-05', 26, 0),
('Clase 3 Unidad 26', 'Descripción de la Clase 3 Unidad 26', '2025-05-10', 26, 0),

-- Clases para la Unidad 27: Desarrollo de Aplicaciones Complejas
('Clase 1 Unidad 27', 'Descripción de la Clase 1 Unidad 27', '2025-05-15', 27, 0),
('Clase 2 Unidad 27', 'Descripción de la Clase 2 Unidad 27', '2025-05-20', 27, 0),
('Clase 3 Unidad 27', 'Descripción de la Clase 3 Unidad 27', '2025-05-25', 27, 0),

-- Clases para la Unidad 28: Clase de Ejemplo
('Clase 1 Unidad 28', 'Descripción de la Clase 1 Unidad 28', '2025-05-30', 28, 0),
('Clase 2 Unidad 28', 'Descripción de la Clase 2 Unidad 28', '2025-06-05', 28, 0),
('Clase 3 Unidad 28', 'Descripción de la Clase 3 Unidad 28', '2025-06-10', 28, 0),

-- Clases para la Unidad 29: Otra Clase de Ejemplo
('Clase 1 Unidad 29', 'Descripción de la Clase 1 Unidad 29', '2025-06-15', 29, 0),
('Clase 2 Unidad 29', 'Descripción de la Clase 2 Unidad 29', '2025-06-20', 29, 0),
('Clase 3 Unidad 29', 'Descripción de la Clase 3 Unidad 29', '2025-06-25', 29, 0),

-- Clases para la Unidad 30: Última Clase
('Clase 1 Unidad 30', 'Descripción de la Clase 1 Unidad 30', '2025-06-30', 30, 0),
('Clase 2 Unidad 30', 'Descripción de la Clase 2 Unidad 30', '2025-07-05', 30, 0),
('Clase 3 Unidad 30', 'Descripción de la Clase 3 Unidad 30', '2025-07-10', 30, 0);


-- -----------------------------------------------------
-- Table `DH-Playground`.`BLOQUES_CLASES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH-Playground`.`BLOQUES_CLASES` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`titulo` VARCHAR(100) NOT NULL,
    `visibilidad` TINYINT(1) NOT NULL DEFAULT 1, -- (1: Visible, 0: No visible)
	`contenido` TEXT NOT NULL,
	`tipo`  VARCHAR(45) NOT NULL,
	`CLASES_id` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC),
    INDEX `fk_BLOQUES_CLASES_idx` (`CLASES_id` ASC),
	CONSTRAINT `fk_CLASES`
		FOREIGN KEY (`CLASES_id`)
		REFERENCES `DH-Playground`.`CLASES_UNIDADES` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- INSERT a la tabla BLOQUES_CLASES
-- -----------------------------------------------------
INSERT INTO `dh-playground`.`bloques_clases`
(`id`,
`titulo`,
`visibilidad`,
`contenido`,
`tipo`,
`CLASES_id`)
VALUES
(<{id: }>,
<{titulo: }>,
<{visibilidad: 1}>,
<{contenido: }>,
<{tipo: }>,
<{CLASES_id: }>);


-- Se me fue de escala y el insert de bloques para todas las clases era enorme, por lo que  solo algunas clases tendran bloques
INSERT INTO `dh-playground`.`bloques_clases`
(`titulo`, `visibilidad`, `contenido`, `tipo`, `CLASES_id`)
VALUES
-- Bloques para la Clase 1 Unidad 1
('Bloque 1 de la Clase 1 Unidad 1', 1, 'Contenido del bloque 1 de la Clase 1 Unidad 1', 'Texto', 1),
('Bloque 2 de la Clase 1 Unidad 1', 1, 'Contenido del bloque 2 de la Clase 1 Unidad 1', 'Texto', 2),
('Bloque 3 de la Clase 1 Unidad 1', 1, 'Contenido del bloque 3 de la Clase 1 Unidad 1', 'Texto', 3),

-- Bloques para la Clase 1 Unidad 2
('Bloque 1 de la Clase 1 Unidad 2', 1, 'Contenido del bloque 1 de la Clase 1 Unidad 2', 'Texto', 4),
('Bloque 2 de la Clase 1 Unidad 2', 1, 'Contenido del bloque 2 de la Clase 1 Unidad 2', 'Texto', 5),

-- Bloques para la Clase 1 Unidad 3
('Bloque 1 de la Clase 1 Unidad 3', 1, 'Contenido del bloque 1 de la Clase 1 Unidad 3', 'Texto', 6),

-- Bloques para la Clase 1 Unidad 6
('Bloque 1 de la Clase 1 Unidad 6', 1, 'Contenido del bloque 1 de la Clase 1 Unidad 6', 'Texto', 14),
('Bloque 2 de la Clase 1 Unidad 6', 1, 'Contenido del bloque 2 de la Clase 1 Unidad 6', 'Texto', 15),

-- Bloques para la Clase 1 Unidad 7
('Bloque 1 de la Clase 1 Unidad 7', 1, 'Contenido del bloque 1 de la Clase 1 Unidad 7', 'Texto', 17),

-- Bloques para la Clase 1 Unidad 26
('Bloque 1 de la Clase 1 Unidad 26', 1, 'Contenido del bloque 1 de la Clase 1 Unidad 26', 'Texto', 74),
('Bloque 2 de la Clase 1 Unidad 26', 1, 'Contenido del bloque 2 de la Clase 1 Unidad 26', 'Texto', 75),
('Bloque 3 de la Clase 1 Unidad 26', 1, 'Contenido del bloque 3 de la Clase 1 Unidad 26', 'Texto', 76);


SELECT * FROM bloques_clases;
