CREATE DATABASE MEDICO

CREATE TABLE Estudios (
    EstudiosID INT IDENTITY PRIMARY KEY,
    tipo_estudio VARCHAR(255) NOT NULL
);
CREATE TABLE Roles (
    rolID INT IDENTITY (1,1) PRIMARY KEY,
    especialidad NVARCHAR(100) NOT NULL,
    nombre NVARCHAR(100) NOT NULL,
    cedula NVARCHAR(20) NOT NULL UNIQUE
);
CREATE TABLE Especialidad (
    especialidadID INT IDENTITY(1,1) PRIMARY KEY,
    tipo_especialidad VARCHAR(100)
);
CREATE TABLE Medicos (
    medicoID INT IDENTITY (1,1) PRIMARY KEY ,
    RFC NVARCHAR(13) NOT NULL UNIQUE,
    nombre NVARCHAR(255) NOT NULL,
    cedula NVARCHAR(20) NOT NULL UNIQUE,
    correo NVARCHAR(255) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    rolID INT,
	especialidadID INT,
    FOREIGN KEY (rolID) REFERENCES Roles(rolID),
	FOREIGN KEY (especialidadID) REFERENCES Especialidad(especialidadID)
);

CREATE TABLE Pacientes (
    pacienteID INT IDENTITY (1,1) PRIMARY KEY ,
    nombre NVARCHAR(255) NOT NULL,
    resultado_exploracion TEXT,
);
ALTER TABLE Pacientes
ADD FOREIGN KEY (expedienteID) REFERENCES Expedientes(expedienteID);

CREATE TABLE Citas (
    citaID INT IDENTITY (1,1) PRIMARY KEY,
    fecha DATETIME NOT NULL,
    pacienteID INT NOT NULL,
    medicoID INT NOT NULL,
    FOREIGN KEY (medicoID) REFERENCES Medicos(medicoID),
	FOREIGN KEY (pacienteID) REFERENCES Pacientes(pacienteID)
);
CREATE TABLE Diagnosticos (
    diagnosticoID INT IDENTITY(1,1) PRIMARY KEY,
    citaID INT NOT NULL,
    resultado_exploracion TEXT,
    sintomas TEXT,
    Dx TEXT,
    tratamiento TEXT,
    estudiosID INT,
    FOREIGN KEY (citaID) REFERENCES Citas(citaID),
    FOREIGN KEY (estudiosID) REFERENCES Estudios(estudiosID)
);
CREATE TABLE Exploraciones (
    exploracionID INT IDENTITY (1,1) PRIMARY KEY ,
    pacienteID INT NOT NULL,
    fecha DATETIME NOT NULL,
    peso DECIMAL(5,2),
    altura DECIMAL(5,2),
    temperatura DECIMAL(4,2),
    saturacion_glucosa DECIMAL(5,2),
    edad INT,
    FOREIGN KEY (pacienteID) REFERENCES Pacientes(pacienteID)
);
CREATE TABLE Recetas (
    recetaID INT IDENTITY (1,1)PRIMARY KEY,
    fecha DATETIME NOT NULL,
    pacienteID INT NOT NULL,
    diagnosticoID INT NOT NULL,
    FOREIGN KEY (pacienteID) REFERENCES Pacientes(pacienteID),
    FOREIGN KEY (diagnosticoID) REFERENCES Diagnosticos(diagnosticoID)
);

CREATE TABLE Expedientes(
    expedienteID INT IDENTITY (1,1)PRIMARY KEY,
    medicoID INT NOT NULL,
    nombre NVARCHAR(255) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    enfer_cronicas TEXT,
    alergias TEXT,
    fecha_creacion DATE,
    fecha_actualizacion DATE,
    diagnosticoID INT,
    exploracionID INT,
    FOREIGN KEY (medicoID) REFERENCES Medicos(medicoID),
    FOREIGN KEY (diagnosticoID) REFERENCES Diagnosticos(diagnosticoID),
    FOREIGN KEY (exploracionID) REFERENCES Exploraciones(exploracionID)
);

-------------------------------------------------------------

CREATE PROCEDURE sp_InsertEstudio
	@tipo_estudio VARCHAR(255)
AS
BEGIN
    INSERT INTO Estudios (tipo_estudio) VALUES (@tipo_estudio);
END;

EXEC sp_InsertEstudio 'Rayos X';
EXEC sp_InsertEstudio 'Resonancia Magnética';
EXEC sp_InsertEstudio 'Ecografía';
EXEC sp_InsertEstudio 'Tomografía Computarizada';
EXEC sp_InsertEstudio 'Análisis de Sangre';

