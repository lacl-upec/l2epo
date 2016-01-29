*Éléments de programmation objet*
===================================

Rappels : structures de données
===============================

Types primitifs
---------------

Les données informatiques sont construites à partir des types « primitifs » :

- Les entier `int`, `long`
- Les flottants `float`, `double` 
- Les caractères `char`
- Les booléens `boolean`

Les chaînes de caractères de type `String` ne sont pas un type primitif. On en reparlera quand on aura mieux cerner le concept d'objet.

Enregistrements
---------------

Dans certains cas, il est plus lisible de regrouper des types primitifs au sein d'un seul type appelé « enregistrement » :

- Un point est l'aggrégation de deux flottants

      class Point {
        double x;
        double y;
      }

- Un cercle est représenté par trois flottants (les coordonnées du centre et le rayon) :

      class Cercle {
        double cx;
        double cy;
        double rayon;
      }
    
  voire par un point et un flottant :

      class Cercle {
        Point centre;
        double rayon;
      }
    
Références
----------

Les enregistrements sont souvent manipulés par des références : une variable de type `Point` ne contient pas les deux `double` mais seulement un pointeur sur l'emplacement où ils se trouvent en mémoire.

En conséquence :

- Dupliquer le contenu de la variable ne duplique pas les données pointées

      Point p = q;
      q.x = 10;

  Une fois ce code exécuté, p.x vaut aussi 10

- Écraser le contenu d'une variable n'efface pas la zone correspondante en mémoire

      Point p = creerPoint(0,0);
      p = creerPoint(13,14);

  Le premier `Point` est créé inutilement

- La référence peut être `null` pour indiquer qu'elle ne contient pas de donnée. On ne peut dans ce cas pas affecter ou consulter la valeur des champs.

> En cas de création d'un tableau de `Point`, toutes les cases sont initialisées avec `null`
            
Données de taille non bornées
-----------------------------

Certaines information que l'on souhaite stocker dans un ordinateur n'ont pas une taille préféfinie lors de l'écriture du programme. Ça n'est que lorsque l'on exécute le programme que l'utilisateur pour fournir cette information : une carte, une liste d'élève, les données du jeu minecraft.

Pour représenter ces données, on a deux possibilités :

- Utiliser des tableaux, aggrégation d'un nombre fixe mais dynamique de données de même type.

  - Fixe mais dynamique veut dire « inconnu lors de l'écriture du programme (dynamique) mais fixé à la création de la structure de donnée »

  - `int[]`, `Point[]`

- Utiliser des structures de donnée récursives

  - Des enregistrements qui peuvent contenir comme champ une référence veut une enregistrement de même type
    
        class ListeChaineeDePoints {
          Point valeur;
          ListeChaineeDePoints valeurSuivantes;
        }
          
    voire
      
        class ListeDoublementChaineeDePoints {
          Point valeur;
          ListeDoublementChaineeDePoints suivant;
          ListeDoublementChaineeDePoints precedent;
        }
          
  - Cette notion utilise pleinement la notion de référence et la référence `null` : sans elle pour indiquer la fin de la liste, cela ne marche pas.
    
> Notez que la plupart des structures de données complexes utilisent l'une et/ou l'autre mécanisme.

Programmation objet
===================

Concept
-------

