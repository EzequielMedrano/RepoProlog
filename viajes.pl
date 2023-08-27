atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).

% lucas atiende los martes de 10 a 20
atiende(lucas, martes, 10, 20).

% juanC atiende los sábados y domingos de 18 a 22.
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).

% juanFdS atiende los jueves de 10 a 20 y los viernes de 12 a 20.
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).

% leoC atiende los lunes y los miércoles de 14 a 18.
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).

% martu atiende los miércoles de 23 a 24.
atiende(martu, miercoles, 23, 24).

% Definir la relación para asociar cada persona con el rango horario que cumple, e incorporar las siguientes cláusulas:
% - vale atiende los mismos días y horarios que dodain y juanC.
atiende(vale, Dia, HorarioInicio, HorarioFinal):-atiende(dodain, Dia, HorarioInicio, HorarioFinal).
atiende(vale, Dia, HorarioInicio, HorarioFinal):-atiende(juanC, Dia, HorarioInicio, HorarioFinal).

% - nadie hace el mismo horario que leoC
% por principio de universo cerrado, no agregamos a la base de conocimiento aquello que no tiene sentido agregar
% - maiu está pensando si hace el horario de 0 a 8 los martes y miércoles
% por principio de universo cerrado, lo desconocido se presume falso
% 
% En caso de no ser necesario hacer nada, explique qué concepto teórico está relacionado y justifique su respuesta.

% Punto 2: quién atiende el kiosko... (2 puntos)
% Definir un predicado que permita relacionar un día y hora con una persona, en la que dicha persona atiende el
% kiosko. Algunos ejemplos:
% si preguntamos quién atiende los lunes a las 14, son dodain, leoC y vale
% si preguntamos quién atiende los sábados a las 18, son juanC y vale
% si preguntamos si juanFdS atiende los jueves a las 11, nos debe decir que sí.
% si preguntamos qué días a las 10 atiende vale, nos debe decir los lunes, miércoles y viernes.
%
% El predicado debe ser inversible para relacionar personas y días.
quienAtiende(Persona, Dia, HorarioPuntual):-
  atiende(Persona, Dia, HorarioInicio, HorarioFinal),
  between(HorarioInicio, HorarioFinal, HorarioPuntual).


foreverAlone(Persona,Dia,HorarioPuntual):-
  quienAtiende(Persona, Dia, HorarioPuntual),
  not((quienAtiende(OtraPersona, Dia, HorarioPuntual), Persona \= OtraPersona)).

posibilidadesAtencion(Dia, Personas):-
    findall(Persona, distinct(Persona, quienAtiende(Persona, Dia, _)), PersonasPosibles),
    combinar(PersonasPosibles, Personas).

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).


