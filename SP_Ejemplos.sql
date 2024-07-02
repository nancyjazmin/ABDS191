
--Explorar las propiedades de una bae de datos.

EXEC sp_helpdb


--Explorar las propiedades de un objeto de la BD
EXEC sp_help 'Clients'

--llaves foraneas de una tabla 
EXEC sp_helpindex 'Clients'

--Información de los usuarios y procesos actulaes 
EXEC sp_who

--Rendimiento del servidor

EXEC sp_monitor 

--Espacio usado por la BD
EXEC sp_spaceused

--Puerto de escucha del SQL SERVER 
EXEC sp_readerrorlog 0,1



--Nuestros procedimientos 

CREATE PROCEDURE sp_ObtenerHistorial 
@usuarioId INT
AS
BEGIN 

select h.HistorialID,p.Titulo,h.FechaVisualizacion
from HistorialVisualizacion h
JOIN Peliculas p ON h.PeliculaID =p.PeliculaID
WHERE h.UsuarioID = @usuarioId
ORDER BY h.FechaVisualizacion DESC 
END;

EXEC sp_ObtenerHistorial  1


--SP para Insertar Peliculas 

CREATE PROCEDURE sp_InsertarPeliculas
@titulo NVARCHAR(100),
@genero NVARCHAR(50),
@fechaEstreno DATE
AS
BEGIN
  INSERT INTO Peliculas (Titulo,Genero,FechaEstreno)
  VALUES (@titulo,@genero,@fechaEstreno)
END;

EXEC sp_InsertarPeliculas @titulo='Intensamente 2',@genero='Infantil',@fechaEstreno='2024-06-13'

SELECT * FROM Peliculas;