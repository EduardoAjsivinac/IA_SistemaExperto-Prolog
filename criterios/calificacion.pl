% calificacion.pl
:- consult('comunes.pl').
:- consult('hechos.pl').
:- consult('criterios.pl').

menu_calificacion:-
    minimo_estrellas(CALIFICACION),
    tipo_habitacion(TIPO_HAB),
    dias_estadia(DIAS),
    alimentacion(ALIMENTACION),
    con_vehiculo(VEHICULO),
    con_distancia(DISTANCIA),
    encontrar_hoteles(HOTELES, 20000000, CALIFICACION, -1, -1, DISTANCIA, VEHICULO, ALIMENTACION, DIAS, IDIOMA),
    format('~|~tNOMBRE_HOTEL~t~20+~tTIPO_HABITACION~t~25+~tDEPARTAMENTO~t~15+~tGASOLINA~t~10+~tPRECIO_HABITACION~t~20+~tALIMENTACION~t~20+~tTOTAL~t~10+~tDIRECCION~t~n'),
    imprimir_registros(HOTELES)
    .
