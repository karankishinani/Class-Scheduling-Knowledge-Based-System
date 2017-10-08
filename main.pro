% Copyright

implement main
    open core

%Base de hechos
class facts
    asignatura: (string Nombre).
    profesor: (string Nombre).
    prioridad: (string Nombre, integer Valor).
    dicta: (string Nombre, string Clase).
    turno_asignatura: (string Clase, string Turno).
    disponibilidad_profesor: (string Nombre, string Turno).

clauses
    asignatura("SO").
    asignatura("IS2").
    asignatura("AV").
    asignatura("CL").
    asignatura("SD").
    asignatura("SBC").
    asignatura("CL_LAB").

    profesor("AROSEMENA, MARTIN").
    profesor("YANGUEZ, NILDA").
    profesor("SAMANIEGO, NICOLAS").
    profesor("SALVATIERRA, JORGE").
    profesor("ROJAS, IVAN").
    profesor("SAMANIEGO, EUCLIDES").
    profesor("GARRIDO, GIOVANA").
    profesor("GUTIERREZ, DORIS").
    profesor("MENDOZA, ELIAS").
    profesor("PINZON, ITZOMARA").
    profesor("BELIZ OSORIO, NICHOLAS").
    profesor("DE OBALDIA, ANDRES").

    prioridad("AROSEMENA, MARTIN", 3).
    prioridad("YANGUEZ, NILDA", 7).
    prioridad("SAMANIEGO, NICOLAS", 1).
    prioridad("SALVATIERRA, JORGE", 4).
    prioridad("ROJAS, IVAN", 8).
    prioridad("SAMANIEGO, EUCLIDES", 2).
    prioridad("GARRIDO, GIOVANA", 6).
    prioridad("GUTIERREZ, DORIS", 9).
    prioridad("MENDOZA, ELIAS", 5).
    prioridad("PINZON, ITZOMARA", 3).
    prioridad("BELIZ OSORIO, NICHOLAS", 9).
    prioridad("DE OBALDIA, ANDRES", 10).

    dicta("AROSEMENA, MARTIN", "SO").
    dicta("YANGUEZ, NILDA", "IS2").
    dicta("SAMANIEGO, NICOLAS", "AV").
    dicta("SALVATIERRA, JORGE", "CL").
    dicta("ROJAS, IVAN", "SD").
    dicta("SAMANIEGO, EUCLIDES","SBC").
    dicta("GARRIDO, GIOVANA", "SO").
    dicta("GUTIERREZ, DORIS", "AV").
    dicta("MENDOZA, ELIAS", "CL").
    dicta("PINZON, ITZOMARA", "SD").
    dicta("BELIZ OSORIO, NICHOLAS", "SBC").
    dicta("DE OBALDIA, ANDRES", "CL_LAB").

    turno_asignatura("SO" ,"Diurno").
    turno_asignatura("SO" ,"Tarde").
    turno_asignatura("IS2" ,"Diurno").
    turno_asignatura("IS2" ,"Tarde").
    turno_asignatura("AV" ,"Diurno").
    turno_asignatura("AV" ,"Tarde").
    turno_asignatura("CL" ,"Diurno").
    turno_asignatura("CL" ,"Tarde").
    turno_asignatura("SD" ,"Diurno").
    turno_asignatura("SD", "Tarde").
    turno_asignatura("SBC", "Diurno").
    turno_asignatura("SBC", "Tarde").
    turno_asignatura("CL_LAB", "Diurno").
    turno_asignatura("CL_LAB", "Tarde").

    disponibilidad_profesor("SAMANIEGO, NICOLAS", "Diurno").
    disponibilidad_profesor("SAMANIEGO, EUCLIDES", "Diurno").
    disponibilidad_profesor("AROSEMENA, MARTIN", "Diurno").
    disponibilidad_profesor("PINZON, ITZOMARA", "Tarde").
    disponibilidad_profesor("SALVATIERRA, JORGE", "Diurno").
    disponibilidad_profesor("SALVATIERRA, JORGE", "Tarde").
    disponibilidad_profesor("MENDOZA, ELIAS", "Diurno").
    disponibilidad_profesor("MENDOZA, ELIAS", "Tarde").
    disponibilidad_profesor("GARRIDO, GIOVANA", "Diurno").
    disponibilidad_profesor("GARRIDO, GIOVANA","Tarde").
    disponibilidad_profesor("YANGUEZ, NILDA", "Diurno").
    disponibilidad_profesor("YANGUEZ, NILDA", "Tarde").
    disponibilidad_profesor("ROJAS, IVAN", "Diurno").
    disponibilidad_profesor("GUTIERREZ, DORIS","Diurno").
    disponibilidad_profesor("GUTIERREZ, DORIS","Tarde").
    disponibilidad_profesor("BELIZ OSORIO, NICHOLAS", "Diurno").
    disponibilidad_profesor("BELIZ OSORIO, NICHOLAS", "Tarde").
    disponibilidad_profesor("DE OBALDIA, ANDRES", "Diurno").
    disponibilidad_profesor("DE OBALDIA, ANDRES", "Tarde").

