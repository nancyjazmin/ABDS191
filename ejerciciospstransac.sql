-- Prtocedimiento para inserta pelicula e insertar registro en historial de vizualización
CREATE PROCEDURE sp_NuevaPelicula
	@Titulo NVARCHAR(100),
	@Genero NVARCHAR(50),
	@F_E DATE,
	@UsuarioID INT
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
		
	INSERT INTO Peliculas (Titulo, Genero, FechaEstreno)
	VALUES (@Titulo, @Genero, @F_E);

		DECLARE @movie INT;
		SET @movie = SCOPE_IDENTITY();
		PRINT @movie; 
	INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
	VALUES (@UsuarioID, @movie, GETDATE());

		COMMIT;
	END TRY
BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
END;

EXEC sp_NuevaPelicula @Titulo = 'Inception', @Genero = 'Ciencia Ficción', @F_E = '2010-07-16',  @UsuarioID = 1;
EXEC sp_NuevaPelicula @Titulo = 'Moana', @Genero = 'Infantil', @F_E = '2022-06-16',  @UsuarioID = 5;
EXEC sp_NuevaPelicula @Titulo = 'Las Profundidades del Sena', @Genero = 'Ciencia Ficción', @F_E = '2024-05-04',  @UsuarioID = 8;

SELECT * FROM PELICULAS;
SELECT *FROM HistorialVisualizacion;


CREATE PROCEDURE sp_UPV
    @UsuarioID INT,
    @Nombre NVARCHAR(255),
    @Email NVARCHAR(100),
    @Pass NVARCHAR(100),
	@FechaRegistro DATE,
	@Tipo NVARCHAR (58),
	@PeliculaID INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO Usuarios (Nombre, Email, FechaRegistro)
        VALUES (@Nombre, @Email, @FechaRegistro);
        
        SET @UsuarioID = SCOPE_IDENTITY();
        
     INSERT INTO Suscripciones (UsuarioID, Tipo, FechaInicio)
     VALUES (@UsuarioID,@Tipo, @FechaRegistro);
  
    INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
    VALUES (@UsuarioID, @PeliculaID, GETDATE());
        
        COMMIT;
    END TRY 
BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
	END;

EXEC sp_UPV 2,'Maria Gomez','maria.gomez@example.com','password123','2021-06-23','Premium',5; 
EXEC sp_UPV 4,'Hernan Ferruzca','hernan.ferruzca@example.com','password123','2024-07-04','Premium',4; 
EXEC sp_UPV 8,'Daniela Beltran','daniela.beltran@example.com','password123','2024-05-23','Standar',6; 

SELECT * FROM Usuarios;
SELECT * FROM Suscripciones;


CREATE PROCEDURE sp_ActualizarCorreoYTipoSuscripcion
    @UsuarioID INT,
    @NuevoCorreo NVARCHAR(100)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE Usuarios
        SET Email = @NuevoCorreo
        WHERE UsuarioID = @UsuarioID;

        UPDATE Suscripciones
        SET Tipo = 'Anual'
        WHERE UsuarioID = @UsuarioID;
        COMMIT TRANSACTION;
    END TRY
  BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
	END;

EXEC sp_ActualizarCorreoYTipoSuscripcion @UsuarioID = 1, @NuevoCorreo = 'perez.juan@example.com';
EXEC sp_ActualizarCorreoYTipoSuscripcion @UsuarioID = 3, @NuevoCorreo = 'ramirez.carlos@example.com';
EXEC sp_ActualizarCorreoYTipoSuscripcion @UsuarioID = 5, @NuevoCorreo = 'miguel_T@example.com';

CREATE PROCEDURE sp_EliminarPeliculaYHistorial
    @PeliculaID INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM HistorialVisualizacion
        WHERE PeliculaID = @PeliculaID;

        DELETE FROM Peliculas
        WHERE PeliculaID = @PeliculaID;

     COMMIT TRANSACTION;
    END TRY
  BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
      
END;

EXEC sp_EliminarPeliculaYHistorial @PeliculaID = 1;
EXEC sp_EliminarPeliculaYHistorial @PeliculaID = 4;
EXEC sp_EliminarPeliculaYHistorial @PeliculaID = 6;

CREATE PROCEDURE sp_EliminarUsuarioConSuscripcionesYHistorial
    @UsuarioID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        DELETE FROM HistorialVisualizacion
        WHERE UsuarioID = @UsuarioID;

        DELETE FROM Suscripciones
        WHERE UsuarioID = @UsuarioID;

        DELETE FROM Usuarios
        WHERE UsuarioID = @UsuarioID;

        COMMIT TRANSACTION;
    END TRY
     BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
   
END;

EXEC sp_EliminarUsuarioConSuscripcionesYHistorial @UsuarioID = 8;
EXEC sp_EliminarUsuarioConSuscripcionesYHistorial @UsuarioID = 10;
EXEC sp_EliminarUsuarioConSuscripcionesYHistorial @UsuarioID = 7;


