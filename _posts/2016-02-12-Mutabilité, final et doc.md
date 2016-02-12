*Éléments de programmation objet*
===================================

Mutabilité
==========

Objets non mutables-------------------Il est souvent plus simple d'avoir des objets dont le contenu ne change pas une fois l'objet créé.On appelle un tel objet *non mutable*.Conception d'un objet non mutable---------------------------------La programmation permet aisément de concevoir des objets non mutables.- Les champs sont de toutes façons privés- On ne met que des accesseurs- On ne retourne aucune référence vers les champs dont le type est mutable  - Soit on donne accès aux méthodes du champ (méthodes déléguées)  - Soit on retourne une copie profonde du champ.Méthodes déléguées------------------Une *méthode déléguée* est une méthode qui ne fait qu'en appeler une autre d'un champ.Exemple :	public class Voiture {	  private String marque;	  private String couleur;	  private String modele;	  private Immatriculation immatriculation;	  	  public String immatriculation() {	    return immatriculation.toString(); 	  } 	   	  ...	}Dans cet exemple, le calcul de la chaine de caractères représentant l'immatriculation du véhicule est *délégué* au champ ˋimmatriculation`.Copie profonde--------------Une copie superficielle (*shallow copy*) d'un objet est une nouvelle instance dont les champs ont les mêmes valeurs:- pour les champs de type primitif, la valeur est copiée- pour les champs de type objet, seule la référence est copiée. L'objet est donc partagé entre l'original et sa copieUn copie profonde d'un objet effectue une copie profonde des champs de type objet.Exemple :	public class Point {	  private double x;	  private double y;	  	  public Point copie() {	    return new Point(this.x,this.y);	  }	  ...	}

 
	public class Ligne {	  private Point p1;	  private Point p2;	  	  private Ligne copieSuperficielle() {	    return new Ligne(this.p1,this.p2);	  }	  public Ligne copieProfonde() {	    return new Ligne(this.p1.copie(),this.p2.copie());	  }	  ...	}

 	public class BiLigne {	  private Ligne l1;	  private Ligne l2;	  	  public BiLigne copieProfonde() {	    return new BiLigne(this.l1.copieProfonde(),
	                       this.l2.copieProfonde());	  }	}Retour sur la mutabilité------------------------Pour avoir une classe `Point` mutable mais une classe ligne `Ligne` non mutable :    public class Point {      private double x;      private double y;            public Point(double x, double y) {        this.x = x;        this.y = y;      }      public void setX(double x) {        this.x = x;      }      public void setY(double y) {        this.y = y;      }      public double getX() {        return x;      }            public double getY() {        return y;      }    }**Version avec délégation** :        public class Ligne {      private Point p1;      private Point p2;	  
	   public Ligne(double p1x, double p1y, double p2x, double p2y) {
	     this.p1 = new Point(p1x,p1y);
	     this.p2 = new Point(p2x,p2y);
	   }
	        public double getP1X() {        return p1.getX();      }            public double getP2X() {        return p2.getX();      }      public double getP1Y() {        return p1.getY();      }            public double getP2Y() {        return p2.getY();      }            private Point[] getPoints() {        return new Point[]{p1,p2};      }    }Si la méthode `getPoints` était publique, l'objet deviendrait mutable avec, par exemple :    ligne.getPoints()[0].setX(12)qui met à 12 l'abscisse du premier point.**Version avec copie** (appelée copie défensive) :    public class Ligne {      private Point p1;      private Point p2;	  
	   public Ligne(Point p1, Point p2) {
	     this.p1 = new Point(p1.getX(),p1.getY());
	     this.p2 = new Point(p2.getX(),p2.getY());
	   }
	        public Point getP1() {        return new Point(p1.getX(),p1.getY());      }            public Point getP2() {        return new Point(p2.getX(),p2.getY());      }    }Si l'on ne faisait de copie dans le constructeur, on pourrait faire :

    Point p = new Point(1,2);
    Point q = new Point(3,4);
    Ligne l = new Ligne(p,q);
    p.setX(4);

voire

    Ligne l2 = new Ligne(p,p);
Mot-clef final==============

À assignation unique
--------------------- Afin d'aider la machine virtuelle à optimiser le programme, on peut déclarer un champ `final`- Cela signifie que ce champ est *à assignation unique*- Une fois affecté une première fois, on ne peut plus le changer- Cette affectation **doit** avoir lieu dans le constructeurDans un premier temps, on déclare toujours un champ `final` sauf si l'on est sûr de devoir le modifier**Attention, le mot-clef `final` n'assure pas toujours la non mutabilité d'un objet s'il est mis sur un champ de type objet mutable**.Constantes-----------En déclarant un champ `static` et `final`, on obtient une constante. Elle doit être initialisée au moment de sa déclaration (ou dans un bloc d'initialisation `static` si c'est vraiment nécessaire).Exemple :    private static final long MAX = 100000;    private static final String NAME = "MyBestSoft v1.2";    private static final String NAME_SEPARATOR = "::";Javadoc
=======

Java possède un système de génération automatique de documentation qui expose les parties (publiques par défaut) des classes.

Exemple :

    public class Identity {
      private String firstName;
      private String lastName;
      
      public Identity(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
      }
      
      public String displayName(boolean firstNameFirst) {
        if (firstNameFirst)
          return this.firstName+" "+this.lastName;
        else
          return this.lastName+" "+this.firstName;
      }
      
      public String toString() {
        return displayName(true);
      }
    }

  
      
    public class Student {
      private Identity identity;
      private int yearOfBirth;
      private Degree degree;
      private String degreeName;
    
      public Student(Identity identity, int yearOfBirth) {
        this.identity = identity;
        this.yearOfBirth = yearOfBirth;
      }

      public String toString() {
        return identity.displayName(false)+", "+age()+" years old";
      }
      
      public int age() {
        return new GregorianCalendar().get(Calendar.YEAR)-yearOfBirth;
      }
      
      public void assignDegree(Degree degree, String degreeName) {
        this.degree = degree;
        this.degreeName = degreeName;
      }
      
      public Degree getDegree() {
        return degree;
      }
      
      public String getDegreeName() {
        return degreeName;
      }
    }

 
    
    public enum Degree {
      LICENSE, MASTER
    }La javadoc est créée avec la ligne de commande :

    javadoc -link https://docs.oracle.com/javase/8/docs/api -d doc Degree.java Identity.java Student.javaLe résultat est le [suivant](/l2epo/ext/doc).

- Il est possible d'agrémenter la documentation produite à l'aide de commentaires, cela sera vu plus tard.
- Notez que les noms des paramètres de méthodes et de constructeurs sont visibles et sont un élément de documentation : ils doivent être **parlants**.
