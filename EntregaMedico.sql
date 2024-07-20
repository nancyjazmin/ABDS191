CREATE TABLE Rol (
    RolId INT IDENTITY(1,1) PRIMARY KEY,
   Tipo_rol VARCHAR(100)
);

CREATE TABLE Especialidad (
    EspecialidadId INT IDENTITY(1,1) PRIMARY KEY,
    Tipo_Especialidad VARCHAR(100)
);

CREATE TABLE Medico (
    MedicoId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150), 
    RFC VARCHAR(12),
    Cédula VARCHAR(150),
    Correo VARCHAR(100),
    Pass VARCHAR(100),
    RolId INT,
    EspecialidadId INT,
    FOREIGN KEY (EspecialidadId) REFERENCES Especialidad(EspecialidadId),
    FOREIGN KEY (RolId) REFERENCES Rol(RolId)
);

CREATE TABLE Estudios (
    EstudiosId INT IDENTITY(1,1) PRIMARY KEY,
    Tipo_Estudios VARCHAR(255)
);

CREATE TABLE Exploración (
    ExploraciónId INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE,
    Peso VARCHAR(50),
    Altura VARCHAR(50),
    Temperatura VARCHAR(50),
    Saturación_glucosa VARCHAR(50),
    Edad INT,
    Resultado_Exploración VARCHAR(max)
);

ALTER TABLE Exploración
ADD PacienteId INT;
ALTER TABLE Exploración
ADD FOREIGN KEY (PacienteId) REFERENCES Paciente(PacienteId);



CREATE TABLE Paciente (
    PacienteId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150),
    Resultado_Exploración NVARCHAR(max)
);

ALTER TABLE Paciente
ADD ExpedienteId INT;
ALTER TABLE Paciente
ADD FOREIGN KEY (ExpedienteId) REFERENCES Expediente(ExpedienteId);


CREATE TABLE Cita(
    CitaId INT IDENTITY(1,1) PRIMARY KEY,
    Fehca DATE,
    PacienteId INT,
    MedicoId INT,
    FOREIGN KEY (PacienteId) REFERENCES Paciente(PacienteId),
    FOREIGN KEY (MedicoId) REFERENCES Medico(MedicoId)
);

CREATE TABLE Diagnostico (
    DiagnosticoId INT IDENTITY(1,1) PRIMARY KEY,
    Resultado_Exploracion VARCHAR(max),
    Sintomas VARCHAR(255),
    Dx VARCHAR (255),
    Tratamiento VARCHAR(255),
    CitaId INT,
    EstudiosId INT,
    FOREIGN KEY (CitaId) REFERENCES Cita(CitaId),
    FOREIGN KEY (EstudiosId) REFERENCES Estudios(EstudiosId)
);

CREATE TABLE Expediente (
    ExpedienteId INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150),
    Fecha_Nacimiento DATE,
    Enfermedades_Cronicas VARCHAR(255),
    Alergias VARCHAR(255),
    Fecha_Creación DATE,
    Fecha_Actualización DATE,
    MedicoId INT,
    DiagnosticoId INT,
    ExploraciónId INT,
    FOREIGN KEY (MedicoId) REFERENCES Medico(MedicoId),
    FOREIGN KEY (DiagnosticoId) REFERENCES Diagnostico(DiagnosticoId),
    FOREIGN KEY (ExploraciónId) REFERENCES Exploración(ExploraciónId)
);


CREATE TABLE Receta (
    RecetaId INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE,
    PacienteId INT,
    DiagnosticoId INT
    FOREIGN KEY (PacienteId) REFERENCES Paciente(PacienteId),
    FOREIGN KEY (DiagnosticoId) REFERENCES Diagnostico(DiagnosticoId)
);



--Procedimientos de datos necesarios

CREATE PROCEDURE sp_InsertaRol
@Tipo_rol VARCHAR(100)
AS
BEGIN
INSERT INTO Rol (Tipo_rol) VALUES (@Tipo_rol)
END;

EXEC sp_InsertaRol 'Administrador Medico'
EXEC sp_InsertaRol 'Medico'

SELECT * FROM Rol;

----

CREATE PROCEDURE sp_InsertarEsp
@Tipo_Especialidad VARCHAR(100)
AS
BEGIN
INSERT INTO Especialidad VALUES(@Tipo_Especialidad)
END;

EXEC sp_InsertarEsp 'Cardiología'
EXEC sp_InsertarEsp 'Neurología'
EXEC sp_InsertarEsp 'Pediatría'
EXEC sp_InsertarEsp 'Geriatría'

SELECT * FROM Especialidad;

----

CREATE PROCEDURE sp_InsertarMed
@Nombre VARCHAR(150),
@RFC VARCHAR(12),
@Cedula VARCHAR(150),
@Correo VARCHAR(100),
@Pass VARCHAR(100),
@RolId INT,
@EspecialidadId INT
AS
BEGIN
INSERT INTO Medico (Nombre, RFC, Cédula, Correo, Pass, RolId, EspecialidadId) VALUES (@Nombre, @RFC, @Cedula, @Correo, @Pass, @RolId, @EspecialidadId)
END;

