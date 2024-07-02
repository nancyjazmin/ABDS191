
CREATE PROCEDURE sp_suscrip
@SuscripcionID INT,
@UsuarioID INT,
@FechaInicio DATE,
@FechaFin DATE,
@Tipo NVARCHAR(58)
AS
BEGIN
   BEGIN TRANSACTION;
   BEGIN TRY
         INSERT INTO Suscripciones(SuscripcionID, UsuarioID, FechaInicio, FechaFin,Tipo)
         VALUES ( @SuscripcionID,@UsuarioID, @FechaInicio,@FechaFin,@Tipo);

         UPDATE Usuarios 
         SET FechaRegistro = @FechaInicio
         WHERE UsuarioID=@UsuarioID;

COMMIT TRANSACTION;
   END TRY
BEGIN CATCH 
  ROLLBACK TRANSACTION;
  DECLARE @ErrorMessage NVARCHAR(4000);
  SET @ErrorMessage = ERROR_MESSAGE();
  PRINT @ErrorMessage;
END CATCH;

END;

SELECT * FROM Suscripciones;
SELECT * FROM Usuarios;
EXEC sp_suscrip '1','2','2024-07-01','2024-08-01','Premium'