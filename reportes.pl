% comunes.pl
:- consult('criterios/hechos.pl').



imprimir_filas([]).
imprimir_filas2([]).
imprimir_filas([[NOMBRE, APELLIDO, PARAMETRO]|T]) :-
    format('| ~|~t ~w  ~w ~t~21+ | ~|~t ~w ~t~19+ |~n', [NOMBRE, APELLIDO, PARAMETRO]),
    imprimir_filas(T).

imprimir_filas2([NOMBRE|T]) :-
    format(' ~w~n ', [NOMBRE]),
    imprimir_filas2(T).


reporte1:-
    findall([NOMBRE, APELLIDO, NACIONALIDAD], (
        cliente(IDCLIENTE, NOMBRE, APELLIDO, NACIONALIDAD, _, _, _, 4),
        registro(_, IDCLIENTE, _, _, _, OPINION),
        OPINION > 5
    ), CLIENTES),
    format('| ~|~t NOMBRE  ~t~21+ | ~|~t NACIONALIDAD ~t~19+ |~n'),
    imprimir_filas(CLIENTES)
    .

reporte2:-
    findall([NOMBRE, APELLIDO, ESTADOCIVIL], (
        cliente(IDCLIENTE, NOMBRE, APELLIDO, _,  _, ESTADOCIVIL, _, _),
        registro(_, IDCLIENTE, IDHOTEL, _, _, OPINION),
        hotel(IDHOTEL, _, _, CALIFICACION, _, _, _, _, _),
        CALIFICACION > 4
    ), CLIENTES),
    format('| ~|~t NOMBRE  ~t~21+ | ~|~t ESTADO CIVIL ~t~19+ |~n'),
    imprimir_filas(CLIENTES)
    .


reporte3:-
    findall(NOMBRE, (
        trabajador(ID_TRABAJADOR, NOMBRE, 'Administrador', IDHOTEL),
        hotel(IDHOTEL, _, _, CALIFICACION, _, _, _, _, _),
        CALIFICACION >= 5
    ), NOMBRE),
    imprimir_filas2(NOMBRE)
    .


menu_reportes:-
    write('0. Regresar.'), nl,
    write('1. Reporte 1.'), nl,
    write('2. Reporte 2.'), nl,
    write('3. Reporte 3.'), nl,
    write('4. Reporte 4.'), nl,
    write('5. Reporte 5.'), nl,
    write('6. Reporte 6.'), nl,
    write('7. Reporte 7.'), nl,
    write('8. Reporte 8.'), nl,
    write('9. Reporte 9.'), nl,
    read(OPCION),
    write(''), nl,
    opciones(OPCION).

opciones(OPCION):-
    (
        OPCION == 1 -> reporte1;
        OPCION == 2 -> reporte2;
        OPCION == 3 -> reporte3
    ).

