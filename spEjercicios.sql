
CREATE PROCEDURE sp_InsertarUsuarios 
@Nombre NVARCHAR (100),
@Email NVARCHAR (100),
@Pass NVARCHAR (100),
@FechaRegistro DATE
AS
BEGIN 
INSERT INTO Usuarios (Nombre,Email,Pass,FechaRegistro)
VALUES (@Nombre,@Email,@Pass,@FechaRegistro)

END;

EXEC sp_InsertarUsuarios 
 @Nombre='Mariana Hurtado',@Email='marianah@streaming.com',@Pass='12345Cc',@FechaRegistro='2024-06-01'

 SELECT * FROM Usuarios;


 CREATE PROCEDURE edit_sp
@SuscripcionID INT,
@UsuarioID INT,
@FechaInicio DATE,
@FechaFin DATE,
@Tipo NVARCHAR(58)
AS
BEGIN
   UPDATE Suscripciones
SET
 UsuarioID = @UsuarioID,
 FechaInicio = @FechaInicio,
 FechaFin = @FechaFin,
 Tipo     = @Tipo
 WHERE SuscripcionID= @SuscripcionID;

END;

EXEC edit_sp @SuscripcionID ='2',@UsuarioID='2', @FechaInicio= '2024-01-15',@FechaFin='2024-12-31',@Tipo ='Premium'
EXEC edit_sp @SuscripcionID ='6',@UsuarioID='6', @FechaInicio= '2024-05-01',@FechaFin='2024-02-24',@Tipo ='Premium'
EXEC edit_sp @SuscripcionID ='7',@UsuarioID='7', @FechaInicio= '2024-01-18',@FechaFin='2024-12-31',@Tipo ='Standar'


CREATE PROCEDURE EliminarHistorialVisualizacion
    @HistorialID INT
AS
BEGIN
        DELETE FROM HistorialVisualizacion
        WHERE HistorialID = @HistorialID;
     
END;

EXEC EliminarHistorialVisualizacion @HistorialID ='1'
EXEC EliminarHistorialVisualizacion @HistorialID ='2'
EXEC EliminarHistorialVisualizacion @HistorialID ='3'

SELECT * FROM HistorialVisualizacion;

