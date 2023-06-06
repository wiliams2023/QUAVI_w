

/*
Como supervisor, quiero tener la opción de asignar niveles de prioridad 
a las tareas de lectura de medidores, para asegurar que los casos urgentes 
sean atendidos de manera prioritaria. H29
*/


CREATE PROCEDURE AsignarPrioridadTareaLecturaMedidor
    @IdTarea INT,
    @NivelPrioridad INT
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM OrdenTrabajo
        WHERE IdOrdenTrabajo = @IdTarea
    )
    BEGIN
        UPDATE OrdenTrabajo
        SET NivelPrioridad = @NivelPrioridad
        WHERE IdOrdenTrabajo = @IdTarea;
    END
    ELSE
    BEGIN
        RAISERROR('No se puede asignar prioridad a la tarea. La tarea no existe.', 16, 1);
    END
END
