-- Ejercicio 1
/* Doneu una seqüència d'operacions d'algebra relacional per obtenir el nom del departament on treballa i el nom del projecte on està assignat l'empleat número 2.
   Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

Nom_dpt		    Nom_proj
MARKETING		IBDVID
*/

A = EMPLEATS(NUM_EMPL = 2)
B = A*DEPARTAMENTS
C = B*PROJECTES
D = C[NOM_DPT,NOM_PROJ]

-- Ejercicio 2
/* Doneu una seqüència d'operacions d'algebra relacional per obtenir el número i nom dels departaments tals que tots els seus empleats viuen a MADRID. El resultat no 
   ha d'incloure aquells departaments que no tenen cap empleat.
   Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

Num_dpt		Nom_dpt
3 		    MARKETING
*/

A = EMPLEATS*DEPARTAMENTS
B = A(CIUTAT_EMPL <> 'MADRID')
C = B[NUM_DPT, NOM_DPT]
D = A[NUM_DPT, NOM_DPT]
E = D-C
F = E[NUM_DPT, NOM_DPT]

-- Ejercicio 3
/* Doneu una seqüència d'operacions de l'àlgebra relacional per obtenir el número i nom dels departaments que tenen dos o més empleats que viuen a ciutats diferents.
   Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

Num_dpt		Nom_dpt
3 		    MARKETING
*/

A = EMPLEATS[NUM_DPT,CIUTAT_EMPL]
B = A{NUM_DPT->NUM, CIUTAT_EMPL->CIUTAT}
C = A[NUM_DPT = NUM, CIUTAT_EMPL<>CIUTAT]B
D = C*DEPARTAMENTS
E = D[NUM_DPT, NOM_DPT]

-- Ejercicio 4
/* Donar una seqüència d'operacions d'àlgebra relacional per obtenir informació sobre els despatxos que només han estat ocupats per professors amb sou igual a 100000. 
   Es vol obtenir el modul i el numero d'aquests despatxos.
   Pel joc de proves que trobareu al fitxer adjunt, la sortida ha de ser:

Modul 	Numero
Omega 	128 
*/

G = ASSIGNACIONS*PROFESSORS
A = G(SOU <> 100000)
C = A[MODUL, Numero]
D = G[MODUL, Numero]
E = D-C
H = G*E
F = H[MODUL, Numero]

