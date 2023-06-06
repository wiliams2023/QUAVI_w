/*

Como supervisor, quiero tener la opción de generar informes de lecturas
de medidores pendientes o no registradas, para garantizar que se complete
el proceso de manera oportuna. (OK) H24

*/

CREATE PROCEDURE GenerarInformeLecturasMedidores
    @TipoInforme VARCHAR(50) -- "Pendientes" o "NoRegistradas"
AS
BEGIN
    IF @TipoInforme = 'Pendientes'
    BEGIN
        SELECT *
        FROM OrdenTrabajo
        WHERE EstadoLectura = 'Pendiente';
    END
    ELSE IF @TipoInforme = 'NoRegistradas'
    BEGIN
        SELECT *
        FROM OrdenTrabajo
        WHERE EstadoLectura = 'No Registrada';
    END
    ELSE
    BEGIN
        RAISERROR('Tipo de informe no válido.', 16, 1);
    END
END
