--TSQL
/*
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
 */

 --CASE
 
 declare @valor int 
 declare @resultado char(10) =''
 set @valor = 20 

 set @resultado = (CASE WHEN @valor=10 THEN 'ROJO'
                     WHEN @valor=20 THEN 'MORADO'
					 WHEN @valor=30 THEN 'AMARILLO'
					 ELSE 'GRIS'
					 END)
print @resultado

select * ,(CASE WHEN disponibilidad= 1 THEN 'VERDE'
                WHEN disponibilidad=0 THEN 'ROJO'
				ELSE 'NEGRO' END)AS INDICADOR
                FROM Inventario