EXEC sp_InsertarMed 'Guillermo Lazacano', 'GLMC820428H2', '79757214', 'guiiii@gmail.com', 'LAZCA', 1, 1
EXEC sp_InsertarMed 'Cesar Hernandez', 'MFDH830723H1', '23635532', 'Cesssg@gmail.com', 'Henrces', 2, 4
EXEC sp_InsertarMed 'Fabiola Iñiguez', 'FISN900129', '64328732', 'Fabi@outlook.es', 'Fbsss321', 2, 3
EXEC sp_InsertarMed 'Alexis Ayala', 'AAMS950824', '43232456', 'Alsxx@gmail.com', 'Aless', 2, 2

SELECT * FROM Medico;

CREATE PROCEDURE sp_Estudios
@Tipo_Estudios VARCHAR(255)
AS
BEGIN
INSERT INTO Estudios(Tipo_Estudios) VALUES (@Tipo_Estudios)
END;

EXEC sp_Estudios 'Electrocardiograma' --cardiologia
EXEC sp_Estudios 'Electroencefalograma (EEG)' --neurologia
EXEC sp_Estudios 'Radiografía de Tórax' --pediatria
EXEC sp_Estudios 'Densitometría Ósea' --geriatria

SELECT * FROM Estudios;


--

CREATE PROCEDURE sp_InsertarExploracion
@Fecha DATE,
@Peso VARCHAR(50),
@Altura VARCHAR(50),
@Temperatura VARCHAR(50),
@Saturacion_glucosa VARCHAR(50),
@Edad INT,
@Resultado_Exploracion VARCHAR(MAX),
@PacienteId INT
AS
BEGIN
INSERT INTO Exploración (Fecha, Peso, Altura, Temperatura, Saturación_glucosa, Edad, Resultado_Exploración, PacienteId) VALUES (@Fecha, @Peso, @Altura, @Temperatura, @Saturacion_glucosa, @Edad, @Resultado_Exploracion, @PacienteId)
END;


EXEC sp_InsertarExploracion '2024-06-23', '87', '1.66', '26', '115', '54', 'Descripción del Procedimiento:
Se realizó un electrocardiograma de 12 derivaciones para evaluar la actividad eléctrica del corazón.
Resultados:
Ritmo sinusal normal.
Frecuencia cardíaca: 72 latidos por minuto.
Eje del QRS: Normal.
No se observaron signos de isquemia miocárdica ni arritmias.
Intervalo PR: 0.16 segundos (normal).
Intervalo QTc: 0.40 segundos (normal).
Interpretación:
El ECG muestra una actividad eléctrica cardíaca dentro de los límites normales. No se evidencian anormalidades significativas.', 1


EXEC sp_InsertarExploracion '2024-01-18', '76', '1.60', '28', '119', '62','Descripción del Procedimiento:
Se realizó una densitometría ósea de la columna lumbar y cadera utilizando absorciometría de rayos X de energía (DEXA).
Resultados:
Columna lumbar (L1-L4): T-score: -1.0 (osteopenia leve).
Cadera: T-score: -0.8 (dentro de los límites normales).
Interpretación:
La densitometría ósea revela una leve osteopenia en la columna lumbar, mientras que la densidad ósea de la cadera está dentro de los límites normales. Se recomienda seguimiento y posible intervención para prevenir progresión a osteoporosis.', 2

SELECT * FROM Exploración;

--

CREATE PROCEDURE sp_InsertarPaciente
@Nombre VARCHAR(150)
AS
BEGIN
INSERT INTO Paciente (Nombre) VALUES(@Nombre)
END;

EXEC sp_InsertarPaciente 'Ruben Plutarco'
EXEC sp_InsertarPaciente 'Maria Minerva'
EXEC sp_InsertarPaciente 'Alejandro Escobedo'

SELECT * FROM Paciente;

-- 

CREATE PROCEDURE sp_InsertarCita
@Fecha DATE,
@PacienteId INT,
@MedicoId INT
AS
BEGIN
INSERT INTO Cita (Fecha, PacienteId, MedicoId) VALUES (@Fecha, @PacienteId, @MedicoId);
END;

EXEC sp_InsertarCita '2024-06-12', 1, 1;
EXEC sp_InsertarCita '2024-08-13', 2, 4;

-- 

CREATE PROCEDURE sp_InsertarDiagnostico
@Resultado_Exploracion VARCHAR(max),
@Sintomas VARCHAR(255),
@Dx VARCHAR(255),
@Tratamiento VARCHAR(255),
@CitaId INT,
@EstudiosId INT
AS
BEGIN
INSERT INTO Diagnostico (Resultado_Exploracion, Sintomas, Dx, Tratamiento, CitaId, EstudiosId) VALUES (@Resultado_Exploracion, @Sintomas, @Dx, @Tratamiento, @CitaId, @EstudiosId);
END;

