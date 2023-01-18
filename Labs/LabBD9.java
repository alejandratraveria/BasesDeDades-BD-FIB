/* AQUEST EXERCICI NO ES CORREGIRÀ DE MANERA AUTOMÀTICA

PASSOS A SEGUIR

    Apartat 1
        Obriu Guia de Programació en JDBC. Repasseu la informació que se us ofereix en aquesta guia.
        Executeu el programa Eclipse
        Importeu el projecte Eclipse que podeu trobar al zip adjunt
        Descarregueu el driver JDBC de la pàgina del curs a una carpeta de l'ordinador.
        Copieu el driver de JDBC a la carpeta "libraries" del projecte Eclipse (es pot fer simplement arrossegant des d'una carpeta on el tingueu).
        Repasseu el contingut de les carpetes i fitxers que es poden trobar dins del projecte Eclipse.
        Prepareu la base de dades des de DBeaver Executeu les sentències SQL de creació de taules (fitxer crea.txt) i càrrega de files a les taules (fitxer carrega.txt).
        Editeu codi del programa gestioProfes.java (carpeta "src")
            Poseu el nom de la vostra base de dades (LaVostraBD)
            Poseu l'esquema on estan les taules (ElVostreEsquema).
            Poseu el vostre username de connexió a la base de dades (ElVostreUsername, ElVostrePassword).
            Comproveu que el programa no té errors 

    Apartat 2
        Execució 1
            Abans d'executar el programa, des del DBeaver feu select * from Professors
            Mireu el codi del programa gestioProfes per veure què fa sobre la taula Professors.
            Compileu el programa.
            Executeu el programa.
            Des del DBeaver torneu a fer select * from Professors
            Quin ha estat l'efecte de l'execució del programa sobre la taula Professors? Perquè?

        Execució 2
            Editeu el programa. Substituiu la sentència "rollback" per una sentència "commit".
            Compileu el programa.
            Executeu el programa.
            Des del DBeaver feu torneu a fer select * from Professors
            Quin ha estat l'efecte de l'execució del programa sobre la taula Professors? Perquè? 

        Execució 3
            Executeu una altra vegada el programa.
            Quina excepció es produeix?
            Quin ha estat l'efecte de l'execució del programa sobre la taula Professors? Perquè?
            Com podrieu fer (sense afegir accessos a la base de dades des del programa) que quan es dongui aquesta excepció en lloc del missatge obtingut surti 
                "El professor ja existeix"?
            Editeu el programa i afegiu la implementació d'aquesta excepció. 

        Execució 4
            Esborreu la fila que el programa insereix, des del DBeaver.
            Editeu el programa per tal d'implementar el bloc IMPLEMENTAR
            En aquest bloc cal implemenar en jdbc:
                Una consulta per obtenir el dni i el nom dels professors que tenen el telèfon amb un número inferior al número de la variable buscaTelf
                En cas que no hi hagi cap professor que tingui un telèfon amb número inferior al indicat a la variable, treure un missatge "NO TROBAT"
                Cal mostrar amb System.out.println el resultat de la consulta.
            Executeu una altra vegada el programa
            Indiqueu quin és el resultat del select.
            Doneu el codi dela part del programa des del bloc IMPLEMENTAR fins al final. 
*/

 // Execució 1: 
 // No es produeix la inserció de la nina degut a la senténcia "rollback".

// Execució 2: 
// En aquest cas, el canvi de la senténcia "rollback" a la senténcia "commit" fa que es confirmin els canvis i, en aquest cas, es produirà l'inserció de la nina amb èxit. 

// Execució 3: 
// Es pot fer una "raise exception" especifica per aquesta taula a la nostra base de dades SQL. Això provocarà que el getmessage() retorni el string "El professor 
// ja existeix" si causem una "unique violation" a la taula professors.

catch (SQLException se) {
           if (se.getSQLState().equals("23505")) 
                          System.out.println ("El professor ja existeix");
           else  {
                  System.out.println ("Excepcio: ");System.out.println ();
                           System.out.println ("El getSQLState es: " + se.getSQLState());
                                    System.out.println ();
                  System.out.println ("El getMessage es: " + se.getMessage());
            }
}

// Execució 4: 

       String buscaTelf="3334";
       int quants=0;
       String dni, nom, telf;

       Statement st = c.createStatement();

       ResultSet r = st.executeQuery ("select * "+
                                       "from Professors "+
                                       "where telefon < '"+buscaTelf+"';");
        while (r.next()) {
               quants = quants + 1; 
               dni = r.getString("dni");
               nom = r.getString("nomprof");
               telf = r.getString("telefon");
               System.out.print ("El professor amb dni "+dni+" , nom "+nom+" i telf "+telf); }

        if (quants == 0) {
               System.out.println ("No hi ha cap professor sense telfon menor a telefon");
        }
        else {System.out.println("En total n'hi ha " + quants);
}

 c.commit();
 c.close();