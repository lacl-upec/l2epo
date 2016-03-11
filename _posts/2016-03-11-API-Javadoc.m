*Éléments de programmation objet*
===================================

API
===

Définition----------- **Bibliothèque** (*Library*) : ensemble de fonctions pré-programmées
  - Exemple : la libC est la bibliothèque des fonctions C standard (`fopen`, `printf`...), jQuery est une bibliotèque de Web 2.0...
- **API** (pour *application programming interface*) : ensemble des descriptions des fonctions, méthodes et autres outils disponibles dans une bibliothèque
  - Exemple : les `.h` standard du C (`stdio.h`, `stdlib.h`...)
  - Par extension, on parle également d'API quand il s'agit d'utiliser un blibliothèque qui fait un lien avec un programme ou un service wev (API *Facebook*, *twitter* ou *google analytics*)

En Java
-------

En Java, l'API est décrite par:

- La listes des classes (publiques)
- Les méthodes publiques de ces classes
- Les fonctions publiques de ces classes
- Les champs publiques de ces classes (normalement, il n'y en a pas)
- Les constructeurs publics de ces classesAvec les commentaires Javadoc.Notion de boîte noire
---------------------

L'API réalise l'interface entre le programme que vous écrivez et la bibliothèque utilisée :

- Le programme utilise les éléments de l'API
- La machine virtuelle fait le lien entre ces utilisations et le code de la bibliothèque

Contrat sous-jacent :

> Si l'on utilise l'API conformément à la documentation, le comportement sera celui indiqué dans la documentation

Conséquences :

- On n'a pas besoin de regarder le code de la bibliothèque (l'intérieur de la boîte noire), seulement la documentation de l'API
- Pour le développeur de la bibliothèque, cela permet de changer des parties du moment qu'il reste compatible avec la documentation (on parle de compatibilité ascendante)

Exemple : [JOptionPane][]

[JoptionPane]: https://docs.oracle.com/javase/8/docs/api/javax/swing/JOptionPane.html

Surcharge et variadisme
=======================

Définition
----------

Un point technique : il est possible de **surcharger** les méthodes et les constructeurs en Java.

Surcharger une méthode signifie avoir plusieurs méthodes avec :

- Le même nom
- Des arguments différents
- Le code est aussi différent même si l'une peut appeler l'autre

Surcharger un constructeur signifie avoir plusieurs constructeurs avec :

- Des arguments différents
- Le code est aussi différent même si l'une peut appeler l'autre avec `this(arg1,arg2)`

Exemple :

    public class Vecteur {
      private double r;
      private double theta;
      public Vecteur(double x,double y) {
        this(x,y,false);
      }
      public Vecteur(double a,double b,boolean polar) {
        if (polar) {
          r=a;
          theta=b;
        } else {
          r=Math.sqrt(a*a+b*b);
          theta=Math.atan2(b, a);
        }
      }
      public double projectionX() {
        return r*Math.cos(theta);
      }
      public double projectionY() {
        return r*Math.sin(theta);
      }
      public double module() {
        return r;
      }
      public double argument() {
        return theta;
      }
      public void echelle(double d) {
        r=r*d;
      }
      public void echelle(double dx, double dy) {
        double x = projectionX()*dx;
        double y= projectionY()*dy;
        r=Math.sqrt(x*x+y*y);
        theta=Math.atan2(y,x);
      }
    }

Remarques
---------

- Pour les constructeurs, comme on ne choisit pas le nom, seule la documentation permet d'indiquer quel constructeur fait quoi
- Pour éviter ces problèmes, on utilise des *factory methods*
  - Le seul constructeur est privé et ne fait qu'assigner les champs
  - On ajoute des fonctions dans la classe qui créent des nouveaux objets avec des noms parlants

On obtient :

    public class Vecteur {
      private double r;
      private double theta;
      private Vecteur(double r, double theta) {
        this.r = r;
        this.theta = theta;
      }
      public static Vecteur creerCartesien(double x,double y) {
        return new Vecteur(Math.sqrt(x*x+y*y),Math.atan2(y, x));
      }
      public static Vecteur creerPolaire(double r,double theta) {
        return new Vecteur(r,theta);
      }
      public double projectionX() {
        return r*Math.cos(theta);
      }
      public double projectionY() {
        return r*Math.sin(theta);
      }
      public double module() {
        return r;
      }
      public double argument() {
        return theta;
      }
      public void echelle(double d) {
        r=r*d;
      }
      public void echelle(double dx, double dy) {
        double x = projectionX()*dx;
        double y= projectionY()*dy;
        r=Math.sqrt(x*x+y*y);
        theta=Math.atan2(y,x);
      }
    }

