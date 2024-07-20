-- Trigger
CREATE TRIGGER trg_TableCreated
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    DECLARE @tableName NVARCHAR(128);
    SET @tableName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(128)');
    
    PRINT 'Se ha creado una nueva tabla ' + @tableName + ' en DBBANK.';
END;


CREATE TABLE Prestamos(
PrestamoID INT IDENTITY (1,1) PRIMARY KEY,
ClienteID INT,
Monto DECIMAL(18,2),
TasaInterese DECIMAL(5,2),
FechaInicio DATE,
FechaFin DATE,
FOREIGN KEY (ClienteID) REFERENCES Clientes (ClienteID)
);

INSERT INTO Prestamos (ClienteID, Monto, TasaInterese, FechaInicio, FechaFin)
VALUES 
    (1, 10000.00, 8.5, '2023-01-15', '2024-01-15'),
    (2, 15000.00, 7.0, '2023-02-20', '2024-02-20'),
    (3, 8000.00, 9.0, '2023-03-10', '2024-03-10');


SELECT * FROM Prestamos;

CREATE TABLE PagosPrestamos (
PagoID INT IDENTITY (1,1) PRIMARY KEY,
PrestamoID INT,
MontoPagado DECIMAL (18,2),
FechaPago DATE,
FOREIGN KEY (PrestamoID) REFERENCES PrestamoS(PrestamoID)
);


INSERT INTO PagosPrestamos (PrestamoID, MontoPagado, FechaPago)
VALUES 
    (1, 1500.00, '2023-02-15'),
    (2, 2000.00, '2023-03-20'),
    (1, 1200.00, '2023-03-05'),
    (3, 1000.00, '2023-04-10');

SELECT * FROM PagosPrestamos;

-- Crear el trigger de nuevo procedimiento
CREATE TRIGGER trg_NuevoProcedimiento
ON DATABASE
FOR CREATE_PROCEDURE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @eventName NVARCHAR(100);
    SET @eventName = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)');
    
    IF @eventName = 'CREATE_PROCEDURE'
    BEGIN
        DECLARE @procedureName NVARCHAR(128);
        SET @procedureName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(128)');
        
        PRINT 'Se ha creado un Nuevo Procedimiento ' + @procedureName + ' en DBBANK.';
    END
END;

CREATE PROCEDURE sp_IngresarPrestamoConPagoInicial
    @ClienteID INT,
    @MontoPrestamo DECIMAL(18,2),
    @TasaInteres DECIMAL(5,2),
    @FechaInicio DATE,
    @FechaFin DATE,
    @MontoPrimerPago DECIMAL(18,2),
    @FechaPrimerPago DATE
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        INSERT INTO Prestamos (ClienteID, Monto, TasaInterese, FechaInicio, FechaFin)
        VALUES (@ClienteID, @MontoPrestamo, @TasaInteres, @FechaInicio, @FechaFin);

        DECLARE @PrestamoID INT;
        SET @PrestamoID = SCOPE_IDENTITY(); -- Obtener el ID del préstamo insertado

        INSERT INTO PagosPrestamos (PrestamoID, MontoPagado, FechaPago)
        VALUES (@PrestamoID, @MontoPrimerPago, @FechaPrimerPago);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback de la transacción en caso de error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

EXEC sp_IngresarPrestamoConPagoInicial
    @ClienteID = 1,
    @MontoPrestamo = 10000.00,
    @TasaInteres = 8.5,
    @FechaInicio = '2024-07-19',
    @FechaFin = '2025-07-19',
    @MontoPrimerPago = 1500.00,
    @FechaPrimerPago = '2024-08-01';

CREATE PROCEDURE sp_ConsultarClientesConPrestamosYPagos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.ClienteID,
        c.Nombre AS NombreCliente,c.Direccion,c.Telefono,c.Email,
        pr.PrestamoID,pr.Monto AS MontoPrestamo,
        pr.TasaInterese AS TasaInteres,
        pr.FechaInicio AS FechaInicioPrestamo,
        pr.FechaFin AS FechaFinPrestamo,
        pp.PagoID,pp.MontoPagado,pp.FechaPago
    FROM 
        Clientes c
        LEFT JOIN Prestamos pr ON c.ClienteID = pr.ClienteID
        LEFT JOIN PagosPrestamos pp ON pr.PrestamoID = pp.PrestamoID
    ORDER BY
        c.ClienteID,
        pr.PrestamoID,
        pp.FechaPago; -- Puedes ajustar el ordenamiento según tus necesidades
END;
