*Éléments de programmation objet*
=================================

Classes génériques, partie 2
============================

Types enveloppe
---------------

Dans certains cas, on souhaite mettre un type primitif comme paramètre de type.

C'est interdit, mais Java propose à la place, pour chaque type primitif, un type enveloppe, objet qui contient de type primitif:

- `Integer` pour `int`
- `Long` pour `long`
- `Float` pour `float`
- `Double` pour `double`
- `Character` pour `char`
- `Boolean` pour `boolean`

Bien qu'il y ait un constructeur dans chaque classe, on préfère utiliser la *factory method* `valueOf` de chaque type.

    Integer six = Integer.valueOf(6);

Pour obtenir la valeur stockée dans l'objet enveloppe, on utilise la méthode *xxx*`Value` où *xxx* est le nom du type primitif (`intValue`, `booleanValue`...)

Auto-boxing, unboxing
---------------------

Pour éviter de la lourdeur :

- Java crée automatiquement l'instance du type enveloppe si nécessaire :
   - On peut donc passer un type primitif à la place du type enveloppe à une méthode
   - On peut direcement stocker un type primitif dans une variable ou un champ de type enveloppe
 - Ce mécanisme s'appelle *auto-boxing*

Exemple :

    Integer six = 6;
    Cell<Integer> = new Cell<>(6);

De plus :

- Java supprime automatique l'enveloppe si nécessaire :
   - On peut donc passer un type enveloppe à la place du type primitif à une méthode
   - On peut direcement stocker un type enveloppe dans une variable ou un champ de type primitif
 - Ce mécanisme s'appelle *auto-unboxing*

Ce mécanisme rend le débogage des `NullPointerException` moins intuitif :

    public class Unboxcrash {
      public static void printMe(double d) {
        System.out.println(d);
      }
      
      public static void main(String[] args) {
        Double d = null;
        printMe(d);
      }
    }

L'exécution du programme provoque un `NullPointerException` (2ème ligne de `main`) sans `.`

Rappel : en cas de `NullPointerException`, chercher les `.` et `[` à la ligne incriminée.

Efficacité
----------

Les types enveloppe sont non-mutables.

À chaque création de type enveloppe, un objet est créé. Il faut donc éviter d'en créer pour rien.

Un très mauvais exemple :

    for(Integer i=0;i<2000;i++) {
      System.out.println(2*i);
    }

Ce code crée 2000 objets !

Méthodes et fonctions paramétrées
---------------------------------

Pour écrire des fonctions qui s'occupent de traiter des listes, il est impossible d'utiliser une class générique puisque les fonctions sont dans un contexte statique. Il est possible de paramétrer les fonctions en ajoutant `<E>` **juste avant le type de retour ou le `void`**.

Exemple :

    public static <E> void afficheElements(Cell<E> e) {
      for(Cell<E> l = e; l!=null; l=l.getNext())
        System.out.println(l.getElement());
    }

Lors de l'appel d'une fonction paramétrée, le compilateur devine la valeur du paramètre de type comme pour le diamant.

S'il n'y arrive pas, on peut lui indiquer mais avec forcément un appel avec un `.`. Il faut donc utilise `this.` obligatoirement ou `NomDeClasse.` même si l'on appelle une méthode ou une fonction de la classe.

Si l'on reconsidère la classe suivante :

    public class Machine {
      private Stack<String> stack;
      public Machine(Stack<String> stack) {
        this.stack = stack;
      }
      ...
    }

On ne peut pas écrire :

    public class Main {
      public static <E> Stack<E> newEmptyStack() {
        return new Stack<E>();
      }
      public static void main(String[] args) {
        Machine m = new Machine(newEmptyStack());
      }
    }

Il faut préciser :

    public class Main {
      public static <E> Stack<E> newEmptyStack() {
        return new Stack<E>();
      }
      public static void main(String[] args) {
        Machine m = new Machine(Main.<String>newEmptyStack());
      }
    }
    
Le code suivant ne compile pas :

    public class Main {
      public static <E> Stack<E> newEmptyStack() {
        return new Stack<E>();
      }
      public static void main(String[] args) {
        Machine m = new Machine(<String>newEmptyStack());
      }
    }
 
Foreach
=======

Il est possible de parcourir un tableau ou les collections standard de Java avec un *foreach* qui s'écrit de la manière suivante :

    public class Printer {
      public static void main(String[] args) {
        for (String arg : args) {
          System.out.println(arg);
        }
      }
    }