
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
