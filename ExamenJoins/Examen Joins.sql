CREATE TABLE Autores (
id_autor bigint identity(300,1) PRIMARY KEY,
nombre VARCHAR(100),
pais_origen VARCHAR(100)
);

ALTER TABLE Comics
ADD id_autor bigint,
FOREIGN KEY (id_autor) REFERENCES Autores(id_autor);

INSERT INTO Autores(nombre,pais_origen) VALUES
('Guillermo Monte','España'),
('Bernardo Guzmán','Guatemala'),
('Martina Marquez','México'),
('Francesca Paci','Francia');

INSERT INTO Comics(titulo,anio,precio,id_autor) VALUES
('El hombre araña',90,17.90,302),
('La tierra ',90,17.90,300);

SELECT * FROM Comics;

SELECT *FROM Autores;


SELECT c.titulo,a.nombre,a.pais_origen
FROM Comics c 
JOIN Autores a ON c.id_autor = a.id_autor;

SELECT a.nombre,cc.cantidad
FROM Autores a 
JOIN Comics c ON a.id_autor = c.id_autor
JOIN Comic_Compras cc ON c.id_comic = cc.id_comic;

SELECT * FROM Comic_Compras;



