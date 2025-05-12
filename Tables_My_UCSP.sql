USE freedb_my_ucsp_db;

-- 1. Crear tabla de usuario sin el atributo rol
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL  -- Puedes encriptar esto si usas backend
);

-- 2. Crear tabla de cursos
CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciclo VARCHAR(20) NOT NULL,
    modalidad VARCHAR(50) NOT NULL,
    descripcion TEXT,  -- Opcional
    creditos INT      -- Opcional
    -- Ya no hay 'id_docente' ni FK a usuario
);

-- 3. Crear tabla de horarios
CREATE TABLE horario (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL, -- FK hacia curso
    dia_semana VARCHAR(20) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    aula VARCHAR(50), -- Opcional
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE CASCADE
);

-- 4. Crear tabla de matrículas
CREATE TABLE matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT NOT NULL, -- FK hacia usuario
    correo_estudiante VARCHAR(100) NOT NULL,
    id_curso INT NOT NULL, -- FK hacia curso
    ciclo VARCHAR(20) NOT NULL,
    fecha_matricula DATE NOT NULL,
    FOREIGN KEY (id_estudiante) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE CASCADE
);

-- 5. Crear tabla de tareas
CREATE TABLE tarea (
    id_tarea INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tarea VARCHAR(100) NOT NULL,
    fecha_entrega DATE NOT NULL,
    estado VARCHAR(20) NOT NULL, -- Puede ser 'pendiente', 'terminada', etc.
    id_curso INT NOT NULL, -- FK hacia curso
    descripcion TEXT, -- Opcional
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE CASCADE
);

-- 6. Crear tabla de notas
CREATE TABLE nota (
    id_nota INT AUTO_INCREMENT PRIMARY KEY,
    nombre_nota VARCHAR(100) NOT NULL,
    nota_obtenida DECIMAL(5, 2) NOT NULL,
    permanente_promedio VARCHAR(20) NOT NULL, -- 'permanente' o 'promedio'
    peso_porcentaje DECIMAL(5, 2) NOT NULL,
    id_matricula INT NOT NULL, -- FK hacia matrícula
    FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula) ON DELETE CASCADE
);
