
BEGIN TRANSACTION;
INSERT INTO Clients (nombre, correo_electronico, contraseña) 
VALUES ('Juan Perez', 'juan.perez@example.com', 'password123');
INSERT INTO Comics (titulo, anio, precio) 
VALUES ('Spider-Man', 2002, 12.99);
INSERT INTO Compras (id_cliente, fecha_compra, total) 
VALUES (1, '2023-07-07', 12.99);
COMMIT;

BEGIN TRANSACTION;
INSERT INTO Clients (nombre, correo_electronico, contraseña) 
VALUES ('Ana Gomez', 'ana.gomez@example.com', 'pass456');
INSERT INTO Comics (titulo, anio, precio) 
VALUES ('Batman', 2010, 15.99);
INSERT INTO Compras (id_cliente, fecha_compra, total) 
VALUES (2, '2023-07-06', 15.99);
COMMIT;


BEGIN TRANSACTION;
INSERT INTO Inventario (id_comic, cantidad_disponible, disponibilidad) 
VALUES (1, 50, 1);
INSERT INTO Comic_Compras (cantidad, id_compra, id_comic) 
VALUES (1, 1, 1);
INSERT INTO Inventario (id_comic, cantidad_disponible, disponibilidad) 
VALUES (2, 30, 1);
COMMIT;


BEGIN TRANSACTION;
INSERT INTO Clients (nombre, correo_electronico, contraseña) 
VALUES ('Carlos Diaz', 'carlos.diaz@example.com', 'carlospass');
INSERT INTO Comics (titulo, anio, precio) 
VALUES ('Superman', 2005, 9.99);
INSERT INTO Compras (id_cliente, fecha_compra, total) 
VALUES (3, '2023-07-05', 9.99);
COMMIT;

BEGIN TRANSACTION;
INSERT INTO Comic_Compras (cantidad, id_compra, id_comic) 
VALUES (2, 2, 2);
INSERT INTO Comic_Compras (cantidad, id_compra, id_comic) 
VALUES (1, 3, 3);
INSERT INTO Inventario (id_comic, cantidad_disponible, disponibilidad) 
VALUES (3, 20, 1);
COMMIT;
