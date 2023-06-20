% criterios.pl
:- consult('comunes.pl').
:- consult('hechos.pl').

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

minimo_estrellas(VALOR):-
    OPCIONES = [0, 1, 2, 3, 4],
    write('Quiero un hotel de (0 - 4) estrellas: '),
    read(VALOR),
    (
        member(VALOR, OPCIONES)-> true;
        write('Respuesta invalida. Intente nuevamente.'), nl,
        minimo_estrellas(VALOR)
    ).

con_vehiculo(VALOR):-
    write('Tengo vehiculo: Si(1)/No(0): '),
    read(VALOR).

tipo_habitacion(VALOR):-
    write('Mi tipo de habitacion: Doble(1) / Simple (0): '),
    read(VALOR).

preferencia_clima(VALOR):-
    write('La preferencia del clima es: '), nl,
    findall([CODIGO, NOMBRE], clima(CODIGO, NOMBRE), RESULTADO),
    imprimir_hecho(RESULTADO),
    write('0. Sin preferencia'),
    read(VALOR).

preferencia_idioma(VALOR):-
    write('La preferencia del idioma es: '), nl,
    findall([CODIGO, NOMBRE], idioma(CODIGO, NOMBRE), RESULTADO),
    imprimir_hecho(RESULTADO),
    read(VALOR).

con_distancia(VALOR):-
    write('Escriba la distancia: '),
    read(VALOR),
    write(''), nl.