% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).

jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).
% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3).
maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina).
sustanciaProhibida(cocaina).



amigo(maradona, caniggia).
amigo(caniggia, balbo).

amigo(balbo, chamot).
amigo(balbo, pedemonti).

%Agregamos ahora la lista de médicos que atiende a cada jugador
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).

atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).


nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).

nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).

%%%%%%%%%%%% PUNTO 1 %%%%%%%%%%%%%

tomo(passarella,LoQueToma):-not(tomo(maradona,LoQueToma)).

tomo(pedemonti,LoQueToma):- tomo(chamot,LoQueToma).
tomo(pedemonti,LoQueToma):- tomo(maradona,LoQueToma).

%por concept de universo cerrado no agrego un a basualdo.

%%%%%%%%%%%% PUNTO 2 %%%%%%%%%%%%%
puedeSerSuspendido(Jugador):- %% tomo(maradona, sustancia(efedrina)). sustanciaProhibida(efedrina).
tomo(Jugador,LoQueToma),
  forall(tomo(Jugador,LoQueToma),tomaUnaSustanciaProhibida(LoQueToma)).

tomaUnaSustanciaProhibida(sustancia(Tipo)):-sustanciaProhibida(Tipo).


puedeSerSuspendido(Jugador):- %%tomo(chamot, compuesto(cafeVeloz)). composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).
  tomo(Jugador,LoQueToma),
  forall(tomo(Jugador,LoQueToma),compuestoQueTieneUnaSustanciaProhibida(LoQueToma)).

compuestoQueTieneUnaSustanciaProhibida(compuesto(CompuestoPor)):-
composicion(CompuestoPor,Ingredientes),
sustanciaProhibida(Ingrediente),
member(Ingrediente,Ingredientes).

%   % forall(composicion(CompuestoPor,Ingredientes),member(sustanciaProhibida(Ingrediente),Ingredientes)).

puedeSerSuspendido(Jugador):-
  tomo(Jugador,LoQueToma),
  forall(tomo(Jugador,LoQueToma),seExcedeDelLimiteEstablecido(LoQueToma)).

seExcedeDelLimiteEstablecido(producto(Tipo,Cantidad)):-
  maximo(Tipo,CantidadEstablecida),
  Cantidad > CantidadEstablecida. %% este funciona bien.

  %%%%%%%% PUNTO 3 %%%%%%%%

malaInfluencia(Jugador,JugadorInfluenciado):-
  amigo(Jugador,JugadorInfluenciado).
   puedeSerSuspendido(Jugador),
   puedeSerSuspendido(JugadorInfluenciado).
% malaInfluencia(Jugador,JugadorTransitivo):-
%   puedeSerSuspendido(Jugador),
%   puedeSerSuspendido(JugadorInfluenciado),
%   amigo(Jugador,JugadorInfluenciado),
%   amigo(JugadorInfluenciado,JugadorTransitivo).


  %%%%%%%% PUNTO 4 %%%%%%%%
  chanta(Medico):- %%atiende(cureta, pedemonti). atiende(cureta, basualdo).
    atiende(Medico,Jugador), %% atiende(cahe, balbo).
    forall(atiende(Medico,Jugador),puedeSerSuspendido(Jugador)).

  %% atiende(cureta, pedemonti). esta bien que la consola devuelva a cureta, porque cureta tambien atiende a un jugador que 
  %% puede ser suspendido, porque si maradona puede ser suspendido, y maradona esta incluido en lo que pedemonti , entonces es un jugador 
  %% que puede ser suspendido.

  %%%%%%%% PUNTO 5 %%%%%%%%

cuantaFalopaTiene(Jugador,Cantidad):-
  tomo(Jugador,LoQueToma),
  findall(Nivel,nivelDeFalopezDelJugador(LoQueToma,Nivel),ListaDeNiveles),
  sum_list(ListaDeNiveles, TotalidadDeFalopez),
  Cantidad is TotalidadDeFalopez.

%  nivelDeFalopezDelJugador(sustancia(Tipo),Total):-  %%tomo(maradona, sustancia(efedrina)).
%    nivelFalopez(Tipo,Total).

nivelDeFalopezDelJugador(compuesto(Tipo),Total):- %%tomo(maradona, compuesto(cafeVeloz)) , nivelFalopez(omeprazol, 5).
 composicion(Tipo,Ingredientes), %% composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).
 findall(AlteracionEnSangre,nivelFalopez(Tipo,AlteracionEnSangre),TotalidadDeLaAltericion),
 sum_list(TotalidadDeLaAltericion,Total).

%% los productos al tener nivel de alteracion = 0 , entonces no altera en nada a la sangre, entonces por universo cerrado , no lo agrego.