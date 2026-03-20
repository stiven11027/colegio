-- Base de datos academica - LIMPIA Y COMPLETA
SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS colegio_rural;
CREATE DATABASE colegio_rural DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE colegio_rural;

-- TABLA 1: ROL
CREATE TABLE rol (
  id_rol INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_rol VARCHAR(50) NOT NULL,
  descripcion VARCHAR(200) NULL,
  UNIQUE KEY nombre_rol (nombre_rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 2: USUARIO
CREATE TABLE usuario (
  ID INT(11) NOT NULL PRIMARY KEY,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NULL,
  email VARCHAR(100) NULL UNIQUE,
  id_rol INT(11) NOT NULL DEFAULT 3,
  estado VARCHAR(20) DEFAULT 'Activo',
  pass VARCHAR(200) NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_id_rol (id_rol),
  CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol (id_rol) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 3: ESTUDIANTE
CREATE TABLE estudiante (
  id_estudiante INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT(11) NOT NULL UNIQUE,
  numero_documento VARCHAR(20) NULL UNIQUE,
  grado VARCHAR(20) NULL,
  fecha_nacimiento DATE NULL,
  direccion VARCHAR(200) NULL,
  telefono VARCHAR(20) NULL,
  fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_estudiante_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (ID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 4: PROFESOR
CREATE TABLE profesor (
  id_profesor INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT(11) NOT NULL UNIQUE,
  especialidad VARCHAR(100) NULL,
  titulo_academico VARCHAR(150) NULL,
  telefono VARCHAR(20) NULL,
  fecha_contratacion DATE NULL,
  CONSTRAINT fk_profesor_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (ID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 5: ACUDIENTE
CREATE TABLE acudiente (
  id_acudiente INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT(11) NOT NULL UNIQUE,
  tipo_relacion VARCHAR(50) NULL,
  telefono VARCHAR(20) NULL,
  direccion VARCHAR(200) NULL,
  CONSTRAINT fk_acudiente_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (ID) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 6: CURSO
CREATE TABLE curso (
  id_curso INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_curso VARCHAR(100) NOT NULL,
  grado INT(11) NULL,
  capacidad INT(11) NULL,
  id_profesor INT(11) NULL,
  año_academico VARCHAR(10) NULL,
  CONSTRAINT fk_curso_profesor FOREIGN KEY (id_profesor) REFERENCES profesor (id_profesor) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 7: MATERIA
CREATE TABLE materia (
  id_materia INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_materia VARCHAR(100) NOT NULL,
  codigo_materia VARCHAR(20) NULL UNIQUE,
  horas_intensidad INT(11) NULL,
  UNIQUE KEY nombre_materia (nombre_materia)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 8: ESTUDIANTE_CURSO
CREATE TABLE estudiante_curso (
  id_inscripcion INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_estudiante INT(11) NOT NULL,
  id_curso INT(11) NOT NULL,
  fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  estado_inscripcion VARCHAR(20) DEFAULT 'Activo',
  UNIQUE KEY uk_est_curso (id_estudiante, id_curso),
  CONSTRAINT fk_estcurso_estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiante (id_estudiante) ON DELETE CASCADE,
  CONSTRAINT fk_estcurso_curso FOREIGN KEY (id_curso) REFERENCES curso (id_curso) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 9: PROFESOR_MATERIA_CURSO
CREATE TABLE profesor_materia_curso (
  id_asignacion INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_profesor INT(11) NOT NULL,
  id_materia INT(11) NOT NULL,
  id_curso INT(11) NOT NULL,
  fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  estado VARCHAR(20) DEFAULT 'Activo',
  UNIQUE KEY uk_prof_mat_cur (id_profesor, id_materia, id_curso),
  CONSTRAINT fk_profmatcur_profesor FOREIGN KEY (id_profesor) REFERENCES profesor (id_profesor) ON DELETE CASCADE,
  CONSTRAINT fk_profmatcur_materia FOREIGN KEY (id_materia) REFERENCES materia (id_materia) ON DELETE CASCADE,
  CONSTRAINT fk_profmatcur_curso FOREIGN KEY (id_curso) REFERENCES curso (id_curso) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 10: ESTUDIANTE_ACUDIENTE
CREATE TABLE estudiante_acudiente (
  id_relacion INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_estudiante INT(11) NOT NULL,
  id_acudiente INT(11) NOT NULL,
  tipo_relacion VARCHAR(50) NULL,
  UNIQUE KEY uk_est_acud (id_estudiante, id_acudiente),
  CONSTRAINT fk_estacud_estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiante (id_estudiante) ON DELETE CASCADE,
  CONSTRAINT fk_estacud_acudiente FOREIGN KEY (id_acudiente) REFERENCES acudiente (id_acudiente) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 11: HORARIO
CREATE TABLE horario (
  id_horario INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_curso INT(11) NOT NULL,
  id_materia INT(11) NOT NULL,
  dia_semana VARCHAR(15) NULL,
  hora_inicio TIME NULL,
  hora_fin TIME NULL,
  aula VARCHAR(50) NULL,
  CONSTRAINT fk_horario_curso FOREIGN KEY (id_curso) REFERENCES curso (id_curso) ON DELETE CASCADE,
  CONSTRAINT fk_horario_materia FOREIGN KEY (id_materia) REFERENCES materia (id_materia) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 12: ASISTENCIA
CREATE TABLE asistencia (
  id_asistencia INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_estudiante INT(11) NOT NULL,
  id_curso INT(11) NOT NULL,
  fecha_asistencia DATE NOT NULL,
  asistencia VARCHAR(20) DEFAULT 'Presente',
  observacion VARCHAR(200) NULL,
  registrado_por INT(11) NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_asistencia_estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiante (id_estudiante) ON DELETE CASCADE,
  CONSTRAINT fk_asistencia_curso FOREIGN KEY (id_curso) REFERENCES curso (id_curso) ON DELETE CASCADE,
  CONSTRAINT fk_asistencia_profesor FOREIGN KEY (registrado_por) REFERENCES profesor (id_profesor) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 13: CALIFICACION
CREATE TABLE calificacion (
  id_calificacion INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_estudiante INT(11) NOT NULL,
  id_materia INT(11) NOT NULL,
  id_curso INT(11) NOT NULL,
  id_profesor INT(11) NOT NULL,
  periodo INT(2) NOT NULL,
  nota DECIMAL(5,2) NULL,
  nota_numerica INT(3) NULL,
  estado_nota VARCHAR(20) NULL,
  observacion VARCHAR(200) NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_calif_estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiante (id_estudiante) ON DELETE CASCADE,
  CONSTRAINT fk_calif_materia FOREIGN KEY (id_materia) REFERENCES materia (id_materia) ON DELETE CASCADE,
  CONSTRAINT fk_calif_curso FOREIGN KEY (id_curso) REFERENCES curso (id_curso) ON DELETE CASCADE,
  CONSTRAINT fk_calif_profesor FOREIGN KEY (id_profesor) REFERENCES profesor (id_profesor) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 14: CALENDARIO_ACADEMICO
CREATE TABLE calendario_academico (
  id_calendario INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_evento VARCHAR(100) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NULL,
  descripcion VARCHAR(300) NULL,
  tipo_evento VARCHAR(50) NULL,
  año_academico VARCHAR(10) NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- TABLA 15: CONFIGURACION
CREATE TABLE configuracion (
  id_config INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  clave VARCHAR(100) NOT NULL UNIQUE,
  valor VARCHAR(255) NULL,
  descripcion VARCHAR(200) NULL,
  tipo_dato VARCHAR(50) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- INSERTAR DATOS INICIALES
-- ============================================

INSERT INTO rol (id_rol, nombre_rol, descripcion) VALUES
(1, 'Administrador', 'Control total del sistema'),
(2, 'Profesor', 'Gestion de calificaciones y asistencia'),
(3, 'Estudiante', 'Acceso a calificaciones y horarios'),
(4, 'Acudiente', 'Seguimiento del estudiante');

INSERT INTO usuario (ID, nombres, apellidos, email, id_rol, estado, pass) VALUES
(1, 'Admin', 'System', 'admin@colegio.edu.co', 1, 'Activo', 'admin'),
(2, 'Juan', 'Profesor', 'juan@colegio.edu.co', 2, 'Activo', '2'),
(1072493621, 'Stiven', 'Cifuentes', 'stiven@colegio.edu.co', 3, 'Activo', '1072493621');

INSERT INTO profesor (id_usuario, especialidad, titulo_academico) VALUES
(2, 'Matematicas', 'Licenciado en Matematicas');

INSERT INTO estudiante (id_usuario, numero_documento, grado) VALUES
(1072493621, '1072493621', 'Sexto');

INSERT INTO curso (nombre_curso, grado, capacidad, año_academico) VALUES
('6A', 6, 40, '2024'),
('6B', 6, 40, '2024');

INSERT INTO materia (nombre_materia, codigo_materia, horas_intensidad) VALUES
('Matematicas', 'MAT001', 4),
('Lengua Castellana', 'LEN001', 4),
('Ciencias Naturales', 'CIE001', 3),
('Ciencias Sociales', 'SOC001', 3),
('Educacion Fisica', 'EF001', 2),
('Tecnologia', 'TEC001', 2),
('Ingles', 'ING001', 3);

INSERT INTO configuracion (clave, valor, descripcion, tipo_dato) VALUES
('nombre_institucion', 'COLEGIO RURAL', 'Nombre de la institucion', 'text'),
('año_academico', '2024', 'Ano academico actual', 'numeric'),
('periodos_academicos', '4', 'Cantidad de periodos academicos', 'numeric'),
('foto_perfil_permitida', '5', 'Tamaño maximo de foto (MB)', 'numeric'),
('escala_calificacion', '1-100', 'Escala de calificacion', 'text');

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
