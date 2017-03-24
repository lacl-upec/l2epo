Mutabilité
==========

Objets non mutables-------------------Il est souvent plus simple d'avoir des objets dont le contenu ne change pas une fois l'objet créé.On appelle un tel objet *non mutable*.Conception d'un objet non mutable---------------------------------La programmation permet aisément de concevoir des objets non mutables.- Les champs sont de toutes façons privés- On ne met que des accesseurs- On ne retourne aucune référence vers les champs dont le type est mutable  - Soit on donne accès aux méthodes du champ (méthodes déléguées)  - Soit on retourne une copie profonde du champ.

Exemple
-------Pour avoir une classe `Point` mutable mais une classe ligne `Ligne` non mutable :    public class Point {      private double x;      private double y;            public Point(double x, double y) {        this.x = x;        this.y = y;      }      public void setX(double x) {        this.x = x;      }      public void setY(double y) {        this.y = y;      }      public double getX() {        return x;      }            public double getY() {        return y;      }    }**Version avec délégation** :        public class Ligne {      private Point p1;      private Point p2;	  
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
