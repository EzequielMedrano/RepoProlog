% define quiénes son amigos de nuestro cliente
amigo(mati). 
amigo(pablo).
amigo(leo).
amigo(fer).
amigo(flor).
amigo(ezequiel).
amigo(marina).

% define quiénes no se pueden ver
noSeBanca(leo, flor).
noSeBanca(pablo, fer).
noSeBanca(fer, leo). 
noSeBanca(flor, fer).

% define cuáles son las comidas y cómo se componen
% functor achura contiene nombre, cantidad de calorías
% functor ensalada contiene nombre, lista de ingredientes
% functor morfi contiene nombre (el morfi es una comida principal)
comida(achura(chori, 200)). % ya sabemos que el chori no es achura
comida(achura(chinchu, 150)).
comida(ensalada(waldorf, [manzana, apio, nuez, mayo])).
comida(ensalada(mixta, [lechuga, tomate, cebolla])).
comida(morfi(vacio)).
comida(morfi(mondiola)).
comida(morfi(asado)).

% relacionamos la comida que se sirvió en cada asado
% cada asado se realizó en una única fecha posible: functor fecha + comida
asado(fecha(22,9,2011), chori).
asado(fecha(15,9,2011), mixta).
asado(fecha(22,9,2011), waldorf).
asado(fecha(15,9,2011), mondiola).
asado(fecha(22,9,2011), vacio).
asado(fecha(15,9,2011), chinchu).
% relacionamos quiénes asistieron a ese asado
asistio(fecha(15,9,2011), flor). 
asistio(fecha(22,9,2011), marina).
asistio(fecha(15,9,2011), pablo).
asistio(fecha(22,9,2011), pablo).
asistio(fecha(15,9,2011), leo).
asistio(fecha(22,9,2011), flor).
asistio(fecha(15,9,2011), fer).
asistio(fecha(22,9,2011), mati).
% definimos qué le gusta a cada persona
leGusta(mati, chori). 
leGusta(fer, mondiola).
leGusta(pablo, asado).
leGusta(mati, vacio).
leGusta(fer, vacio).
leGusta(mati, waldorf).
leGusta(flor, mixta).

% a. A Ezequiel le gusta lo que le gusta a Mati y a Fer.
% b. A Marina le gusta todo lo que le gusta a Flor y la mondiola.
% c. A Leo no le gusta la ensalada waldorf.

leGusta(ezequiel,Comida):-
  leGusta(mati,Comida),
  leGusta(fer,Comida).

leGusta(marina,Comida):-
  leGusta(flor,Comida).

leleGusta(marina,mondiola).

asadoViolento(FechaDelAsado):-
  asistio(FechaDelAsado,Persona),
  % noSeBanca(Persona,PersonaQueNoBanca),
  forall(asistio(FechaDelAsado,Persona),noSeBanca(Persona,_)).
  

%%%3) Definir el predicado calorías/2 que relaciona las calorías de una comida
% a. Las ensaladas tienen una caloría por ingrediente (la mixta, por ejemplo, tiene 3 calorías)
% b. Las achuras definen su propias calorías (el chori tiene 200 calorías)
% c. El morfi tiene siempre 200 calorías, no importa de qué morfi se trate


calorias(Comida,Calorias):-
  comida(achura(Comida,Calorias)).

calorias(Comida,Calorias):-
  comida(ensalada(Comida,Ingredientes)),
  length(Ingredientes, Calorias).

calorias(Comida,200):-
    comida((morfi(Comida))).

asadoFlojito(FechaDeAsado):-
  % asado(FechaDeAsado,Comida),
  asado(FechaDeAsado,_),
  findall(Caloria,(asado(FechaDeAsado,Comida),calorias(Comida,Caloria)),Calorias),
  sum_list(Calorias,Calor),
  Calor<400.
 %%%%%%%%%%%%% PUNTO 5 %%%%%%%%%%%%%%%%%%%%
hablo(fecha(15,09,2011), flor, pablo).
hablo(fecha(22,09,2011), flor, marina).
hablo(fecha(15,09,2011), pablo, leo).
hablo(fecha(22,09,2011), marina, pablo).
hablo(fecha(15,09,2011), leo, fer).
reservado(marina).

chismeDe(FechaDeAsado,PersonaQueCuenta,PersonaQueEscucha):-
      hablo(FechaDeAsado,PersonaQueCuenta,PersonaQueQuiereEscuchar),
      not(PersonaQueQuiereEscuchar\= PersonaQueEscucha),
      findall(PersonasQueEscuchan,hablo(FechaDeAsado,PersonaQueCuenta,PersonasQueEscuchan),PersonasEscuchando),
      cadenaDeChismesDe(PersonaQueQuiereEscuchar,PersonasEscuchando).

cadenaDeChismesDe(PersonaQueQuiereEscuchar , Persona|Personas):-
  
   
 %%%%%%%%%%%%% PUNTO 6 %%%%%%%%%%%%%%%%%%%%

disfruto(Persona,FechaDeAsado):-
  asistio(FechaDeAsado,Persona), %%% esto lo uso porque necesito unificarlas antes de meterlo al findall.
    findall(Comida,(leGusta(Persona,Comida),asistio(FechaDeAsado,Persona)),CantidadDeComidaQueLeGusto),
   length(CantidadDeComidaQueLeGusto,TotalidadDeComida),
   TotalidadDeComida >= 3. 

 %%%%%%%%%%%%% PUNTO 7 %%%%%%%%%%%%%%%%%%%%
asadoRico(Comida):-
  comida(Comida),
  forall(comida(Comida),esUnaComidaRica(Comida)).

esUnaComidaRica(morfi(_)). %%comida(morfi(vacio)).

esUnaComidaRica(ensalada(_,Ingredientes)):-  %% Ingredientes es una lista , pero no necesito ponerlo en una lista
 length(Ingredientes,TotalDeIngredientes),
 TotalDeIngredientes > 3.

 %%comida(achura(chori, 200)).
esUnaComidaRica(achura(chori,_)).
esUnaComidaRica(achura(morci,_)).
 %%con esto descarto todos los tipos de comida que no existen mi universo.
