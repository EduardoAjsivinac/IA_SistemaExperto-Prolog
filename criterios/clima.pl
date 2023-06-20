% clima.pl
:- consult('comunes.pl').
:- consult('hechos.pl').
:- consult('criterios.pl').

menu_clima:-
    preferencia_clima(CLIMA),
    minimo_estrellas(CALIFICACION),
    tipo_habitacion(TIPO_HAB),
    preferencia_idioma(IDIOMA),
    alimentacion(ALIMENTACION),
    dias_estadia(DIAS),
    encontrar_hoteles(HOTELES, 20000000, CALIFICACION, TIPO_HAB, CLIMA, _, _, ALIMENTACION, DIAS, _),
    format('~|~tNOMBRE_HOTEL~t~20+~tTIPO_HABITACION~t~25+~tDEPARTAMENTO~t~15+~tGASOLINA~t~10+~tPRECIO_HABITACION~t~20+~tALIMENTACION~t~20+~tTOTAL~t~10+~tDIRECCION~t~n'),
    imprimir_registros(HOTELES)
    .
