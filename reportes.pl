% comunes.pl
:- consult('criterios/hechos.pl').





imprimir_filas1([]).
imprimir_filas1([NOMBRE|T]) :-
    format(' ~w~n ', [NOMBRE]),
    imprimir_filas1(T).

imprimir_filas2([]).
imprimir_filas2([[PARAMETRO1, PARAMETRO2]|T]) :-
    format('| ~|~t ~w ~t~21+ | ~|~t ~w ~t~19+ |~n', [PARAMETRO1, PARAMETRO2]),
    imprimir_filas2(T).

imprimir_filas3([]).
imprimir_filas3([[NOMBRE, APELLIDO, PARAMETRO]|T]) :-
    format('| ~|~t ~w  ~w ~t~21+ | ~|~t ~w ~t~19+ |~n', [NOMBRE, APELLIDO, PARAMETRO]),
    imprimir_filas3(T).


imprimir_filas4([]).
imprimir_filas4([[NOMBRE_HOTEL, DEPARTAMENTO, IDIOMA, NOMBRE_CLIENTE, APELLIDO_CLIENTE]|T]) :-
    format('| ~|~t ~w  ~w ~t~21+ | ~|~t ~w ~t~19+ |~t ~w ~t~19+ |~t ~w ~t~19+ |~n', [NOMBRE_CLIENTE, APELLIDO_CLIENTE, NOMBRE_HOTEL, DEPARTAMENTO, IDIOMA]),
    imprimir_filas4(T).



reporte1:-
    findall([NOMBRE, APELLIDO, NACIONALIDAD], (
        cliente(IDCLIENTE, NOMBRE, APELLIDO, NACIONALIDAD, _, _, _, 4),
        registro(_, IDCLIENTE, _, _, _, OPINION),
        OPINION > 5
    ), CLIENTES),
    format('| ~|~t NOMBRE  ~t~21+ | ~|~t NACIONALIDAD ~t~19+ |~n'),
    imprimir_filas3(CLIENTES)
    .

reporte2:-
    findall([NOMBRE, APELLIDO, ESTADOCIVIL], (
        cliente(IDCLIENTE, NOMBRE, APELLIDO, _,  _, ESTADOCIVIL, _, _),
        registro(_, IDCLIENTE, IDHOTEL, _, _, OPINION),
        hotel(IDHOTEL, _, _, CALIFICACION, _, _, _, _, _),
        CALIFICACION > 4
    ), CLIENTES),
    format('| ~|~t NOMBRE  ~t~21+ | ~|~t ESTADO CIVIL ~t~19+ |~n'),
    imprimir_filas3(CLIENTES)
    .


reporte3:-
    findall(NOMBRE, (
        trabajador(ID_TRABAJADOR, NOMBRE, 'Administrador', IDHOTEL),
        hotel(IDHOTEL, _, _, CALIFICACION, _, _, _, _, _),
        CALIFICACION >= 5
    ), NOMBRE),
    imprimir_filas1(NOMBRE)
    .

reporte4 :-
    write('Np disponible').

reporte5:-
    findall([NOMBRE, APELLIDO, NACIONALIDAD],(
            departamento(ID_DEPTO, _, _,'espanol', _, _),
            hotel(ID_HOTEL, _, _, _, _, _, _, ID_DEPTO,_),
            registro(_, IDCLIENTE, ID_HOTEL, _, _, _),
            cliente(IDCLIENTE, NOMBRE, APELLIDO, NACIONALIDAD, _, _, _, _),
            NACIONALIDAD \= 'Guatemala'
        ), REGISTROS),
    imprimir_filas3(REGISTROS)
    .

reporte6:-
    findall([NOMBRE_HOTEL, DEPARTAMENTO, IDIOMA, NOMBRE_CLIENTE, APELLIDO_CLIENTE],(
            % con opinionesmayores o igual que 7 y estadías mayores o igual a 3 días
            registro(_, IDCLIENTE, ID_HOTEL, _, ESTADIA, OPINION),
            ESTADIA >= 3,
            OPINION >= 7,
            cliente(IDCLIENTE, NOMBRE_CLIENTE, APELLIDO_CLIENTE, _, _, _, _, _),
            hotel(ID_HOTEL, NOMBRE_HOTEL, _, _, _, _, _, ID_DEPTO,_),
            departamento(ID_DEPTO, DEPARTAMENTO, _, IDIOMA, _, _)
        ), REGISTROS),
    imprimir_filas4(REGISTROS)
    .

reporte7:-
    findall([NACIONALIDAD, NOMBRE_HOTEL],(
            cliente(IDCLIENTE, _, _, NACIONALIDAD, _, _, _, _),
            NACIONALIDAD \= 'Guatemala',
            registro(_, IDCLIENTE, ID_HOTEL, _, ESTADIA, _),
            ESTADIA < 2,
            hotel(ID_HOTEL, NOMBRE_HOTEL, _, _, _, _, _, ID_DEPTO,_),
            departamento(ID_DEPTO, DEPARTAMENTO, _, IDIOMA, _, _),
            IDIOMA == 'ingles'
        ), REGISTROS),
    imprimir_filas2(REGISTROS)
    .

reporte8:-
    findall(NACIONALIDAD,(
            departamento(ID_DEPTO, 'Peten', _, _, _, _),
            hotel(ID_HOTEL, _, _, _, _, _, _, ID_DEPTO,_),
            registro(_, IDCLIENTE, ID_HOTEL, _, _, _),
            cliente(IDCLIENTE, _, _, NACIONALIDAD, _, _, _, _)
        ), REGISTROS),
    imprimir_filas1(REGISTROS)
    .

reporte9:-
    findall([NOMBRE_HOTEL, DIRECCION],(
            cliente(IDCLIENTE, _, _, _, _, 'Casado', _, _),
            registro(_, IDCLIENTE, ID_HOTEL, _, ESTADIA, OPINION),
            OPINION > 6,
            ESTADIA >= 3,
            hotel(ID_HOTEL, NOMBRE_HOTEL, DIRECCION, _, _, _, _, _,_)
            
        ), REGISTROS),
    imprimir_filas2(REGISTROS)
    .

menu_reportes:-
    nl,
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
    opciones(OPCION),
    (
        OPCION > 0 -> menu_reportes;
        write('')
    ).

opciones(OPCION):-
    (
        OPCION == 1 -> reporte1;
        OPCION == 2 -> reporte2;
        OPCION == 3 -> reporte3;
        OPCION == 4 -> reporte4;
        OPCION == 5 -> reporte5;
        OPCION == 6 -> reporte6;
        OPCION == 7 -> reporte7;
        OPCION == 8 -> reporte8;
        OPCION == 9 -> reporte9;
        OPCION == 0 -> write('')
    ).

