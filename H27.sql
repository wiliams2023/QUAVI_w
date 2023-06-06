
/*
Como supervisor, quiero tener la capacidad de realizar ajustes o correcciones
en las lecturas de medidores realizadas por los operadores, en caso de detectar
errores o discrepancias. - H27
*/

CREATE PROCEDURE RealizarAjusteLecturaMedidor
    @IdLectura INT,
    @NuevaLectura VARCHAR(255)
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM OrdenTrabajo OT
        INNER JOIN Usuarios U ON OT.IdUsuario = U.IdUsuario
        WHERE OT.IdOrdenTrabajo = @IdLectura AND U.IdCargo = 4 -- 4 representa el rol de supervisor
    )
    BEGIN
        UPDATE OrdenTrabajo
        SET NuevaLectura = @NuevaLectura
        WHERE IdOrdenTrabajo = @IdLectura;
    END
    ELSE
    BEGIN
        RAISERROR('No se puede realizar el ajuste. El usuario no tiene permisos de supervisor o la lectura no existe.', 16, 1);
    END
END
