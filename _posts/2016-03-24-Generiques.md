*Éléments de programmation objet*
=================================

Classes génériques
=================

Présentation
------------

Les classes génériques permettent de laisser le choix à l'utilisateur de la classe du type qu'il veut stocker dans chaque instance.

Exemple : toute structure de données complexe.

- Liste
- Arbres
- Ensembles
- Paires...


Concept
-------

Une classe est générique si elle a des *paramètres de type* :

    class ListeChainee<E> {

Le `E` est un paramètre de type (*type parameter*).

1. Comme tout paramètre, il doit spécifié à chaque utilisation de la classe :

  - À chaque fois que la classe est utilisé pour typer un champ, une variable ou un paramètre de méthode, de fonction ou de constructeur
  - À chaque nouvelle instanciation d'objet

2. De même que les paramètres de méthode, dans le corps de la classe, on peut utiliser le paramètre de type comme n'importe quelle type :

  - Si j'ai le paramètre `int x` dans une méthode, je peux utiliser `x` à tout endroit ou l'on a besoin d'un entier
  - Pour chaque instance de la classe, `E` a une valeur, c'est-à-dire que pour chaque objet, `E` correspond à un vrai type
  - Je peux donc utiliser `E` à tout endroit où l'on a besoin d'un type
     - Déclaration d'un variable ou d'un champ
     - Paramètre de méthode ou constructeur
     - Type de retour d'une méthode
     - Paramètre de type d'une classe générique !
  - `E` ne peut pas être utilisé dans un contexte statique (fonction et variable globales), au même titre que les champs : sa valeur n'est pas la même pour tous les objets

Exemple :

    class Toto<E> {
      E c1;
      Toto<E> c2;
      Toto<String> c3;
      public Toto(E c1,Toto<E> c2, Toto<String> c3) {
        this.c1=c1;
        this.c2=c2;
        this.c3=c3;
      }
      E getC1() {
        return c1;
      }
      void setC1(E e) {
        this.c1=c1;
      }
    }

Exception : on ne peut pas faire de tableau générique (`new E[...]`). On utilisera plutôt la classe `ArrayList<E>`. On ne peut pas non plus utiliser le variadisme avec `E...`.

Attention : Si l'on ommet la valeur du paramètre de type comme demandé au point 1, cela ne fait pas d'erreur de compilation (compatibilité ascendante, les types génériques datent de Java 5)

Exemple
-------

Maillon de liste chaînée.

    public class Cell<E> {
      private E element;
      private Cell<E> next;
      public Cell(E element) {
        this(element,null);
      }
      public Cell(E element,Cell<E> next) {
        this.element = element;
        this.next = next;
      }
      public E getElement() {
        return element;
      }
      public Cell<E> getNext() {
        return next;
      }
    }

Programme de test.

    public class Prog {
      public static void main(String[] args) {
        Cell<String> l = new Cell<String>("un",
          new Cell<String>("deux",
            new Cell<String>("trois",
              new Cell<String>("quatre"))));
        for(Cell<String> g=l;g!=null;g=g.getNext()) {
          System.out.println(g.getElement());
        }
      }
    }

Diamant
-------

Pour **l'appel** des constructeurs, on peut juste écrire `<>` au lieu de `<String>` et dans ce cas, le compilateur infère le bon type à partir :
 - Des arguments du constructeur
 - Du type de la variable dans laquelle est stocké l'objet si elle existe

    public class Prog {
      public static void main(String[] args) {
        Cell<String> l = new Cell<>("un",
          new Cell<>("deux",
            new Cell<>("trois",
              new Cell<>("quatre"))));
        for(Cell<String> g=l;g!=null;g=g.getNext()) {
          System.out.println(g.getElement());
        }
      }
    }

Il n'utilise pas la type du paramètre de la méthode ou de la fonction auquel on passe la nouvelle instance.

    public class Stack<E> {
      
      Cell<E> first;
    
      public Stack() {
        // this.first = null;
      }
      
      private void checkEmpty() {
        if (first==null)
          throw new IllegalArgumentException("Empty stack");
      }
      
      public E pop() {
        checkEmpty();
        E e = first.getElement();
        first = first.getNext();
        return e;
      }
      
      public E peek() {
        checkEmpty();
        return first.getElement();
      }
      
      public void push(E e) {
        first = new Cell<>(e,first);
      }
    }

Programme de test :

    public class Prog {
      public static void main(String[] args) {
        Stack<String> l = new Stack<>();
        ...
      }
    }
    
En revanche, si l'on considère la classe suivante :

    public class Machine {
      private Stack<String> stack;
      public Machine(Stack<String> stack) {
        this.stack = stack;
      }
      ...
    }

On ne peut pas écrire :

    public class Main {
      public static void main(String[] args) {
        Machine m = new Machine(new Stack<>());
      }
    }

Il faut préciser :

    public class Main {
      public static void main(String[] args) {
        Machine m = new Machine(new Stack<String>());
      }
    }


Paramètre de type objet
-----------------------

Le paramètre de type `E` ne peut prendre que un type objet comme valeur.

Conséquence :

 - Une variable de type `E` peut prendre la valeur `null`
 - On peut passer une valeur de type `E` à `println` (on peut même appeler sa méthode `toString`)

Exemple :

    public E poll() {
      if (first == null)
        return null;
      return first.getElement();
    }

Classe générique et typage
--------------------------

Deux instances différents de la même classe générique mais avec des valeurs de type différent ne sont pas du même type. Un `Cell<String>` n'est pas un `Cell<Vecteur>`.

Plusieurs paramètres de type
----------------------------

On peut mettre autant de paramètres de type que l'on souhaite (séparés par des virgules).

    public class Pair<E1,E2> {
      private final E1 e1;
      private final E2 e2;
      public Pair(E1 e1, E2 e2) {
        this.e1 = e1;
        this.e2 = e2;
      }
      public E1 getE1() {
        return e1;
      }
      public E2 getE2() {
        return e2;
      }
    }