*Éléments de programmation objet*
=================================

UML
===

Présentation
------------

*UML* est un ensemble de diagramme permettant de représenter la conception d'un logiciel

- Diagramme de séquence
- Diagramme de paquetage
- *Diagramme de classe*
- Diagramme de cas d'utilisation
- ...

Nous verrons comment représenter les dépendances entre classes à l'aide d'un diagramme de classe.

Diagramme de classe
-------------------

Ensemble de boîtes de la forme

![UML box](/l2epo/ext/img/UML.svg)

Notez :

- La présence des champs (typés à la Pascal) avec leur visibilité
- La présence des méthodes (typées à la Pascal) avec leur visibilité
- Que la visibilité est `+` pour publique et `-` pour privé

Pour former un diagramme de classe, ces boîtes sont reliées entre elles par des flèches. Dans ce cours, nous ne verrons que les flèches de type *association*.

Association
-----------

Une association entre `A` et `B` indique que :

- La classe `A` contient une ou plusieures références vers la `B`

et/ou

- La classe `B` contient une ou plusieures références vers la `A`

On donne, en annotant la flèche, les informations :

- Les nombres possibles de référence de `A` dans `B` et de `B` dans `A` (multiplicité)
- Le champ qui contient ces références avec leur visibilité.
- Un champ qui est indiqué par une association n'est pas indiqué en plus dans la boîte de la classe
- On préférera toujours une association à une indication de champ dans la boîte

Multiplicité
------------

**Attention, les multiplicités sons à l'inverse des diagrammes entité-relation des bases de données**.

- Du côté de `B` se trouve le nombre de références vers des instances de `B` dans une instance de `A`.
- S'il y a au moins une référence vers `B` dans `A` et au moins une référence vers `A` dans `B` on utilise just un trait
- Sinon on utilise une flèche dont la pointe indique la classe qui est référencée par l'autre

Exemple :

![UML box](/l2epo/ext/img/UML2.svg)

Exception
=========

Définition
----------

Le système d'exception permet d'enrichir la « communication » entre une fonction et son appelant. Elle peut :

- Retourner une valeur
- Lever/Lancer une exception

Propagation
-----------

Les exceptions lancées sont propagées de fonction/méthode appelante en fonction/méthode appelante jusqu'à ce que :

- Elle soit attrapée et traitée
- Elle sorte de la fonction `main` ; dans ce cas, un message (d'erreur) est affiché

Autrement dit, les exceptions remontent la pile d'appel.

Exemple :

- La fonction `main` appelle la fonction `traite` qui appelle la fonction `faitLe` qui lève une exception
- La fonction `traite` n'attrape pas l'exception qui se propage à la fonction `main`
- La fonction `main` attrape l'exception et continue

En java :

    public class Exn {
      public static void main(String[] args) {
        try {
          traite();
        }
        catch (IllegalStateException e) {
          System.out.println("Exception attrapée : "+e);
        }
      }
      
      public static void traite() {
        faitLe();
      }
      
      public static void faitLe() {
        throw new IllegalStateException("Non, je ne veux pas !");
      }
    }

Syntaxe
-------

Une exception est un objet avec un type particulier. Dans ce cours, on utilisera les exceptions standard de Java dont :

- `IllegalArgumentException` pour les paramètres de méthode/fonction/constructeur invdalide (par exemple, donner un âge négatif)
- `IllegalStateException` pour l'appel d'une méthode d'un objet alors que c'est interdit (par exemple, récupérer le haut d'une pile vide)
- `AssertionError` pour un cas qui ne peut pas arriver, sauf bug du programme

Les exceptions sont construites avec leur constructeur (en général elles prennent un message en paramètre) et lancées directement:

    throw new IllegalStateException("Empty Stack");

Quand on veut attraper une exception, ajoute un bloc `try` ... `catch`. On peut spécifier un code spécifique pour chaque type d'exception lancé :

    try {
       ...
    }
    catch (IllegalStateException | IllegalArgumentException e) {
       ...
    }
    catch (AssertionError e) {
       ...
    }
    
La clause `throws`
------------------

Certaines exceptions doivent être indiquée dans la signature d'une méthode qui les lance (par exemple `IOException` pour indiquer une erreur d'entrée sortie).

    void readManyThings(String file) throws IOException {
       ...
    }

Cela a une conséquence : tout ce qui appelle la méthode `readManyThings` doit

- Soit attraper l'exception `IOException`
- Soit déclarer elle-même la lancer
- Le message d'erreur est clair

*Remarque : un constructeur peut lancer une exception, cela annule dans ce cas la création de l'objet* (sauf cas pathologique).

Règles de bonne pratique
------------------------

**On ne lance pas ni n'attrape l'exception `Exception`**

Type énumérés avec champs
-------------------------

On peut déclarer des `enum`s avec des champs et méthodes. Chaque élément de l'`enum` appelle le constructeur avec des arguments différents.

    public enum Mois {
      JANVIER(31),
      FEVRIER(28,true),
      MARS(31),
      AVRIL(30),
      MAI(31),
      JUIN(30),
      JUILLET(31),
      AOUT(31),
      SEPTEMBRE(30),
      OCTOBRE(31),
      NOVEMBRE(30),
      DECEMBRE(31);
      
      private final int dayCount;
      private final boolean affectedByBissectile;
      
      private Mois(int dayCount) {
        this(dayCount,false);
      }
      
      private Mois(int dayCount, boolean affectedByBissectile) {
        this.dayCount = dayCount;
        this.affectedByBissectile = affectedByBissectile;
      }
      
      public int dayCount(boolean bissectile) {
        if (affectedByBissectile)
          return bissectile?dayCount+1:dayCount;
        else
          return dayCount;
      }
      
      public int monthNumber() {
        return ordinal()+1;
      }
    }