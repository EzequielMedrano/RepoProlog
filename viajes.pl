% Viajes

% Tipos de transporte

viajes(charly,avion).  % no defini que charly no viaja en tren, porque eso no me aporta informacion sobre en que viaja charly.
viajes(vilmaPalma,auto). % no le agregue vilmaPalma ni el color ni la hora porque no es algo que se use despues.
viajes(arbol,trenes). % arbol tiene 3 tipos de transportes , y los defini en hechos distintos.
viajes(arbol,camiones).
viajes(arbol,tractor).
viajes(zapatoVeloz,tractor). % no defini el color del tractor, porque no es algo que se use despues.
%viajes(indio,auto). como no tiene a donde ir , entonces por concepto de universo cerrado, todo lo desconocido es falso
%viajes(manuChao,_).como no se marca en que transporte va  , entonces por concepto de universo cerrado, todo lo desconocido es falso
viajes(virus,taxi). % basicamente defini el transporte como lo marcaba el enunciado, obviando 'hotel Savoy y bailamos' porque no es algo que
%se use despues.


% Chetos

chetosViajando(PersonaNueva):-viajes(PersonaNueva,taxi).
chetosViajando(PersonaNueva):-viajes(PersonaNueva,avion).


%Gustos similares

personasDistintas(Persona1,Persona2):-Persona1 \= Persona2.

tienenGustosSimilares(Persona1,Persona2):-personasDistintas(Persona1,Persona2),viajes(Persona1,Transporte),
viajes(Persona2,Transporte).
