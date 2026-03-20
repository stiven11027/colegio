-- Base de datos academica LIMPIA Y VALIDADA
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

CREATE DATABASE IF NOT EXISTS `colegio_rural` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `colegio_rural`;

-- ===== TABLA 1: ROL =====
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion` varchar(200) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=5;

INSERT INTO `rol` (`id_rol`, `nombre_rol`, `descripcion`) VALUES
(1, 'Administrador', 'Control total del sistema'),
(2, 'Profesor', 'Gestion de calificaciones y asistencia'),
(3, 'Estudiante', 'Acceso a calificaciones y horarios'),
(4, 'Acudiente', 'Seguimiento del estudiante');

-- ===== TABLA 2: USUARIO =====
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `ID` int(11) NOT NULL PRIMARY KEY,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NULL,
  `email` varchar(100) NULL UNIQUE,
  `id_rol` int(11) NOT NULL DEFAULT 3,
  `estado` varchar(20) DEFAULT 'Activo',
  `pass` varchar(200) NOT NULL,
  `fecha_creacion` timestamp DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `usuario` (`ID`, `nombres`, `apellidos`, `email`, `id_rol`, `estado`, `pass`) VALUES
(1, 'Admin', 'System', 'admin@colegio.edu.co', 1, 'Activo', 'admin123'),
(2, 'Juan', 'Profesor', 'juan@colegio.edu.co', 2, 'Activo', 'prof123'),
(1072493621, 'Stiven', 'Cifuentes', 'stiven@colegio.edu.co', 3, 'Activo', '1111');

-- ===== TABLA 3: ESTUDIANTE =====
DROP TABLE IF EXISTS `estudiante`;
CREATE TABLE `estudiante` (
  `id_estudiante` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_usuario` int(11) NOT NULL,
  `numero_documento` varchar(20) NULL UNIQUE,
  `grado` varchar(20) NULL,
  `fecha_nacimiento` date NULL,
  `genero` varchar(10) NULL,
  `direccion` varchar(200) NULL,
  `ciudad` varchar(100) NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  `fecha_matricula` date NULL,
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=2;

INSERT INTO `estudiante` (`id_usuario`, `numero_documento`, `grado`, `fecha_nacimiento`, `genero`, `direccion`, `ciudad`, `fecha_matricula`) VALUES
(1072493621, '1072493621', '5', '2013-05-15', 'M', 'Calle 10 #5-20', 'Bogota', '2024-01-15');

