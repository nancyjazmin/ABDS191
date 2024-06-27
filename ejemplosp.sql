
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
 @Nombre='Gabriel Guzman',@Email='gabrielg@streaming.com',@Pass='12345Aa',@FechaRegistro='2024-01-23'