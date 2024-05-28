INSERT INTO Clients(nombre, correo_electronico, contrase�a) VALUES 
 ('Juan P�rez', 'juan.perez@example.com', 'juan123'),
( 'Ana G�mez', 'ana.gomez@example.com', 'ana123'),
( 'Carlos L�pez', 'carlos.lopez@example.com', 'carlos123'),
('Mar�a Rodr�guez', 'maria.rodriguez@example.com', 'mari123'),
('Pedro S�nchez', 'pedro.sanchez@example.com', 'pedro123'),
('Laura Fern�ndez', 'laura.fernandez@example.com', 'lau123'),
('Jos� Ram�rez', 'jose.ramirez@example.com', 'jose123'),
('Luc�a Torres', 'lucia.torres@example.com', 'lucia123'),
('Miguel D�az', 'miguel.diaz@example.com', 'diaz456'),
('Sara Mart�nez', 'sara.martinez@example.com', 'sara789'),
('Ra�l Hern�ndez', 'raul.hernandez@example.com', 'hernandez101'),
('Elena Castillo', 'elena.castillo@example.com', 'castillo102');

SELECT * FROM Clients;

INSERT INTO Comics(titulo,anio,precio) VALUES 
('Cien A�os de Soledad', 94, 19.00),
('Don Quijote de la Mancha', 95, 15.00),
('El Principito', 90, 12.76),
('1984', 90, 18.00),
('Matar a un Ruise�or', 95, 14.99);

INSERT INTO Comics (titulo, anio, precio) VALUES
('Orgullo y Prejuicio', 81, 13.50),
('Crimen y Castigo', 20, 17.25),
('El Gran Gatsby', 95, 16.00),
('En el Camino', 95, 14.80),
('Ulises', 92, 22.00),
('Los Miserables', 86, 20.99),
('La Odisea', 80, 18.50),
('El Hobbit', 93, 19.95),
('La Divina Comedia', 98, 21.45),
('Fahrenheit 451', 99, 15.75);


SELECT * FROM Comics;


INSERT INTO Inventario (id_comic,cantidad_disponible,disponibilidad) VALUES
(14, 50, 1),
(16, 0, 0),
(18, 30,1),
(20, 5,1),
(22, 12,1),
(24, 0, 0),
(26, 8, 1),
(28, 60, 1),
(30, 15,1),
(32, 3,1),
(34, 25, 1),
(36, 0, 0),
(38, 40, 1),
(40, 100, 1),
(42, 20, 1);

SELECT * FROM Inventario;


INSERT INTO Compras (id_cliente,fecha_compra, total) VALUES 
(1,'2024-05-01', 45.50),
(2,'2024-05-02', 120.00),
(3,'2024-05-03', 78.25),
(4,'2024-05-04', 53.75),
(5,'2024-05-05', 67.80),
(6,'2024-05-06', 92.10),
(7,'2024-05-07', 33.50),
(8,'2024-05-08', 120.50), 
(9,'2024-05-09', 45.75),
(10,'2024-05-10', 89.30); 

SELECT *FROM Compras;