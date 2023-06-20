% comunes.pl

:- consult('hechos.pl').

imprimir_registros([]).

imprimir_registros([[IDHOTEL, NOMBRE_HOTEL, DIRECCION, DEPARTAMENTO, DISTANCIA, PRECIOHABITACION, TOTAL, TIPO_HABITACION, GASOLINA, PRECIO_ALIMENTACION] | Resto]) :-
    departamento(DEPARTAMENTO, NOMBRE_DEPTO, _, _, _, _),
    format("~|~t~w~t~20+~t~w~t~25+~t~w~t~15+~t~w~t~10+~t~w~t~20+~t~w~t~10+~t~w~t~20+~t~w~t~n", [NOMBRE_HOTEL, TIPO_HABITACION, NOMBRE_DEPTO, GASOLINA, PRECIOHABITACION, PRECIO_ALIMENTACION, TOTAL, DIRECCION]),
    imprimir_registros(Resto).



encontrar_hoteles(REGISTROS, PRESUPUESTO, CALIFICACION, TIPO_HAB, CLIMA, DISTANCIA, VEHICULO, ALIMENTACION, DIAS, IDIOMA) :-
    findall([IDHOTEL, NOMBRE_HOTEL, DIRECCION, DEPARTAMENTO, DISTANCIA, PRECIOHABITACION, TOTAL, TIPO_HABITACION, GASOLINA, PRECIO_ALIMENTACION], (
        hotel(IDHOTEL, NOMBRE_HOTEL, DIRECCION, _, HABITACIONSIMP, HABITACIONDOB, COMIDA, DEPARTAMENTO, DISTANCIA),
        departamento(DEPARTAMENTO, _, _, _, _, PASAJE),
        (
            VEHICULO = 0 -> (
                VALORPASAJE = PASAJE
                );
            VALORPASAJE = 0
        ),
        GASOLINA is DISTANCIA * 12.5 * VEHICULO * 2 + VALORPASAJE * 2,
        PRECIO_ALIMENTACION is ALIMENTACION * COMIDA * DIAS,
        (
            TIPO_HAB = 0 -> ( % Simple
                VALIDAHAB = 0
                );
            VALORPASAJE = 0
        (
            (
                PRESUPUESTO >= GASOLINA + (HABITACIONSIMP+ ALIMENTACION * COMIDA)*DIAS,
                PRECIOHABITACION is HABITACIONSIMP * DIAS,
                TIPO_HABITACION = 'Habitacion simple',
                TOTAL is GASOLINA + (HABITACIONSIMP+ ALIMENTACION * COMIDA)*DIAS
            )
            ;
            (
                PRESUPUESTO >= GASOLINA + (HABITACIONDOB+ ALIMENTACION * COMIDA)*DIAS,
                PRECIOHABITACION is HABITACIONDOB * DIAS,
                TIPO_HABITACION = 'Habitacion doble',
                TOTAL is GASOLINA + (HABITACIONDOB + ALIMENTACION * COMIDA)*DIAS
            )
        ),
        TOTAL =< PRESUPUESTO
    ), REGISTROS).

encontrar_hoteles2(REGISTROS, ALIMENTACION, DIAS, PRESUPUESTO, VEHICULO) :-