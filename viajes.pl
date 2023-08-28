personasConSuenios(gabriel,loteria(5)).
personasConSuenios(gabriel,loteria(9)).
personasConSuenios(gabriel,futbolista(arsenal)).
personasConSuenios(juan,cantante(100000)).
personasConSuenios(macarena,cantante(10000)).


% no se agrega a diego a la base de conocimiento por concepto de universo cerrado.

creencias(gabriel,campanita).
creencias(gabriel,magoDeOz).
creencias(gabriel,cavenaghi).
creencias(juan,conejoDePascua).
creencias(macarena,reyesMagos).
creencias(macarena,magoCapria).
creencias(macarena,campanita).

personaAmbiciosa(Persona):-
  dificultadesDeSusSuenios(Persona,Total),
  Total > 20.

dificultadesDeSusSuenios(Persona,Total):-
    personasConSuenios(Persona,Suenio),
    dificultad(Suenio,DificultadTotal),
    Total is DificultadTotal.

dificultad(loteria(Numeros), Dificultad) :-
  Dificultad is 10 * Numeros.
dificultad(cantante(Ventas), Dificultad) :-
  (Ventas > 500000 -> Dificultad is 6; Dificultad is 4).
dificultad(futbolista(Equipo),Dificultad):-
  (Equipo is arsenal ->Dificultad is 3),
  (Equipo is aldosivi ->Dificultad is 3).
dificultad(futbolista(_),Dificultad):-
  Dificultad is 16.

tieneQuimica(campanita, Persona) :-
  creencias(Persona, campanita),
  personasConSuenios(Persona, Suenio),
  dificultad(Suenio, Dificultad),
  Dificultad < 5.

tieneQuimica(Personaje, Persona) :-
    Personaje \= campanita,
    creencias(Persona, Personaje),
    todasLasCreenciasSonPuras(Persona),
    not(personaAmbiciosa(Persona)).

  % Verificar si todas las creencias son puras (futbolista o cantante < 200.000 discos)
todasLasCreenciasSonPuras(Persona) :-
  creencias(Persona, _),
  forall(creencias(Persona, Creencia), creenciaPura(Creencia)).

creenciaPura(futbolista(Equipo)) :-
    dificultad(futbolista(Equipo), Dificultad),
    Dificultad =< 3.
creenciaPura(cantante(Ventas)) :-
    Ventas =< 200000.


% personajeAlegraAunaPersona(Personaje,Persona):-
%   personasConSuenios(Persona,_),

