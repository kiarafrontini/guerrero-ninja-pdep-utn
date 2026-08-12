% persona(Nombre, Apertura, Fuerza)
persona(ada, 166, 60).
persona(beto, 166, 65).
persona(connie, 154, 50).
persona(dana, 180, 70).
persona(esteban, 193, 40).

/*
parte A

1. 
persona(_, 180, _).
true 

2.
persona(dana, _, Fuerza).
Fuerza = 70.

3. 
persona(Quien, 166, _).
Quien = ada ;
Quien = beto ;
false.

4. 
persona(milhouse, _, 33).
false.

5. 
persona(connie, 154, _).
true.
*/

% parte B

/*algunoSuperaA(Persona):-
    persona(Persona, _, Fuerza),
    findall(Otro, (persona(Otro,_,FuerzaOtro), FuerzaOtro > Fuerza), Otros),
    length(Otros, Longitud),
    Longitud > 0.

1. 
a. Verdadero. el predicado busca a todos los que cumplan la condicion que fuerza sea mayor,
los pone en una lista y verfica que la longitud sea mayor a 0 (que hay alguien)
b. si, es inversible. liga a persona con el predicado persona
c. si, se podria delegar y lograr mejor declaratividad
*/

%2. 
algunoSuperaA(Persona):-
    persona(Persona, _, Fuerza1),
    persona(_, _, Fuerza2),
    Fuerza2 > Fuerza1. 

% parte C
obstaculo(aro(7), 14).
obstaculo(aro(15), 70).
obstaculo(barril(seco, 80), 10).
obstaculo(pared(5), 90).
obstaculo(aro(15), 10).
obstaculo(barril(humedo, 50), 26).
obstaculo(aro(2), 27).

laMetaEstaEn1(Posicion):-
  obstaculo(_, Posicion),
  findall(Obs, (obstaculo(Obs, Pos), Pos > Posicion), Obstaculos),
  length(Obstaculos, 0).

laMetaEstaEn2(Posicion):-
  forall(obstaculo(_, Pos), Posicion >= Pos).

/* 
1. el primer predicado busca alguna posicion que sea mayor que la que
se ingresa, y las pone en una lista. si la lista es 0, es porque no existe,
por lo que se encontro la posicion de la meta que es la mas grande. 
 
 el segundo predicado en cambio, busca todas las posiciones que cumplan que
 sean mayor o igual a la ingresada y se queda con la mas grande. 

laMetaEstaEn1(14).
false.

laMetaEstaEn2(14).
false.

laMetaEstaEn1(A).
A = 90 .

laMetaEstaEn2(A).
no es inversible, por lo que rompe. 

*/

/* 2.

posicionMeta(Posicion):-
    obstaculo(_, Posicion),
    obstaculo(_, OtraPosicion),
    Posicion > OtraPosicion. 

metaEn(Posicion):-
    posicionMeta(Posicion),

parte D

1. 
a. Falso. si agrego un obstaculo mas deberia agregar otra condicion
en un nuevo predicado de puede dar un paso y con las caracteristicas
del nuevo obstaculo
b. 
c. si, ssse repite mucha logica con cada tipo de ibstaculo distinto

*/

% 2.
dificultad(aro(Grosor), Dificultad):-
    Dificultad is Grosor.

dificultad(pared(Altura), Dificultad):-
    Dificultad is Altura * 3.

dificultad(barril(humedo, Diametro), Dificultad):-
    Dificultad is (50 * Diametro) / 10.

dificultad(barril(seco, Diametro), Dificultad):-
    Dificultad is (30 * Diametro) / 10.

puedeSuperarObs(Persona, PFinal):-
    obstaculo(Obstaculo, PFinal),
    persona(Persona, _, Fuerza),
    dificultad(Obstaculo, Dificultad),
    Fuerza > Dificultad.

puedeDarUnPaso(Persona, PInicial, PFinal):-
    persona(Persona, Apertura, _),
    puedeSuperarObs(Persona, PFinal),
    Apertura > PFinal - PInicial.
