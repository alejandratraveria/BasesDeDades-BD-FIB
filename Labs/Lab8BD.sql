-- Ejercicio 1
/* En aquest exercici es tracta definir els disparadors necessaris sobre empleats2 (veure definició de la base de dades al fitxer adjunt) per mantenir la restricció 
següent:

   Els valors de l'atribut ciutat1 de la taula empleats1 han d'estar inclosos en els valors de ciutat2 de la taula empleats2

Per mantenir la restricció, la idea és que:

En lloc de treure un missatge d'error en cas que s'intenti executar una sentència sobre empleats2 que pugui violar la restricció,
cal executar operacions compensatories per assegurar el compliment de l'asserció. En concret aquestes operacions compensatories ÚNICAMENT podran ser operacions DELETE.

Pel joc de proves que trobareu al fitxer adjunt, i la sentència:
DELETE FROM empleats2 WHERE nemp2=1;
La sentència s'executarà sense cap problema,i l'estat de la base de dades just després ha de ser:

Taula empleats1
	nemp1	nom1	ciutat1
	1	joan	bcn
	2	maria	mad

Taula empleats2
	nemp2	nom2	ciutat2
	2	pere	mad
	3	enric	bcn
*/

CREATE OR REPLACE FUNCTION proc() RETURNS TRIGGER AS $$
BEGIN
    DELETE from empleats1 e1 where not exists (select * from empleats2 where ciutat2 = old.ciutat2) and ciutat1 = old.ciutat2;
        RETURN NULL;
END;
$$LANGUAGE plpgsql;

CREATE TRIGGER t1 after DELETE OR UPDATE OF ciutat2 ON empleats2
FOR EACH row EXECUTE PROCEDURE proc();


-- Ejercicio 2
/* Disposem de la base de dades del fitxer adjunt que gestiona clubs esportius i socis d'aquests clubs.
Cal implementar un procediment emmagatzemat "assignar_individual(nomSoci,nomClub)".

El procediment ha de:
- Enregistrar l'assignació del soci nomSoci al club nomClub, inserint la fila corresponent a la taula Socisclubs.
- Si el club nomClub passa a tenir més de 5 socis, inserir el club a la taula Clubs_amb_mes_de_5_socis.
- El procediment no retorna cap resultat.

Les situacions d'error que cal identificar són les tipificades a la taula missatgesExcepcions.
Quan s'identifiqui una d'aquestes situacions cal generar una excepció:
SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=___; ( 1 .. 5, depenent de l'error)
RAISE EXCEPTION '%',missatge; (missatge ha de ser una variable definida al vostre procediment)

Suposem el joc de proves que trobareu al fitxer adjunt i la sentència
select * from assignar_individual('anna','escacs');
La sentència s'executarà sense cap problema, i l'estat de la base de dades just després ha de ser:

Taula Socisclubs
anna	escacs
joanna	petanca
josefa	petanca
pere	petanca

Taula clubs_amb_mes_de_5_soci
sense cap fila
*/

CREATE OR REPLACE FUNCTION assignar_individual(soci socis.nsoci%type, club clubs.nclub%type) RETURNS void AS $$
DECLARE missatge missatgesExcepcions.texte%type;
    nhomes integer;
    ntotal integer;
BEGIN
    INSERT INTO socisclubs values(soci,club);
    SELECT count(*) INTO nhomes FROM socis NATURAL INNER JOIN socisclubs WHERE sexe = 'M' AND nclub = club;
    SELECT count(*) INTO ntotal FROM socisclubs WHERE nclub = club;
    IF ntotal > 10
    THEN
        SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=1;
        RAISE EXCEPTION '%',missatge;
    ELSE
        IF nhomes > ntotal-nhomes
        THEN
            SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=2;
            RAISE EXCEPTION '%',missatge;
        ELSE
            IF ntotal = 6
            THEN
                  INSERT into clubs_amb_mes_de_5_socis VALUES(club);
            END IF;
        END IF;
    END IF;
 
EXCEPTION
    WHEN raise_exception THEN
        RAISE EXCEPTION '%', missatge;
    WHEN unique_violation THEN
        SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=3;
        RAISE EXCEPTION '%', missatge;
    WHEN foreign_key_violation THEN
        SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=4;
        RAISE EXCEPTION '%', missatge;
    WHEN OTHERS THEN
        SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=5;
        RAISE EXCEPTION '%', missatge; 
END
$$language plpgsql;