%Base de Reglas
class predicates
asignado: (string Profesor, string Asignatura, string Turno) nondeterm anyflow.
clauses

asignado(Profesor, Asignatura, "Tarde") :- asignatura(Asignatura), profesor(Profesor), turno_asignatura(Asignatura, "Tarde"), disponibilidad_profesor(Profesor, "Tarde"), dicta(Profesor, Asignatura), prioridad(Profesor, A), not((dicta(Profesor2, Asignatura), disponibilidad_profesor(Profesor2, "Tarde"), prioridad(Profesor2, Otro), Otro > A, Profesor <> Profesor2)).

asignado(Profesor, Asignatura, "Diurno") :- asignatura(Asignatura), profesor(Profesor), turno_asignatura(Asignatura, "Diurno"), disponibilidad_profesor(Profesor, "Diurno"), dicta(Profesor, Asignatura), prioridad(Profesor, A), not((dicta(Profesor2, Asignatura), disponibilidad_profesor(Profesor2, "Diurno"), prioridad(Profesor2, Otro), Otro < A, Profesor <> Profesor2)).

%Procedimiento Principal
clauses
    run() :-
        console::init(),
        stdio::nl,
        stdio::writef("---------------------------------\n------ Lista de Profesores ------\nGrupo: 1IL141     Turno: Diurno\n---------------------------------\n"),
        asignado(Profesor1, "SO", "Diurno"),stdio::writef("SISTEMAS OPERATIVOS \t\t\t %\n", Profesor1),
        asignado(Profesor2, "IS2", "Diurno"),stdio::writef("INGENIERÍA DE SOFTWARE II \t\t %\n", Profesor2),
        asignado(Profesor3, "AV", "Diurno"),stdio::writef("ANIMACIÓN DIGITAL Y VIDEO-JUEGOS \t %\n", Profesor3),
        asignado(Profesor4, "CL", "Diurno"),stdio::writef("CIRCUITOS LÓGICOS \t\t\t %\n", Profesor4),
        asignado(Profesor5, "CL_LAB", "Diurno"),stdio::writef("CIRCUITOS LÓGICOS (Laboratorio)\t\t %\n", Profesor5),
        asignado(Profesor6, "SD", "Diurno"),stdio::writef("INGENIERÍA DE SISTEMAS DINÁMICOS\t %\n", Profesor6),
        asignado(Profesor7, "SBC", "Diurno"),stdio::writef("SISTEMAS BASADOS EN EL CONOCIMIENTO \t %\n", Profesor7),
        stdio::nl,
        stdio::writef("---------------------------------\n------ Lista de Profesores ------\nGrupo: 1IL142     Turno: Tarde\n---------------------------------\n"),
        asignado(Profesor8, "SO", "Tarde"),stdio::writef("SISTEMAS OPERATIVOS \t\t\t %\n", Profesor8),
        asignado(Profesor9, "IS2", "Tarde"),stdio::writef("INGENIERÍA DE SOFTWARE II \t\t %\n", Profesor9),
        asignado(Profesor10, "AV", "Tarde"),stdio::writef("ANIMACIÓN DIGITAL Y VIDEO-JUEGOS \t %\n", Profesor10),
        asignado(Profesor11, "CL", "Tarde"),stdio::writef("CIRCUITOS LÓGICOS \t\t\t %\n", Profesor11),
        asignado(Profesor12, "CL_LAB", "Tarde"),stdio::writef("CIRCUITOS LÓGICOS (Laboratorio)\t\t %\n", Profesor12),
        asignado(Profesor13, "SD", "Tarde"),stdio::writef("INGENIERÍA DE SISTEMAS DINÁMICOS\t %\n", Profesor13),
        asignado(Profesor14, "SBC", "Tarde"),stdio::writef("SISTEMAS BASADOS EN EL CONOCIMIENTO \t %\n", Profesor14),
        fail.
    run() :-
        succeed. % place your own code here

end implement main

goal
    console::runUtf8(main::run).