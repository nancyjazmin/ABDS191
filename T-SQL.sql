--TSQL

---declaración de variables
declare @idCliente int 

---inicializar o asignar un valor 
set @idCliente = 8 

--if 
--IF  @idCliente = 8 
  -- select * from Clients WHERE id_cliente = @idCliente
   

declare @edad int 
 set @idCliente = 8

IF @idCliente = 9
 BEGIN
  set @edad = 25 
  select * from Clients WHERE id_cliente = @idCliente 
  print @edad 
 END
ELSE 
  print 'id no autorizado para consulta'

  --WHILE
declare @contador int = 0
    
WHILE @contador <=10
  BEGIN
    print @contador
    set @contador= @contador + 1 
	IF @contador = 3 
	  BREAK
    print ('hola')
  END
  print ('aqui continua el flujo')

 BEGIN TRY
	set @contador = 'Nancy Jazmín'
 END TRY 
BEGIN CATCH 
    print ('la variable contador solo acepta enteros')
END CATCH

 print('soy otra consulta')
 print('yo también')