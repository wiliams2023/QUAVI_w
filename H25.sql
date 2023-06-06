
/*
Como supervisor, quiero recibir alertas en tiempo real cuando haya 
un retraso en la lectura de medidores o si hay operadores inactivos,
para tomar medidas correctivas de manera inmediata. H25
*/


CREATE PROCEDURE AlertasLecturasMedidores
AS
BEGIN
    DECLARE @CantidadOperadoresInactivos INT;
    DECLARE @CantidadLecturasPendientes INT;

    -- Verificar cantidad de operadores inactivos
    SELECT @CantidadOperadoresInactivos = COUNT(*)
    FROM Usuarios
    WHERE IdCargo = 3 -- 3 representa el rol de operador
    AND DATEDIFF(MINUTE, UltimaConexion, GETDATE()) > 30; -- Operador inactivo si no ha tenido conexión en los últimos 30 minutos

    -- Verificar cantidad de lecturas pendientes
    SELECT @CantidadLecturasPendientes = COUNT(*)
    FROM OrdenTrabajo
    WHERE FechaHoraLectura IS NULL;

    -- Generar alertas
    IF @CantidadOperadoresInactivos > 0
    BEGIN
        INSERT INTO Alertas (TipoAlerta, Descripcion)
        VALUES ('Operadores Inactivos', 'Hay operadores inactivos. Tomar medidas correctivas.');
    END

    IF @CantidadLecturasPendientes > 0
    BEGIN
        INSERT INTO Alertas (TipoAlerta, Descripcion)
        VALUES ('Lecturas Pendientes', 'Hay lecturas de medidores pendientes. Tomar medidas correctivas.');
    END
END