----------------------------------------
CREATE PROCEDURE sp_InsertRol
	@especialidad NVARCHAR(100),
	@nombre NVARCHAR(100),
	@cedula NVARCHAR(20)
AS
BEGIN
    INSERT INTO Roles (especialidad, nombre, cedula) VALUES (@especialidad, @nombre, @cedula);
END;

EXEC sp_InsertRol 'Cardiología', 'Cardiólogo', 'C001';
EXEC sp_InsertRol 'Neurología', 'Neurólogo', 'C002';
EXEC sp_InsertRol 'Dermatología', 'Dermatólogo', 'C003';
EXEC sp_InsertRol 'Pediatría', 'Pediatra', 'C004';
EXEC sp_InsertRol 'Oncología', 'Oncólogo', 'C005';

--------------------------------------------------------------

CREATE PROCEDURE sp_InsertEspecialidad
@tipo_especialidad NVARCHAR(100)
AS
BEGIN
    INSERT INTO Especialidad (tipo_especialidad) VALUES (@tipo_especialidad);
END;
EXEC sp_InsertEspecialidad 'Cardiología';
EXEC sp_InsertEspecialidad 'Neurología';
EXEC sp_InsertEspecialidad 'Dermatología';
EXEC sp_InsertEspecialidad 'Pediatría';
EXEC sp_InsertEspecialidad 'Oncología';
--------------------------------------------------
CREATE PROCEDURE sp_InsertMedico
	@RFC NVARCHAR(13),
	@nombre NVARCHAR(255),
	@cedula NVARCHAR(20),
	@correo NVARCHAR(255),
	@contraseña VARCHAR(255),
	@rolID INT,
	@especialidadID INT
AS
BEGIN
    INSERT INTO Medicos (RFC, nombre, cedula, correo, contraseña, rolID, especialidadID) 
    VALUES (@RFC, @nombre, @cedula, @correo, @contraseña, @rolID, @especialidadID);
END;
EXEC sp_InsertMedico 'RFC001', 'Dr. Juan Perez', 'CED001', 'juan@example.com', 'pass123', 1, 1;
EXEC sp_InsertMedico 'RFC002', 'Dr. Maria Lopez', 'CED002', 'maria@example.com', 'pass456', 2, 2;
EXEC sp_InsertMedico 'RFC003', 'Dr. Carlos Gomez', 'CED003', 'carlos@example.com', 'pass789', 3, 3;
EXEC sp_InsertMedico 'RFC004', 'Dr. Ana Martinez', 'CED004', 'ana@example.com', 'pass101', 4, 4;
EXEC sp_InsertMedico 'RFC005', 'Dr. Luis Sanchez', 'CED005', 'luis@example.com', 'pass102', 5, 5;

-------------------------------------------------------------
CREATE PROCEDURE sp_InsertPacientes
	@nombre NVARCHAR(255)
AS
BEGIN
    INSERT INTO Pacientes (nombre) 
    VALUES (@nombre);
END;

EXEC sp_InsertPacientes 'Maria Dolores Perrusquia'
EXEC sp_InsertPacientes 'Oswaldo Peréz Morales'
EXEC sp_InsertPacientes 'Roberto Perrusquia Silva'
EXEC sp_InsertPacientes 'Laura Sanchez Hernandez'

select * from Pacientes

------------------------------------------------------------------
CREATE PROCEDURE sp_InsertCita
	@fecha DATETIME,
	@pacienteID INT,
	@medicoID INT
AS
BEGIN
    INSERT INTO Citas (fecha, pacienteID, medicoID) 
    VALUES (@fecha, @pacienteID, @medicoID);
END;
EXEC sp_InsertCita '2023-07-01 10:00:00', 1, 1;
EXEC sp_InsertCita '2023-07-02 11:00:00', 2, 2;
EXEC sp_InsertCita '2023-07-03 12:00:00', 3, 3;
EXEC sp_InsertCita '2023-07-04 13:00:00', 4, 4;
EXEC sp_InsertCita '2023-07-05 14:00:00', 5, 5;

-------------------------------------------------------------------
CREATE PROCEDURE sp_InsertDiagnostico
	@citaID INT,
	@resultado_exploracion TEXT,
	@sintomas TEXT,
	@Dx TEXT,
	@tratamiento TEXT,
	@estudiosID INT
AS
BEGIN
    INSERT INTO Diagnosticos (citaID, resultado_exploracion, sintomas, Dx, tratamiento, estudiosID) 
    VALUES (@citaID, @resultado_exploracion, @sintomas, @Dx, @tratamiento, @estudiosID);
END;

