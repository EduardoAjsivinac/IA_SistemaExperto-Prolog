# IA_SistemaExperto-Prolog
## Creación de métodos de "busqueda" de hechos.
```prolog
% Encontrar hoteles que cumplan con ciertos criterios
encontrar_hoteles(REGISTROS, PRESUPUESTO, CALIFICACION, TIPO_HAB, CLIMA, DISTANCIA, VEHICULO, ALIMENTACION, DIAS, IDIOMA) :-
    % Utilizar findall para obtener una lista de registros que cumplan las condiciones
    findall([IDHOTEL, NOMBRE_HOTEL, DIRECCION, DEPARTAMENTO, DISTANCIA, PRECIOHABITACION, TOTAL, TIPO_HABITACION, GASOLINA, PRECIO_ALIMENTACION], (
        % Obtener información del hotel
        hotel(IDHOTEL, NOMBRE_HOTEL, DIRECCION, ESTRELLAS, HABITACIONSIMP, HABITACIONDOB, COMIDA, DEPARTAMENTO, DISTANCIA),
        % Aplicar filtros de idioma
        idioma(IDIOMA, NOMBRE_IDIOMA),
        % Aplicar filtros de departamento
        departamento(DEPARTAMENTO, _, _, NOMBRE_IDIOMA, TIPOCLIMA, PASAJE),
        % Encontrar el clima si existiera
        (
            CLIMA > 0 -> (
                clima(CLIMA, VALORCLIMA)
            );
            VALORCLIMA = TIPOCLIMA
        ),
        % Calcular el costo de gasolina o el valor del pasaje.
        (
            VEHICULO = 0 -> (
                VALORPASAJE = PASAJE
            );
            VALORPASAJE = 0
        ),
        GASOLINA is DISTANCIA * 12.5 * VEHICULO * 2 + VALORPASAJE * 2,
        % Calcular el costo de la alimentación según el precio y la duración del viaje
        PRECIO_ALIMENTACION is ALIMENTACION * COMIDA * DIAS,
        (
            % Verificar si se busca una habitación simple
            (
                TIPO_HAB = -1,
                PRESUPUESTO >= GASOLINA + (HABITACIONSIMP + ALIMENTACION * COMIDA) * DIAS,
                PRECIOHABITACION is HABITACIONSIMP * DIAS,
                TIPO_HABITACION = 'Habitacion simple',
                TOTAL is GASOLINA + (HABITACIONSIMP + ALIMENTACION * COMIDA) * DIAS
            )
            % Verificar si se busca una habitación doble
            ;
            (
                TIPO_HAB = -1,
                PRESUPUESTO >= GASOLINA + (HABITACIONDOB + ALIMENTACION * COMIDA) * DIAS,
                PRECIOHABITACION is HABITACIONDOB * DIAS,
                TIPO_HABITACION = 'Habitacion doble',
                TOTAL is GASOLINA + (HABITACIONDOB + ALIMENTACION * COMIDA) * DIAS
            )
            % Verificar si se busca cualquier tipo de habitación
            ;
            (
                TIPO_HAB = 0,
                PRESUPUESTO >= GASOLINA + (HABITACIONSIMP + ALIMENTACION * COMIDA) * DIAS,
                PRECIOHABITACION is HABITACIONSIMP * DIAS,
                TIPO_HABITACION = 'Habitacion simple',
                TOTAL is GASOLINA + (HABITACIONSIMP + ALIMENTACION * COMIDA) * DIAS
            )
            % Verificar si se busca cualquier tipo de habitación
            ;
            (
                TIPO_HAB = 1,
                PRESUPUESTO >= GASOLINA + (HABITACIONDOB + ALIMENTACION * COMIDA) * DIAS,
                PRECIOHABITACION is HABITACIONDOB * DIAS,
                TIPO_HABITACION = 'Habitacion doble',
                TOTAL is GASOLINA + (HABITACIONDOB + ALIMENTACION * COMIDA) * DIAS
            )
        ),
        % Verificar si el costo total es menor o igual al presupuesto disponible
        TOTAL =< PRESUPUESTO,
        % Asignar el valor del clima
        TIPOCLIMA = VALORCLIMA,
        % Verificar si las estrellas del hotel son iguales o superiores a la calificación deseada
        ESTRELLAS >= CALIFICACION
    ), REGISTROS).

```