-- ===== TABLA 4: PROFESOR =====
DROP TABLE IF EXISTS `profesor`;
CREATE TABLE `profesor` (
  `id_profesor` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_usuario` int(11) NOT NULL,
  `numero_documento` varchar(20) NULL UNIQUE,
  `especialidad` varchar(100) NULL,
  `titulo_profesional` varchar(100) NULL,
  `telefono` varchar(20) NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  `fecha_vinculacion` date NULL,
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=2;

INSERT INTO `profesor` (`id_usuario`, `numero_documento`, `especialidad`, `titulo_profesional`, `telefono`, `fecha_vinculacion`) VALUES
(2, '12345678', 'Matematicas', 'Licenciado en Educacion', '3001234567', '2023-01-01');

-- ===== TABLA 5: ACUDIENTE =====
DROP TABLE IF EXISTS `acudiente`;
CREATE TABLE `acudiente` (
  `id_acudiente` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_usuario` int(11) NOT NULL,
  `numero_documento` varchar(20) NULL UNIQUE,
  `relacion` varchar(50) NULL,
  `telefono` varchar(20) NULL,
  `ocupacion` varchar(100) NULL,
  `direccion` varchar(200) NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=1;

-- ===== TABLA 6: CURSO =====
DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre_curso` varchar(50) NOT NULL,
  `grado` varchar(20) NOT NULL,
  `jornada` varchar(20) NULL,
  `capacidad` int(3) NULL,
  `id_profesor_principal` int(11) NULL,
  `año_academico` int(4) NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  FOREIGN KEY (`id_profesor_principal`) REFERENCES `profesor`(`id_profesor`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=3;

INSERT INTO `curso` (`nombre_curso`, `grado`, `jornada`, `capacidad`, `id_profesor_principal`, `año_academico`, `estado`) VALUES
('5A', '5', 'Manana', 35, 1, 2024, 'Activo'),
('5B', '5', 'Manana', 35, 1, 2024, 'Activo');

-- ===== TABLA 7: MATERIA =====
DROP TABLE IF EXISTS `materia`;
CREATE TABLE `materia` (
  `id_materia` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre_materia` varchar(100) NOT NULL,
  `codigo_materia` varchar(20) NULL UNIQUE,
  `intensidad_horaria` int(3) NULL,
  `estado` varchar(20) DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=8;

INSERT INTO `materia` (`nombre_materia`, `codigo_materia`, `intensidad_horaria`, `estado`) VALUES
('Matematicas', 'MAT001', 5, 'Activo'),
('Lengua Castellana', 'LEN001', 5, 'Activo'),
('Ciencias Naturales', 'CIN001', 4, 'Activo'),
('Ciencias Sociales', 'CIS001', 4, 'Activo'),
('Ingles', 'ING001', 3, 'Activo'),
('Educacion Fisica', 'EDF001', 2, 'Activo'),
('Arte', 'ART001', 2, 'Activo');

-- ===== TABLA 8: ESTUDIANTE_CURSO =====
DROP TABLE IF EXISTS `estudiante_curso`;
CREATE TABLE `estudiante_curso` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_estudiante` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `fecha_inscripcion` date DEFAULT CURRENT_DATE,
  `estado` varchar(20) DEFAULT 'Activo',
  UNIQUE KEY `unique_estudiante_curso` (`id_estudiante`, `id_curso`),
  FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante`(`id_estudiante`) ON DELETE CASCADE,
  FOREIGN KEY (`id_curso`) REFERENCES `curso`(`id_curso`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=2;

INSERT INTO `estudiante_curso` (`id_estudiante`, `id_curso`, `fecha_inscripcion`) VALUES
(1, 1, '2024-01-15');

-- ===== TABLA 9: PROFESOR_MATERIA_CURSO =====
DROP TABLE IF EXISTS `profesor_materia_curso`;
CREATE TABLE `profesor_materia_curso` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_profesor` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `periodo` int(2) NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  UNIQUE KEY `unique_profesor_materia_curso` (`id_profesor`, `id_materia`, `id_curso`),
  FOREIGN KEY (`id_profesor`) REFERENCES `profesor`(`id_profesor`) ON DELETE CASCADE,
  FOREIGN KEY (`id_materia`) REFERENCES `materia`(`id_materia`) ON DELETE CASCADE,
  FOREIGN KEY (`id_curso`) REFERENCES `curso`(`id_curso`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=1;

-- ===== TABLA 10: ESTUDIANTE_ACUDIENTE =====
DROP TABLE IF EXISTS `estudiante_acudiente`;
CREATE TABLE `estudiante_acudiente` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_estudiante` int(11) NOT NULL,
  `id_acudiente` int(11) NOT NULL,
  `es_tutor_legal` tinyint(1) DEFAULT 1,
  `estado` varchar(20) DEFAULT 'Activo',
  FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante`(`id_estudiante`) ON DELETE CASCADE,
  FOREIGN KEY (`id_acudiente`) REFERENCES `acudiente`(`id_acudiente`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=1;

-- ===== TABLA 11: HORARIO =====
DROP TABLE IF EXISTS `horario`;
CREATE TABLE `horario` (
  `id_horario` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_curso` int(11) NOT NULL,
  `id_profesor` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `dia_semana` varchar(20) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `salon` varchar(20) NULL,
  `estado` varchar(20) DEFAULT 'Activo',
  FOREIGN KEY (`id_curso`) REFERENCES `curso`(`id_curso`) ON DELETE CASCADE,
  FOREIGN KEY (`id_profesor`) REFERENCES `profesor`(`id_profesor`) ON DELETE CASCADE,
  FOREIGN KEY (`id_materia`) REFERENCES `materia`(`id_materia`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=1;

-- ===== TABLA 12: ASISTENCIA =====
DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE `asistencia` (
  `id_asistencia` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_estudiante` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `estado_asistencia` varchar(20) NULL,
  `observacion` varchar(200) NULL,
  `registrado_por` int(11) NULL,
  `fecha_registro` timestamp DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante`(`id_estudiante`) ON DELETE CASCADE,
  FOREIGN KEY (`id_curso`) REFERENCES `curso`(`id_curso`) ON DELETE CASCADE,
  FOREIGN KEY (`registrado_por`) REFERENCES `profesor`(`id_profesor`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=1;

-- ===== TABLA 13: CALIFICACION =====
DROP TABLE IF EXISTS `calificacion`;
CREATE TABLE `calificacion` (
  `id_calificacion` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_estudiante` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `id_profesor` int(11) NOT NULL,
  `periodo` int(2) NOT NULL,
  `nota` decimal(5,2) NULL,
  `nota_numerica` int(3) NULL,
  `estado_nota` varchar(20) NULL,
  `observacion` varchar(200) NULL,
  `fecha_registro` timestamp DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante`(`id_estudiante`) ON DELETE CASCADE,
  FOREIGN KEY (`id_materia`) REFERENCES `materia`(`id_materia`) ON DELETE CASCADE,
  FOREIGN KEY (`id_curso`) REFERENCES `curso`(`id_curso`) ON DELETE CASCADE,
  FOREIGN KEY (`id_profesor`) REFERENCES `profesor`(`id_profesor`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=1;

-- ===== TABLA 14: CALENDARIO_ACADEMICO =====
DROP TABLE IF EXISTS `calendario_academico`;
CREATE TABLE `calendario_academico` (
  `id_calendario` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nombre_evento` varchar(100) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `tipo_evento` varchar(50) NULL,
  `descripcion` varchar(200) NULL,
  `año_academico` int(4) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=1;

-- ===== TABLA 15: CONFIGURACION =====
DROP TABLE IF EXISTS `configuracion`;
CREATE TABLE `configuracion` (
  `id_config` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `clave` varchar(100) NOT NULL UNIQUE,
  `valor` varchar(255) NULL,
  `descripcion` varchar(200) NULL,
  `tipo_dato` varchar(50) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT=6;

INSERT INTO `configuracion` (`clave`, `valor`, `descripcion`, `tipo_dato`) VALUES
('nombre_institucion', 'COLEGIO RURAL', 'Nombre de la institucion', 'text'),
('año_academico', '2024', 'Año academico actual', 'numeric'),
('periodos_academicos', '4', 'Cantidad de periodos academicos', 'numeric'),
('foto_perfil_permitida', '5', 'Tamaño maximo de foto (MB)', 'numeric'),
('escala_calificacion', '1-100', 'Escala de calificacion', 'text');

COMMIT;
