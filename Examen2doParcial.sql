CREATE TABLE Clientes (
 ClienteID INT IDENTITY (1,1) PRIMARY KEY,
 Nombre NVARCHAR (100),
 Direccion NVARCHAR (200),
 Telefono NVARCHAR(15),
 Email NVARCHAR (100) 
 );

 INSERT INTO Clientes (Nombre,Direccion,Telefono,Email)
 VALUES ('Maria','Queretaro',4456782917,'maria@bank.com');

 INSERT INTO Clientes (Nombre,Direccion,Telefono,Email)
 VALUES ('Juan','Monterrey',4474650343,'juanM@bank.com');

 INSERT INTO Clientes (Nombre,Direccion,Telefono,Email)
 VALUES ('Jose','Tijuana',4474650343,'jose@bank.com');

 SELECT *FROM Clientes;

 CREATE TABLE Cuentas (
  CuentaID INT IDENTITY (1,1) PRIMARY KEY,
  ClienteID INT,
  TipoCuenta NVARCHAR (50),
  Saldo DECIMAL (18,2),
  FechaApertura DATE,
  FOREIGN KEY (ClienteID) REFERENCES Clientes (ClienteID)
  );

  CREATE TABLE Transacciones ( 
  TransaccionID INT IDENTITY (1,1) PRIMARY KEY,
  CuentaID INT,
  TipoTransaccion NVARCHAR (50),
  Monto DECIMAL (18,2),
  FechaTransaccion DATETIME,
  FOREIGN KEY (CuentaID) REFERENCES Cuentas(CuentaID)
  );

  INSERT INTO Transacciones (CuentaID,TipoTransaccion,Monto,FechaTransaccion)
  VALUES (3,'Pago','500.00','2024-09-28');

  INSERT INTO Transacciones (CuentaID,TipoTransaccion,Monto,FechaTransaccion)
  VALUES (5,'Cobro','2000.00','2024-09-18');

  CREATE TABLE Empleados (
   EmpleadosID INT IDENTITY (1,1) PRIMARY KEY,
   Nombre NVARCHAR (100),
   Posicion NVARCHAR (50),
   Departamento NVARCHAR (50),
   FechaContratacion DATE
   );