EXEC sp_InsertDiagnostico 1, 'Resultado Exploracion 1', 'Sintomas 1', 'Dx 1', 'Tratamiento 1', 1;
EXEC sp_InsertDiagnostico 2, 'Resultado Exploracion 2', 'Sintomas 2', 'Dx 2', 'Tratamiento 2', 2;
EXEC sp_InsertDiagnostico 3, 'Resultado Exploracion 3', 'Sintomas 3', 'Dx 3', 'Tratamiento 3', 3;
EXEC sp_InsertDiagnostico 4, 'Resultado Exploracion 4', 'Sintomas 4', 'Dx 4', 'Tratamiento 4', 4;
EXEC sp_InsertDiagnostico 5, 'Resultado Exploracion 5', 'Sintomas 5', 'Dx 5', 'Tratamiento 5', 5;

-------------------------------------------------------------------------------------------------------
CREATE PROCEDURE sp_InsertExploracion
@pacienteID INT,
@fecha DATETIME,
@peso DECIMAL(5,2),
@altura DECIMAL(5,2),
@temperatura DECIMAL(4,2),
@saturacion_glucosa DECIMAL(5,2),
@edad INT
AS
BEGIN
    INSERT INTO Exploraciones (pacienteID, fecha, peso, altura, temperatura, saturacion_glucosa, edad) 
    VALUES (@pacienteID, @fecha, @peso, @altura, @temperatura, @saturacion_glucosa, @edad);
END;

EXEC sp_InsertExploracion 1, '2023-07-01 10:00:00', 70.5, 1.75, 36.6, 100.0, 30;
EXEC sp_InsertExploracion 2, '2023-07-02 11:00:00', 65.0, 1.65, 36.7, 98.0, 28;
EXEC sp_InsertExploracion 3, '2023-07-03 12:00:00', 80.0, 1.80, 36.8, 110.0, 35;
EXEC sp_InsertExploracion 4, '2023-07-04 13:00:00', 90.0, 1.85, 37.0, 95.0, 40;
EXEC sp_InsertExploracion 5, '2023-07-05 14:00:00', 75.0, 1.70, 36.5, 105.0, 33;

------------------------------------------------------------------

CREATE PROCEDURE sp_InsertReceta
@fecha DATETIME,
@pacienteID INT,
@diagnosticoID INT
AS
BEGIN
    INSERT INTO Recetas (fecha, pacienteID, diagnosticoID) 
    VALUES (@fecha, @pacienteID, @diagnosticoID);
END;
EXEC sp_InsertReceta '2023-07-01 10:00:00', 1, 1;
EXEC sp_InsertReceta '2023-07-02 11:00:00', 2, 2;
EXEC sp_InsertReceta '2023-07-03 12:00:00', 3, 3;
EXEC sp_InsertReceta '2023-07-04 13:00:00', 4, 4;
EXEC sp_InsertReceta '2023-07-05 14:00:00', 5, 5;

----------------------------------------------------------------
CREATE PROCEDURE sp_InsertExpediente
	@medicoID INT,
	@nombre NVARCHAR(255),
	@fecha_nacimiento DATE,
	@enfer_cronicas TEXT,
	@alergias TEXT,
	@fecha_creacion DATE,
	@fecha_actualizacion DATE,
	@diagnosticoID INT,
	@exploracionID INT
AS
BEGIN
    INSERT INTO Expedientes (medicoID, nombre, fecha_nacimiento, enfer_cronicas, alergias, fecha_creacion, fecha_actualizacion, diagnosticoID, exploracionID) 
    VALUES (@medicoID, @nombre, @fecha_nacimiento, @enfer_cronicas, @alergias, @fecha_creacion, @fecha_actualizacion, @diagnosticoID, @exploracionID);
END;

EXEC sp_InsertExpediente 1, 'Expediente 1', '1990-01-01', 'Diabetes', 'Penicilina', '2023-07-01', '2023-07-01', 1, 1;
EXEC sp_InsertExpediente 2, 'Expediente 2', '1992-02-02', 'Hipertensión', 'Polen', '2023-07-02', '2023-07-02', 2, 2;
EXEC sp_InsertExpediente 3, 'Expediente 3', '1994-03-03', 'Asma', 'Frutos Secos', '2023-07-03', '2023-07-03', 3, 3;
EXEC sp_InsertExpediente 4, 'Expediente 4', '1996-04-04', 'Artritis', 'Lácteos', '2023-07-04', '2023-07-04', 4, 4;
EXEC sp_InsertExpediente 5, 'Expediente 5', '1998-05-05', 'Alergias', 'Mariscos', '2023-07-05', '2023-07-05', 5, 5;


--------------------------------------------------

------VISTAS-----------