La programmation objet pousse plus loin le concept d'aggrégation de données au sein d'une entité logique.

 - En différenciant :
     - les données (les champs de l'objet)
     - les « méthodes » : les fonctions que l'on souhaite effectuer avec ces données.
 - En séparant distinctement :
     - ce qui est interne à l'objet, du domaine de compétence du developpeur en charge de la « classe »
     - ce que l'objet offre comme fonctionalités, du domaine de compérence des développeurs utilisants la classe
 - Ceci a beaucoup de conséquences bénéfiques sur le développement logiciel

Constructeur
------------

Comme déclarer une variable de type `Point` ne fait qu'allouer de la place pour une *référence* vers les données d'un point, il faut un mécanisme pour allouer de la place pour ces données.

 - Cela se fait avec le mot-clef `new`
 - Ensuite, on appelle une fonction spéciale appelée constructeur :
   - la fonction a le même nom que le nom de la classe
   - elle n'a pas de type de retour (même par `void`)
   - elle peut prendre des paramètres
   - elle peut écrire dans les champs de l'objet : pour écrire dans le champ `c`, on utilise `this.c`

Les constructeurs le plus simple :

  - utilisent les paramètres de la fonction pour remplir les champs :
         
        class Point {
          float x;
          float y;
          
          Point(float x, float y) {
            this.x = x;
            this.y = y;
          }
        }
        
  - Mettent des valeurs fixes dans les champs :

        class Chrono {
          long time;
          
          Chrono() {
            this.time = System.nanoTime();
          }
        }
        
   - combinent les deux
   
        class Alarm {
          long time;
          long duration;
          
          Alarm(long duration) {
            this.time = System.nanoTime();
             this.duration = duration;
          }
        }
        
On appelle un constructeur avec `new` suivi du nom de la classe puis des paramètres du constructeur :

    new Point(1,2);
    new Chrono();
    new Alarm(1000000);

Appeler `new` alloue en mémoire de la place pour les données de l'objet puis appelle le constructeur pour les remplir :

> `this` représente cet emplacement mémoire

Bien évidemment, pour utiliser cet objet, il faut soit stocker sa référence dans une variable :

    Chrono chrono = new Chrono();
        
soit passer sa référence à une fonction (pas d'exemple pour le moment).

Classes, objet, instance
------------------------

Considérons la classe `Point` ci-dessous :

    class Point {
      float x;
      float y;
      
      Point(float x, float y) {
        this.x = x;
        this.y = y;
      }
    }

Une *classe* est un type de donnée (comme `int`ou `float[]`) : la classe `Point` des objets de type `Point`

    Point p = new Point(10,12);

- Un *objet* appartient à une classe ; on dit que c'est une *instance* de la classe
- La variable `p` contient une référence vers une instance de la classe `Point` ; en Java, on ne manipule jamais les objets directement
  
      
Fonction
--------

En Java, les fonctions doivent se trouver au sein d'une classe.

> On peut très bien créer une classe sans champs juste pour cela et c'est une bonne pratique

Elles sont déclarées comme en Javascool mais précédées par le mot-clef `static`

    class Prog {

      static double aireCercle(double rayon) {
        return Math.PI*rayon*rayon;
      }
         
      static void afficheAireCercle(double rayon) {
        System.out.println(aireCercle(rayon));
      }
    }
       
La méthode principale a une syntaxe spéciale : elle prend en paramètre un tableau de `String` et il faut ajouter `public` devant `static` (un peu pour indiquer que le lanceur de programme a le droit d'y accéder)

    class Prog {
        
      public static void main(String[] args) {
        double ratyon = 20;
        afficheAireCercle(rayon);
      }
       
      static double aireCercle(double rayon) {
        return Math.PI*rayon*rayon;
      }
         
      static void afficheAireCercle(double rayon) {
        System.out.println(aireCercle(rayon));
      }
         
    }

Plusieurs fonctions dans plusieurs classes
------------------------------------------

Il est possible de séparer les fonctions dans différentes classes. Pour appeler une fonction d'une autre classe, il suffit de mettre son nom avant :

    class CercleUtil {
    
      static double aireCercle(double rayon) {
        return Math.PI*rayon*rayon;
      }
         
      static void afficheAireCercle(double rayon) {
        System.out.println(aireCercle(rayon));
      }
    
   }
   
   class Prog {
   
     public static void main(String[] args) {
        double ratyon = 20;
        CercleUtil.afficheAireCercle(rayon);
     }
     
   }

Mais pourquoi ne pas mettre les fonctions de `CercleUtil` dans la classe `Cercle` ?

- soit parce que le concepteur considère qu'il n'est pas de la responsabilité de la classe Cercle de calculer son aire
- soit parce que dans le cas contraire, on utiliserait un méthode d'objet.

Bibliothèque standard
---------------------

Java est fourni avec de nombreuses classes utilitaires. Aujourd'hui, nous avons vu :

- `System.nanoTime()` qui retourne le nombre de nanosecondes depuis un temps inconnu mais fixe
- `System.out.println` qui est la version Java du `println` de Javascool
- `Math.PI` qui contient la valeur π