- Notez que c'est plus joli mais oblige à lire la documentation pour la création des objets.
- C'est le design le plus souvent utilisé dans les API modernes, plus lisibles et moins contraignantes pour les futures versions de la bibliothèque.

Variadisme
----------

- Une méthode ou un constructeur peut prendre un nombre variable d'arguments (comme `printf`)
- Plus précisément, un nombre fixé de types données suivi de 0 à un nombre quelconque d'arguments tous de même type.
- Ce « 0 à un nombre quelconque d'arguments tous de même type » est passé sous forme de tableau.

Exemple :

    public class OutilsVecteur {
      public static Vecteur somme(Vecteur u, Vecteur v, Vecteur... vecteurs) {
        double x=u.projectionX()+v.projectionX();
        double y=u.projectionY()+v.projectionY();
        for(int i=0;i<vecteurs.length;i=i+1) {
          x=x+vecteurs[i].projectionX();
          y=y+vecteurs[i].projectionY();
          }
        return Vecteur.creerCartesien(x,y);
      }
    }

Règles de bon usage
-------------------

Les méthodes suchargés pouvant être appelées l'un à la place de l'autre doivent avoir le même comportement.

Exemple :

- `void f(int x)`
- `void f(double x)`
- `void f(int... x)`

JavaDoc
=======

Afin de créer la documentation de son programme ou de sa bibliothèque, on ajouter des *commentaires JavaDoc*.

Exemple :

    /**
     * Cette classe représente un vecteur en dimension 2.
     */
    public class Vecteur {
      private double r;
      private double theta;
      private Vecteur(double r, double theta) {
        this.r = r;
        this.theta = theta;
      }
      /**
       * Retourne un vecteur nouvellement alloué dont les coordonnées cartésiennes sont passées en argument.
       * @param x la coordonnée x du vecteur.
       * @param y la coordonnée y du vecteur.
       * @return le vecteur nouvellement alloué.
       * @see #creerPolaire(double, double)
       */
      public static Vecteur creerCartesien(double x,double y) {
        return new Vecteur(Math.sqrt(x*x+y*y),Math.atan2(y, x));
      }
      /**
       * Retourne un vecteur nouvellement alloué dont les coordonnées polaires sont passées en argument.
       * @param r la coordonnée r du vecteur.
       * @param theta la coordonnée theta du vecteur.
       * @return le vecteur nouvellement alloué.
       * @see #creerCartesien(double, double)
       */
      public static Vecteur creerPolaire(double r,double theta) {
        return new Vecteur(r,theta);
      }
      /**
       * Retourne la projection du vecteur sur l'axe X.
       * @return la projection du vecteur sur l'axe X.
       */
      public double projectionX() {
        return r*Math.cos(theta);
      }
      /**
       * Retourne la projection du vecteur sur l'axe Y.
       * @return la projection du vecteur sur l'axe Y.
       */
      public double projectionY() {
        return r*Math.sin(theta);
      }
      /**
       * Retourne le module du vecteur.
       * @return le module du vecteur.
       */
      public double module() {
        return r;
      }
      /**
       * Retourne l'argument du vecteur.
       * 
       * L'argument du vecteur est l'angle en radians formé par l'axe des X et le vecteur.
       * @return l'argument du vecteur.
       */
      public double argument() {
        return theta;
      }
      /**
       * Modifie {@code ce} vecteur en l'allongant d'un facteur d.
       * @param d le facteur d'allongement
       */
      public void echelle(double d) {
        r=r*d;
      }
      /**
       * Modifie {@code ce} vecteur en l'allongant d'un facteur dx suivant l'axe X et
       * d'un facteur dy suivant l'axe Y
       * @param dx le facteur d'allongement suivant l'axe X
       * @param dy le facteur d'allongement suivant l'axe Y
       */
      public void echelle(double dx, double dy) {
        double x = projectionX()*dx;
        double y= projectionY()*dy;
        r=Math.sqrt(x*x+y*y);
        theta=Math.atan2(y,x);
      }
    }

La javadoc obtenue est disponible à [cet endroit](/l2epo/ext/doc2). Notez qu'une fois en anglais le `ce` prend un sens différent.

API en Java
-----------

En Java, la documentation d'une API de bibloithèque est donné par le site généré par l'utilitaire Javadoc.

On peut trouver l'API du la bilbiothèque standard de Java à [cette adresse][urljavadoc].

[urljavadoc]: https://docs.oracle.com/javase/8/docs/api