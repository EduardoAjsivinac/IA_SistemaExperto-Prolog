:- consult('criterios/presupuesto.pl').

main :-
    write('Bienvenido al sistema experto'), nl,
    write('Elige lo que te interese'), nl,
    write('1. Descubre experiencias increibles que se adapten a tu estilo y presupuesto.'), nl,
    write('2. Sumergete en la cultura y el idioma de tus sueños en un destino fascinante.'), nl,
    write('3. Elije el nivel de calidad que te haga sentir bien durante tu viaje.'), nl,
    write('4. Elige el clima perfecto para tu viaje.'), nl,
    write('0. Quizas en otro momento'), nl, nl,
    write('Selecciona la opcion que mas se adapte a tus preferencias: '),
    read(OPCION),
    write(''), nl,
    criterios(OPCION).

criterios(OPCION):- (
        OPCION == 1 -> menu_presupuesto;
        OPCION == 2 -> menu_idioma;
        OPCION == 3 -> menu_calificacion;
        OPCION == 4 -> menu_clima
    ).