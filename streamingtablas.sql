CREATE TABLE Usuarios (
UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
Nombre NVARCHAR (100) NOT NULL,
Email NVARCHAR(100) NOT NULL UNIQUE,
Pass NVARCHAR (100) NOT NULL,
FechaRegistro DATE NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Peliculas (
PeliculaID INT IDENTITY(1,1) PRIMARY KEY,
Titulo NVARCHAR (100) NOT NULL,
Genero NVARCHAR (50),
FechaEstreno DATE
);

CREATE TABLE Suscripciones (
SuscripcionID INT IDENTITY(1,1) PRIMARY KEY,
UsuarioID INT NOT NULL,
FechaInicio DATE NOT NULL,
FechaFin DATE,
Tipo NVARCHAR(58),
FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);


INSERT INTO Usuarios (Nombre, Email, Pass)
VALUES 
('Juan Perez', 'juan.perez@example.com', 'password123'),
('Maria Gomez', 'maria.gomez@example.com', 'password123'),
('Carlos Ramirez', 'carlos.ramirez@example.com', 'password123'),
('Luisa Fernandez', 'luisa.fernandez@example.com', 'password123'),
('Miguel Torres', 'miguel.torres@example.com', 'password123'),
('Ana Martinez', 'ana.martinez@example.com', 'password123'),
('Jose Rodriguez', 'jose.rodriguez@example.com', 'password123'),
('Laura Diaz', 'laura.diaz@example.com', 'password123'),
('Ricardo Sanchez', 'ricardo.sanchez@example.com', 'password123'),
('Elena Ruiz', 'elena.ruiz@example.com', 'password123');

INSERT INTO Peliculas (Titulo, Genero, FechaEstreno)
VALUES 
('The Shawshank Redemption', 'Drama', '1994-09-23'),
('The Godfather', 'Crime', '1972-03-24'),
('The Dark Knight', 'Action', '2008-07-18'),
('Pulp Fiction', 'Crime', '1994-10-14'),
('The Lord of the Rings: The Return of the King', 'Fantasy', '2003-12-17'),
('Forrest Gump', 'Drama', '1994-07-06'),
('Inception', 'Sci-Fi', '2010-07-16'),
('Fight Club', 'Drama', '1999-10-15'),
('The Matrix', 'Sci-Fi', '1999-03-31'),
('Goodfellas', 'Crime', '1990-09-19'),
('The Silence of the Lambs', 'Thriller', '1991-02-14');

INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
VALUES 
(1, '2024-01-01', '2024-12-31', 'Premium'),
(2, '2024-01-15', '2024-12-31', 'Standard'),
(3, '2024-02-01', '2024-11-30', 'Premium'),
(4, '2024-03-01', NULL, NULL),
(5, '2024-04-01', '2024-09-30', 'Standard'),
(6, '2024-05-01', NULL, NULL),
(7, '2024-06-01', '2024-12-31', 'Premium');



INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
VALUES 
(1, 1, '2024-06-01 14:30:00'),
(2, 2, '2024-06-02 16:00:00'),
(3, 3, '2024-06-03 18:15:00'),
(4, 4, '2024-06-04 20:00:00'),
(5, 5, '2024-06-05 21:30:00'),
(6, 6, '2024-06-06 22:45:00'),
(7, 7, '2024-06-07 23:00:00'),
(8, 8, '2024-06-08 19:45:00'),
(9, 9, '2024-06-09 18:00:00'),
(10, 10, '2024-06-10 17:30:00'),
(1, 11, '2024-06-11 15:45:00'),
(2, 1, '2024-06-12 14:00:00'),
(3, 2, '2024-06-13 13:30:00'),
(4, 3, '2024-06-14 12:45:00'),
(5, 4, '2024-06-15 11:00:00'),
(6, 5, '2024-06-16 10:15:00'),
(7, 6, '2024-06-17 09:30:00'),
(8, 7, '2024-06-18 08:45:00'),
(9, 8, '2024-06-19 07:00:00'),
(10, 9, '2024-06-20 06:30:00');


CREATE TABLE HistorialVisualizacion(
HistorialID INT IDENTITY(1,1) PRIMARY KEY,
UsuarioID INT NOT NULL,
PeliculaID INT NOT NULL,
FechaVisualizacion DATETIME NOT NULL DEFAULT GETDATE(), 
FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
FOREIGN KEY (PeliculaID) REFERENCES Peliculas(PeliculaID)
);