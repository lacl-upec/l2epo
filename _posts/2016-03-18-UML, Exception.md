*Éléments de programmation objet*
===================================

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

/* dessin de la boite */

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

/* Cours, Etudiant, Professeur, Salle */

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


      