
--Como supervisor, quiero poder acceder al historial de lecturas de 
--medidores de cada operador, para tener un seguimiento de su desempe�o 
--a lo largo del tiempo. (OK)  H26
CREATE PROCEDURE ObtenerHistorialLecturasMedidores
    @IdOperador INT
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM Usuarios
        WHERE IdUsuario = @IdOperador AND IdCargo = 3 -- 3 representa el rol de operador
    )
    BEGIN
        SELECT *
        FROM OrdenTrabajo
        WHERE IdUsuario = @IdOperador
        ORDER BY fechaCorte DESC;
    END
    ELSE
    BEGIN
        RAISERROR('El usuario especificado no es un operador v�lido.', 16, 1);
    END
END

