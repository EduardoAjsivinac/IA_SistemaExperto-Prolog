% presupuesto.pl
:- consult('comunes.pl').

dias_estadia(VALOR):-
    write('Quiero un viaje de estos dias: '),
    read(VALOR),
    write(''),nl.

alimentacion(VALOR):-
    OPCIONES = [0, 1, 2, 3],
    write('Quiero estos tiempos de comida incluida: (0 - 3): '),
    read(VALOR),
    (
        member(VALOR, OPCIONES)-> true;
        write('Respuesta invalida. Intente nuevamente.'), nl,
        alimentacion(VALOR)
    ).

con_vehiculo(VALOR):-
    write('Tengo vehiculo: Si(1)/No(0): '),
    read(VALOR).

tipo_habitacion(VALOR):-
    write('Mi tipo de habitacion: Doble(1) / Simple (0): '),
    read(VALOR).

menu_presupuesto:-
    write('Escribe lo que tienes pensado en gastar en tu viaje: '),
    read(PRESUPUESTO),
    (
        PRESUPUESTO < 1500 -> menu_economico(PRESUPUESTO);
        PRESUPUESTO > 3000 -> menu_ilimitado(PRESUPUESTO);
        menu_moderado(PRESUPUESTO)
    )
    .

menu_economico(PRESUPUESTO):-
    alimentacion(ALIMENTACION),
    con_vehiculo(VEHICULO),
    dias_estadia(DIAS),
    % encontrar_hoteles(HOTELES, ALIMENTACION, DIAS, PRESUPUESTO, VEHICULO),
    encontrar_hoteles(HOTELES, PRESUPUESTO, _, -1, _, _, VEHICULO, ALIMENTACION, DIAS, _),
    format('~|~tNOMBRE_HOTEL~t~20+~tTIPO_HABITACION~t~25+~tDEPARTAMENTO~t~15+~tGASOLINA~t~10+~tPRECIO_HABITACION~t~20+~tALIMENTACION~t~20+~tTOTAL~t~10+~tDIRECCION~t~n'),
    imprimir_registros(HOTELES)
    .

menu_moderado(PRESUPUESTO):-
    alimentacion(ALIMENTACION),
    con_vehiculo(VEHICULO),
    dias_estadia(DIAS),
    tipo_habitacion(TIPO_HAB),
    encontrar_hoteles(HOTELES, PRESUPUESTO, _, TIPO_HAB, _, _, VEHICULO, ALIMENTACION, DIAS, _),
    format('~|~tNOMBRE_HOTEL~t~20+~tTIPO_HABITACION~t~25+~tDEPARTAMENTO~t~15+~tGASOLINA~t~10+~tPRECIO_HABITACION~t~20+~tALIMENTACION~t~20+~tTOTAL~t~10+~tDIRECCION~t~n'),
    imprimir_registros(HOTELES)
    .

menu_ilimitado(PRESUPUESTO):-
    write('Ilimitado').