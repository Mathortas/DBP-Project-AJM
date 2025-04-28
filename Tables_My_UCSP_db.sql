-- 1. Crear base de datos (si no existe)
CREATE DATABASE IF NOT EXISTS myucsp;
USE myucsp;

-- 2. Crear tabla de usuarios (semestre y carrera opcionales)
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    semestre INT,  -- Ahora es opcional
    carrera VARCHAR(100)  -- Ahora es opcional
);

-- 3. Crear tabla de cursos (descripcion y creditos opcionales)
CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciclo VARCHAR(20) NOT NULL,
    modalidad VARCHAR(50) NOT NULL,
    docente_id INT,
    descripcion TEXT,  -- Ahora es opcional
    creditos INT,  -- Ahora es opcional
    FOREIGN KEY (docente_id) REFERENCES usuario(id) ON DELETE SET NULL
);

-- 4. Crear tabla de horarios
CREATE TABLE horario (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT NOT NULL, -- FK hacia curso
    dia_semana VARCHAR(20) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    aula VARCHAR(50), -- Opcional
    FOREIGN KEY (curso_id) REFERENCES curso(id) ON DELETE CASCADE
);

-- 5. Crear tabla de matriculas
CREATE TABLE matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT NOT NULL, -- FK hacia usuario
    correo_estudiante VARCHAR(100) NOT NULL,
    curso_id INT NOT NULL, -- FK hacia curso
    ciclo VARCHAR(20) NOT NULL,
    fecha_matricula DATE NOT NULL,
    FOREIGN KEY (estudiante_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES curso(id) ON DELETE CASCADE
);

-- 6. Crear tabla de tareas
CREATE TABLE tarea (
    id_tarea INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tarea VARCHAR(100) NOT NULL,
    fecha_entrega DATE NOT NULL,
    estado VARCHAR(20) NOT NULL, -- Puede ser 'pendiente', 'terminada', etc.
    curso_id INT NOT NULL, -- FK hacia curso
    descripcion TEXT, -- Opcional
    FOREIGN KEY (curso_id) REFERENCES curso(id) ON DELETE CASCADE
);

-- 7. Crear tabla de notas
CREATE TABLE nota (
    id_nota INT AUTO_INCREMENT PRIMARY KEY,
    nombre_nota VARCHAR(100) NOT NULL,
    nota_obtenida DECIMAL(5, 2) NOT NULL, -- Para notas con decimales, ejemplo 95.75
    permanente_promedio VARCHAR(20) NOT NULL, -- Puede ser 'permanente' o 'promedio'
    peso_porcentaje DECIMAL(5, 2) NOT NULL, -- El porcentaje del peso de la nota
    matricula_id INT NOT NULL, -- FK hacia matricula
    FOREIGN KEY (matricula_id) REFERENCES matricula(id) ON DELETE CASCADE
);
