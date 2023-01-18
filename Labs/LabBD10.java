/* AQUEST EXERCICI NO ES CORREGIRÀ DE MANERA AUTOMÀTICA

PASSOS A SEGUIR

    Importeu el projecte Eclipse que podeu trobar al zip adjunt
    Prepareu el projecte per a ser executat (driver, dades de connexió dins del programa,...)
    Prepareu la base de dades des de DBeaver (fitxers crea.txt, carrega.txt). 


    Apartat 1
        Editeu el programa gestioProfes per tal d'implementar el bloc IMPLEMENTAR CONSULTA
        En aquest bloc cal implemenar en jdbc:
            Una consulta per obtenir el dni i el nom dels professors que tenen els telèfons que hi ha a l'array telfsProf.
            En cas que hi hagi un telèfon que no sigui de cap professor caldrà que surti el número de telèfon i el text "NO TROBAT"
            Cal mostrar amb System.out.println el resultat de la consulta.
        Executeu el programa
        Indiqueu quin és el resultat del select. 


    Apartat 2
        Editeu el programa gestioProfes per tal d'implementar el bloc IMPLEMENTAR CANVI BD
        En aquest bloc cal implemenar en jdbc:
            Per cada despatx del mòdul 'omega' que no té cap assignació amb instant fi null, incrementar la superfície del despatx en 3 metres quadrats.
            Cal mostrar amb System.out.println la quantitat de files modificades.
            En cas que la superfície d'algun dels despatxos passi a ser més gran o igual a 25, no s'ha de modificar cap despatx, i cal mostrar un missatge "Algun despatx 
            passaria a tenir superfície superior o igual a 25".
        Indiqueu quina/es sentències SQL us ha/n fet falta per implementar el canvi, quin és el resultat de l'execució del programa, i com ho heu fet per identificar si 
        es produeix l'excepció. 
*/

// IMPLEMENTAR CONSULTA
       String[] telfsProf = {"3111", "3222", "3333", "4444"};
       PreparedStatement ps = c.prepareStatement("select p.dni, p.nomProf" +
    		   									 "from professors p" +
    		   									 "where p.telefon = ? ;");
      ResultSet rs = null;
      String dni = null;
      String tel = null;
      String nom = null;
      
      
      for (int i = 0; i < telfsProf.length; ++i) {
    	  tel = telfsProf[i];
    	  ps.setString(1, tel);
    	  rs = ps.executeQuery();
    	  if(rs.next()) {
       	      dni = rs.getString("dni");
       	      nom = rs.getString("nomprof");
              System.out.println ("El professor amb dni "+dni+" i nom "+nom);
           }
    	  else {
              System.out.println ("NO TROBAT");
          }
      }

//RESULTAT

	Conexión realizada correctamente.
	
	Canvio de esquema realizado correctamente.
	
	El professor con dni 111                                                y nombre  ruth                                              
	El professor con dni 222                                                y nombre ona                                               
	El professor con dni 333                                                y nombre anna                                              
	NO ENCONTRADO
	Commit y desconnexión realizados correctamente.

--------------------------------------------------------------------------------------------------------------

// IMPLEMENTAR CANVI BD 
 Statement S = c.createStatement();
       int numTuplesModificades = S.executeUpdate ("update despatxos d "+
    		                                       "set superficie = superficie + 3 "+
    		                                       "where d.modul = 'omega' and not exists(select * from assignacions a where a.modul = d.modul 
                                                   and a.numero = d.numero and a.instantFi is NULL)");
       
       System.out.println ("Num de despatxos modificats: "  + numTuplesModificades);
	   
       
	   // Commit y desconnexión de la base de dades
	   c.commit();
	   c.close();
	   System.out.println ("Commit i desconnexio realitzats correctament.");
	
	catch (ClassNotFoundException ce)
	   {
	   System.out.println ("Error al carregar el driver");
	   }	
	catch (SQLException se)
	   {
System.out.println ("Excepcio: ");System.out.println ();
	   System.out.println ("El getSQLState es: " + se.getSQLState());
           System.out.println ();

       if(se.getSQLState().equals("23514")) System.out.println ("Algun despatx passaria a tenir superfície superior o igual a 25");
       else System.out.println ("El getMessage es: " + se.getMessage());	   
    
	   }