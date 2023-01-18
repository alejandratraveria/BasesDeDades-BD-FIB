-- Ejercicio 1
/* Doneu una sentència SQL per obtenir els números i els noms dels departament situats a MADRID, que tenen empleats que guanyen més de 200000.
   Pel joc de proves que trobareu al fitxer adjunt, la sortida ha de ser:

NUM_DPT		NOM_DPT
5		    VENDES
*/

select distinct  d.NUM_DPT, d.NOM_DPT
from DEPARTAMENTS D, EMPLEATS E 
where ciutat_dpt = 'MADRID' and e.sou > 200000 and d.num_dpt = e.num_dpt;


-- Ejercicio 2
/* Doneu una sentència SQL per obtenir el nom del departament on treballa i el nom del projecte on està assignat l'empleat número 2
   Pel joc de proves que trobareu al fitxer adjunt, la sortida seria:

Nom_dpt	     Nom_proj
MARKETING	 IBDVID
*/

select d.nom_dpt, p.nom_proj
from departaments d, projectes p, empleats e
where e.num_empl = 2 and e.num_dpt = d.num_dpt and e.num_proj = p.num_proj;

-- Ejercicio 3
/* Obtenir per cada departament situat a MADRID la mitjana dels sous dels seus empleats. Concretament, cal donar el número de departament, el nom de departament i la
   mitjana del sou.
   Pel joc de proves que trobareu al fitxer adjunt, la sortida ha de ser:

NUM_DPT		NOM_DPT		SOU
5		    VENDES		250000
*/

select d.num_dpt, d.nom_dpt, AVG(e.sou) as SOU
from departaments d, empleats e
where d.ciutat_dpt = 'MADRID' and e.num_dpt = d.num_dpt
group by d.num_dpt;