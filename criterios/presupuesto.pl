% presupuesto.pl
:- consult('comunes.pl').
:- consult('hechos.pl').
:- consult('criterios.pl').

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
    encontrar_hoteles(HOTELES, PRESUPUESTO, 0, -1, 0, _, VEHICULO, ALIMENTACION, DIAS, _),
    format('~|~tNOMBRE_HOTEL~t~20+~tTIPO_HABITACION~t~25+~tDEPARTAMENTO~t~15+~tGASOLINA~t~10+~tPRECIO_HABITACION~t~20+~tALIMENTACION~t~20+~tTOTAL~t~10+~tDIRECCION~t~n'),
    imprimir_registros(HOTELES)
    .

menu_moderado(PRESUPUESTO):-
    alimentacion(ALIMENTACION),
    con_vehiculo(VEHICULO),
    dias_estadia(DIAS),
    tipo_habitacion(TIPO_HAB),
    preferencia_clima(CLIMA),
    encontrar_hoteles(HOTELES, PRESUPUESTO, 0, TIPO_HAB, CLIMA, _, VEHICULO, ALIMENTACION, DIAS, _),
    format('~|~tNOMBRE_HOTEL~t~20+~tTIPO_HABITACION~t~25+~tDEPARTAMENTO~t~15+~tGASOLINA~t~10+~tPRECIO_HABITACION~t~20+~tALIMENTACION~t~20+~tTOTAL~t~10+~tDIRECCION~t~n'),
    imprimir_registros(HOTELES)
    .

menu_ilimitado(PRESUPUESTO):-
    alimentacion(ALIMENTACION),
    con_vehiculo(VEHICULO),
    dias_estadia(DIAS),
    preferencia_clima(CLIMA),
    minimo_estrellas(CALIFICACION),
    encontrar_hoteles(HOTELES, PRESUPUESTO, CALIFICACION, 1, CLIMA, _, VEHICULO, ALIMENTACION, DIAS, _),
    format('~|~tNOMBRE_HOTEL~t~20+~tTIPO_HABITACION~t~25+~tDEPARTAMENTO~t~15+~tGASOLINA~t~10+~tPRECIO_HABITACION~t~20+~tALIMENTACION~t~20+~tTOTAL~t~10+~tDIRECCION~t~n'),
    imprimir_registros(HOTELES)
    .
