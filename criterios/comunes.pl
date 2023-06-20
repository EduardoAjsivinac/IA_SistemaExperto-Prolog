% comunes.pl

:- consult('hechos.pl').

imprimir_registros([]).

imprimir_registros([[IDHOTEL, NOMBRE_HOTEL, DIRECCION, DEPARTAMENTO, DISTANCIA, PRECIOHABITACION, TOTAL, TIPO_HABITACION, GASOLINA, PRECIO_ALIMENTACION] | Resto]) :-
    departamento(DEPARTAMENTO, NOMBRE_DEPTO, _, _, _, _),
    format("~|~t~w~t~20+~t~w~t~25+~t~w~t~15+~t~w~t~10+~t~w~t~20+~t~w~t~10+~t~w~t~20+~t~w~t~n", [NOMBRE_HOTEL, TIPO_HABITACION, NOMBRE_DEPTO, GASOLINA, PRECIOHABITACION, PRECIO_ALIMENTACION, TOTAL, DIRECCION]),
    imprimir_registros(Resto).



encontrar_hoteles(REGISTROS, PRESUPUESTO, CALIFICACION, TIPO_HAB, CLIMA, DISTANCIA, VEHICULO, ALIMENTACION, DIAS, IDIOMA) :-
    findall([IDHOTEL, NOMBRE_HOTEL, DIRECCION, DEPARTAMENTO, DISTANCIA, PRECIOHABITACION, TOTAL, TIPO_HABITACION, GASOLINA, PRECIO_ALIMENTACION], (
        hotel(IDHOTEL, NOMBRE_HOTEL, DIRECCION, ESTRELLAS, HABITACIONSIMP, HABITACIONDOB, COMIDA, DEPARTAMENTO, DISTANCIA),
        idioma(IDIOMA, NOMBRE_IDIOMA),
        departamento(DEPARTAMENTO, _, _, NOMBRE_IDIOMA, TIPOCLIMA, PASAJE),
        (
            CLIMA > 0 ->(
                clima(CLIMA, VALORCLIMA)
            );
            VALORCLIMA = TIPOCLIMA
        ),
        (
            VEHICULO = 0 -> (
                VALORPASAJE = PASAJE
                );
            VALORPASAJE = 0
        ),
        GASOLINA is DISTANCIA * 12.5 * VEHICULO * 2 + VALORPASAJE * 2,
        PRECIO_ALIMENTACION is ALIMENTACION * COMIDA * DIAS,
        (
            (
                TIPO_HAB = -1,
                PRESUPUESTO >= GASOLINA + (HABITACIONSIMP+ ALIMENTACION * COMIDA)*DIAS,
                PRECIOHABITACION is HABITACIONSIMP * DIAS,
                TIPO_HABITACION = 'Habitacion simple',
                TOTAL is GASOLINA + (HABITACIONSIMP+ ALIMENTACION * COMIDA)*DIAS
            )
            ;
            (
                TIPO_HAB = -1,
                PRESUPUESTO >= GASOLINA + (HABITACIONDOB+ ALIMENTACION * COMIDA)*DIAS,
                PRECIOHABITACION is HABITACIONDOB * DIAS,
                TIPO_HABITACION = 'Habitacion doble',
                TOTAL is GASOLINA + (HABITACIONDOB + ALIMENTACION * COMIDA)*DIAS
            )
            ;
            (
                TIPO_HAB = 0,
                PRESUPUESTO >= GASOLINA + (HABITACIONSIMP+ ALIMENTACION * COMIDA)*DIAS,
                PRECIOHABITACION is HABITACIONSIMP * DIAS,
                TIPO_HABITACION = 'Habitacion simple',
                TOTAL is GASOLINA + (HABITACIONSIMP+ ALIMENTACION * COMIDA)*DIAS
            )
            ;
            (
                TIPO_HAB = 1,
                PRESUPUESTO >= GASOLINA + (HABITACIONDOB+ ALIMENTACION * COMIDA)*DIAS,
                PRECIOHABITACION is HABITACIONDOB * DIAS,
                TIPO_HABITACION = 'Habitacion doble',
                TOTAL is GASOLINA + (HABITACIONDOB + ALIMENTACION * COMIDA)*DIAS
            )
        ),
        TOTAL =< PRESUPUESTO,
        TIPOCLIMA = VALORCLIMA,
        ESTRELLAS >= CALIFICACION

    ), REGISTROS).

imprimir_hecho([]).

imprimir_hecho([[CODIGO, NOMBRE]|Resto]) :-
    format("~w. ~w~n", [CODIGO, NOMBRE]),
    imprimir_hecho(Resto).


