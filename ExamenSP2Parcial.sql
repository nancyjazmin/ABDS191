CREATE PROCEDURE sp_nuevacuenta 
  @ClienteID INT,
  @TipoCuenta NVARCHAR (50),
  @Saldo DECIMAL (18,2),
  @FechaApertura DATE
AS 
BEGIN 
 INSERT INTO Cuentas(ClienteID,TipoCuenta,Saldo,FechaApertura)
 VALUES (@ClienteID,@TipoCuenta,@Saldo,@FechaApertura);
 
END;


EXEC sp_nuevacuenta @ClienteID =1,@TipoCuenta= 'Nomina',@Saldo= '4900.50',@FechaApertura='2024-07-10';
EXEC sp_nuevacuenta @ClienteID =2,@TipoCuenta= 'Cheque',@Saldo= '9000.00',@FechaApertura='2024-06-14';
EXEC sp_nuevacuenta @ClienteID =3,@TipoCuenta= 'Ahorro',@Saldo= '56000.00',@FechaApertura='2024-07-10';

SELECT * FROM Cuentas;



CREATE PROCEDURE sp_modificardatos
    @CuentaID INT,
    @TipoCuenta NVARCHAR (50),
    @Saldo DECIMAL (18,2),
    @FechaApertura DATE
AS
BEGIN 
   
   UPDATE Cuentas 
    SET TipoCuenta = @TipoCuenta,
	    Saldo =  @Saldo,
		FechaApertura = @FechaApertura
    WHERE CuentaID = @CuentaID;
	
END;

EXEC sp_modificardatos @CuentaID ='2',@TipoCuenta = 'Ahorro', @Saldo ='1800.00',@FechaApertura ='2024-04-25';
EXEC sp_modificardatos @CuentaID ='5',@TipoCuenta = 'Nomina', @Saldo ='2500.00',@FechaApertura ='2024-01-27';
EXEC sp_modificardatos @CuentaID ='6',@TipoCuenta = 'Empresarial', @Saldo ='200000.00',@FechaApertura ='2024-03-30';

SELECT * FROM Cuentas;