EXEC sp_InsertarDiagnostico 'Descripción del Procedimiento:
Se realizó un electrocardiograma de 12 derivaciones para evaluar la actividad eléctrica del corazón.
Resultados:
Ritmo sinusal normal.
Frecuencia cardíaca: 72 latidos por minuto.
Eje del QRS: Normal.
No se observaron signos de isquemia miocárdica ni arritmias.
Intervalo PR: 0.16 segundos (normal).
Intervalo QTc: 0.40 segundos (normal).
Interpretación:
El ECG muestra una actividad eléctrica cardíaca dentro de los límites normales. No se evidencian anormalidades significativas.', 'Dolor torácico intermitente, Dificultad para respirar', 'Estrés o ansiedad, Deshidratación o desequilibrio electrolítico.', 'Medicación para controlar los síntomas betabloqueantes, Hidratación adecuada y equilibrio de electrolitos.', 1, 1;

EXEC sp_InsertarDiagnostico 'Descripción del Procedimiento:
Se realizó una densitometría ósea de la columna lumbar y cadera utilizando absorciometría de rayos X de energía (DEXA).
Resultados:
Columna lumbar (L1-L4): T-score: -1.0 (osteopenia leve).
Cadera: T-score: -0.8 (dentro de los límites normales).
Interpretación:
La densitometría ósea revela una leve osteopenia en la columna lumbar, mientras que la densidad ósea de la cadera está dentro de los límites normales. Se recomienda seguimiento y posible intervención para prevenir progresión a osteoporosis.', 'Dolor óseo o articular', 'Osteopenia leve en la columna lumbar.', 'Suplementos de calcio y vitamina D.', 2, 4;

SELECT * FROM Diagnostico;

--

CREATE PROCEDURE sp_InsertarExpediente
@Nombre VARCHAR(150),
@Fecha_Nacimiento DATE,
@Enfermedades_Cronicas VARCHAR(255),
@Alergias VARCHAR(255),
@Fecha_Creacion DATE,
@Fecha_Actualizacion DATE,
@MedicoId INT,
@DiagnosticoId INT,
@ExploracionId INT
AS
BEGIN
INSERT INTO Expediente (Nombre, Fecha_Nacimiento, Enfermedades_Cronicas, Alergias, Fecha_Creación, Fecha_Actualización, MedicoId, DiagnosticoId, ExploraciónId)
VALUES (@Nombre, @Fecha_Nacimiento, @Enfermedades_Cronicas, @Alergias, @Fecha_Creacion, @Fecha_Actualizacion, @MedicoId, @DiagnosticoId, @ExploracionId)
END;

EXEC sp_InsertarExpediente 'Ruben Plutarco ', '1970-01-10', 'Diabetes', 'Ninguna', '2023-11-01', '2024-07-12', 1, 1, 1;
EXEC sp_InsertarExpediente 'Maria Minerva', '1960-11-02', 'Ninguna', 'Ninguna', '2024-01-01', '2024-07-12', 4, 2, 2;

SELECT * FROM Expediente;

--

CREATE PROCEDURE sp_InsertarReceta
@Fecha DATE,
@PacienteId INT,
@DiagnosticoId INT
AS
BEGIN
INSERT INTO Receta (Fecha, PacienteId, DiagnosticoId) VALUES (@Fecha, @PacienteId, @DiagnosticoId)
END;

EXEC sp_InsertarReceta '2024-07-14', 1, 1;
EXEC sp_InsertarReceta '2024-07-13', 2, 2;





--Vistas 
CREATE VIEW VistaMedicosEspecialidades AS
SELECT m.Nombre AS NombreMedico, m.RFC, m.Cédula, m.Correo, r.Tipo_rol AS Rol, e.Tipo_Especialidad AS Especialidad
FROM Medico m
JOIN Rol r ON m.RolId = r.RolId
JOIN Especialidad e ON m.EspecialidadId = e.EspecialidadId;

SELECT * FROM VistaMedicosEspecialidades;

--

CREATE VIEW VistaExploracionesPacientes AS
SELECT ex.Fecha, ex.Peso, ex.Altura, ex.Temperatura, ex.Saturación_glucosa, ex.Edad, ex.Resultado_Exploración, p.Nombre AS NombrePaciente
FROM Exploración ex
JOIN Paciente p ON ex.PacienteId = p.PacienteId;

SELECT * FROM VistaExploracionesPacientes;

--

CREATE VIEW VistaCitasPacientesMedicos AS
SELECT c.CitaId, c.Fecha, p.Nombre AS NombrePaciente, m.Nombre AS NombreMedico, m.Correo, e.Tipo_Especialidad
FROM Cita c
JOIN Paciente p ON c.PacienteId = p.PacienteId
JOIN Medico m ON c.MedicoId = m.MedicoId
JOIN Especialidad e ON m.EspecialidadId = e.EspecialidadId;

SELECT * FROM VistaCitasPacientesMedicos;

--Procedimientos











--Procedimientos con transacciones