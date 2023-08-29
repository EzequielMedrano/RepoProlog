
comercioAdherido(iguazu, grandHotelIguazu).%p para excursion
comercioAdherido(iguazu, gargantaDelDiabloTour).
comercioAdherido(bariloche, aerolineas).
comercioAdherido(iguazu, aerolineas).

factura(estanislao, hotel(grandHotelIguazu, 2000)).
factura(antonieta, excursion(gargantaDelDiabloTour, 5000, 4)).
factura(antonieta, vuelo(1515, antonietaPerez)).

valorMaximoHotel(5000).

% los vuelos que se hicieron.
registroVuelo(1515, iguazu, aerolineas, 
  [estanislaoGarcia,antonietaPerez, danielIto]
  , 10000).


%TIPO DE FACTURA = HOTEL O EXCURSION O VUELO
montoADevolver(Persona,Monto):-
  factura(Persona,TipoDeFactura),
  facturaValida(TipoDeFactura), 
  findall(MontoDeLaFactura,(montoPagado(Persona,MontoDeLaFactura),ciudadesDistintasEnLasQueEstuvo(Persona,MontoDeLaFactura))
  ,sum_list(MontoDeLaFactura, Monto)).

montoADevolver(Persona,Monto):-
  factura(Persona,TipoDeFactura),
  not(facturaValida(TipoDeFactura)),
  Monto is Monto - 15000.
  

montoPagado(hotel(_,Total)).
montoPagado(excursion(_,Total,_)).
montoPagado(vuelo(IdDeVuelo,_),TotalDeVuelo):-
  (registroVuelo(IdDeVuelo,_,_,[],Total)),
  TotalDeVuelo is Total.



ciudadesDistintasEnLasQueEstuvo(hotel(Sitio,_),MontoDeLaFactura):-
  findall(Ciudad,comercioAdherido(Ciudad,Sitio),Ciudades),
  length(Ciudades,Total),
  MontoDeLaFactura is Total * 1000.

ciudadesDistintasEnLasQueEstuvo(excursion(Sitio,_,_),MontoDeLaFactura):-
  findall(Ciudad,comercioAdherido(Ciudad,Sitio),Ciudades),
  length(Ciudades,Total),
  MontoDeLaFactura is Total * 1000.

facturaValida(hotel(grandHotelIguazu(Precio))):-
  Precio =< 5000.
facturaValida(vuelo(_,NombreCompleto)):-
  length(NombreCompleto, Valor),
  Valor > 9.
facturaValida(excursion(NombreDeLaExcursion,_,_)):-
  comercioAdherido(_,NombreDeLaExcursion).
  

