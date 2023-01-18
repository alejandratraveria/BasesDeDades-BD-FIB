-- Ejercicio 1
/* Doneu una sentència SQL per obtenir el número i el nom dels departaments que no tenen cap empleat que visqui a MADRID.
   Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

NUM_DPT		NOM_DPT
3 		    MARKETING
*/

select num_dpt, nom_dpt
from departaments d
where not exists (select * from empleats e
				  where e.ciutat_empl = 'MADRID' and e.num_dpt = d.num_dpt)

-- Ejercicio 2
/* Doneu una sentència SQL per obtenir les ciutats on hi viuen empleats però no hi ha cap departament.
   Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

CIUTAT_EMPL
GIRONA 
*/

select distinct ciutat_empl
from empleats e
where not exists (select * from departaments d
				  where e.ciutat_empl = d.ciutat_dpt)

-- Ejercicio 3
/* Doneu una sentència SQL per obtenir el número i nom dels departaments que tenen dos o més empleats que viuen a ciutats diferents.
   Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

NUM_DPT		NOM_DPT
3 		    MARKETING
*/

select num_dpt, nom_dpt
from departaments d
where 2 <= (select count(*) from empleats e1, empleats e2
		    where e1.ciutat_empl != e2.ciutat_empl and e1.num_dpt = d.num_dpt and 
                  e2.num_dpt = d.num_dpt)

-- Ejercicio 4
/* Tenint en compte l'esquema de la BD que s'adjunta, proposeu una sentència de creació de les taules següents:

    comandes(numComanda, instantComanda, client, encarregat, supervisor) 

    productesComprats(numComanda, producte, quantitat, preu) 


La taula comandes conté les comandes fetes.
La taula productesComprats conté la informació dels productes comprats a les comandes de la taula comandes.

En la creació de les taules cal que tingueu en compte que:
- No hi poden haver dues comandes amb un mateix número de comanda.
- Un client no pot fer dues comandes en una mateix instant.
- L'encarregat és un empleat que ha d'existir necessariament a la base de dades, i que té sempre tota comanda.
- El supervisor és també un empleat de la base de dades i que s'assigna a algunes comandes en certes circumstàncies.
- No hi pot haver dues vegades un mateix producte en una mateixa comanda. Ja que en cas de el client compri més d'una unitat d'un producte en una mateixa comanda 
s'indica en l'atribut quantitat.
- Un producte sempre s'ha comprat en una comanda que ha d'existir necessariament a la base de dades.
- La quantitat de producte comprat en una comanda no pot ser nul, i té com a valor per defecte 1.
- Els atributs numComanda, instantComanda, quantitat i preu són de tipus integer.
- Els atributs client, producte són char(30), i char(20) respectivament.
- L'atribut instantComanda no pot tenir valors nuls.
Respecteu els noms i l'ordre en què apareixen les columnes (fins i tot dins la clau o claus que calgui definir). Tots els noms s'han de posar en majúscules/minúscules 
com surt a l'enunciat.
*/

create table comandes
		(numComanda integer, 
		instantComanda integer not null,
		client char(30),
		encarregat integer not null,
		supervisor integer,
		PRIMARY KEY (numComanda),
		UNIQUE(instantComanda, client),
		FOREIGN KEY (encarregat) REFERENCES EMPLEATS (NUM_EMPL),
		FOREIGN KEY (supervisor) REFERENCES EMPLEATS (NUM_EMPL));
		
create table productesComprats
		(numComanda integer,
		producte char(20),
		quantitat integer not null default 1,
		preu integer,
		PRIMARY KEY (numComanda, producte),
		FOREIGN KEY (numComanda) REFERENCES comandes (numComanda));