*Éléments de programmation objet*
================================

Paquetages
==========

Motivation
----------

Les visibilités `public`/`private` ne sont pas toujours suffisantes.

Exemple : les listes chaînées

-   Une classe utilitaire :

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
public class Cellule<T> {
  private T valeur;
  private Cellule<T> suivant;
  ...
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-   La classe de liste à proprement parler

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
public class Liste<T> {
  private Cellule<T> premier;
  private Cellule<T> suivant;
  private int size;
  ...
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dans cet exemple, seule la classe `Liste` est à utiliser

Paquetage
---------

Dans l’exemple ci-dessus, on voudrait avoir la classe `Cellule` maquée. Pour
cela :

-   On regroupe toutes les classes dans le même paquetage

-   Les classes que l’on souhaite masquer vont prendre la visibilité de
    paquetage

    -   Elle s’obtient en ne mettant pas de mot-clef de visibilité avec le
        mot-clef `class`

    -   C’est ce que l’on faisait au début du cours avant d’apprendre la
        visibilité

Le nom d’un paquetage est (comme un nom de site web à l’envers) une suite
d’identifiants séparés par des `.`

-   `fr.upec.scolarite.apoge`

-   `fr.lacl.equipes.svs`

On indique l’appartenance d’une classe à un paquetage en ajoutant, au début du
fichier :

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
package fr.upec.l2.info.epo;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Règles concernant les paquetages
--------------------------------

-   Les classes avec visibilité de paquetage sont utilisables par les classes
    qui sont dans le même paquetage

-   On peut aussi déclarer des méthodes, fonctions, constructeurs, etc... avec
    une visibilité de paquetage en ne mettant pas de modificateur de visibilité

    -   Il est ainsi possible de mettre des méthodes utilitaires dans la classe
        `Liste` à utiliser dans la classe `Cellule`

    -   Il est aussi possible de mettre des méthodes utilitaires dans la classe
        `Cellule` à utiliser dans la classe `Liste`

    -   Cependant même les méthodes `public` de `Cellule` ne sont utilisables
        que par des classes du même paquetage car la classe elle-même n’est pas
        visible

-   Les classes déclarées sans directive `package` sont dans le *paquetage par
    défaut* qu’il n’est pas conseillé d’utiliser

-   Les règles de bonne pratique concernant les champs restent le même : ils
    doivent être `private`

Organisation des `.java` et `.class`
------------------------------------

Les fichiers .java d’un paquetage `fr.upec.epo` sont censés être placés dans le
dossier `epo` du dossier `upec` du dossier `fr` de la *racine* du projet.

![](/l2epo/ext/img/pkg_location.png)

Les fichiers `.class` (contenant le bytecode des classes) d’un paquetage
**doivent** respecter la même arborescence

-   *DrJava* (ou eclipse) se charge de créer les répertoires automatiquement

-   En compilant avec `javac`, il suffit de spécifier la *racine* des fichiers
    .class à l’option `-d`

Diagramme de paquetage
----------------------

-   Un paquetage *p* en utilise un paquetage *q* quand l’une des classes de *p*
    utilise une classe de *q*

-   Un diagramme de paquetage est un graphe où les nœuds sont des paquetages et
    les arcs vont de *p* à *q* quand le paquetage *p* utilise une classe de *q*

Ces diagrammes de paquetage permettent de mettre en évidence des erreurs de
conception.

-   Il ne doit pas contenir de cycles

-   L’idée est que une dépendance entre *p* et *q* fait qu’un bug de *p* peut
    induire un bug ou une réécriture de *q*

-   On veut éviter d’avoir des bugs qui s’alimentent en boucle

Documentation de paquetage
--------------------------

-   Les paquetages sont documentés dans le fichier `package-index.java`
    contenant juste :

    -   Le commentaire Javadoc (entre `/**` et `*/`)

    -   Suivi de la déclaration `package`

-   La présence du `-` dans le nom s’assure qu’il ne peut être un nom de classe
    valide

Importation de classes d’un autre paquetage
-------------------------------------------

-   Le nom complet d’une classe est le nom du paquetage puis `.` puis le nom de
    la classe

-   On peut utiliser directement avec seulement le nom de la classe :

    -   Les classes du même paquetage

    -   Les classes du paquetage `java.lang` (`String` par exemple)

    -   Les classes importées

-   On importe une classe avec la directive `import` en haut du fichier (juste
    après la directive `package`)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
package fr.upec.epo;

import java.util.ArrayList;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-   Il est aussi possible d’importer toutes les classes d’un paquetage avec `*`
    mais cette pratique est déconseillée car elle risque de briser la
    compilabilité d’un code

>   Avec eclipse, il suffit de taper Ctrl-Shift-O (organize imports) pour
>   importer toutes les classes utilisées et supprimer les étoiles

Création de `jar`
-----------------

-   Pour obtenir un produit fini, il est fréquent de mettre les fichiers
    `.class` dans une archive jar.

-   Le classe contenant la fonction `main` est à mettre dans un fichier
    `manifest.mf` contenant la ligne :

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Main-Class: fr.upec.epo.Main
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

où `fr.upec.epo.Main` est le nom complet de la classe et **l’espace après le**
`:`\*\* est obligatoire\*\*

-   Le fichier manifest.mf doit être mis, par exemple, dans le dossier parent de
    dossier qui contient les classes puis on exécute à partir du dossier qui
    contient les classes la commande :

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
jar cvmf ../manifest.mf ../application.jar .
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-   Les IDE comme DrJava (à condition de créer un projet) ou eclipse permettent
    aussi de créer des jar avec une interface graphique

-   En ouvrant le fichier `.jar` obtenu, on lance le programme

-   Il est aussi possible de le lancer en ligne de commande avec `java -jar`

Interaction avec l’utilisateur
------------------------------

Comme le programme est lancé avec un double-clic, les interactions avec
l’utilisateur doivent utiliser une fenêtre. En attendant d’apprendre à faire de
vraies interfaces graphiques, il est possible de demander :

-   Des valeurs à l’utilisateur avec les **méthodes statiques** de `JOptionPane`

-   Des fichiers avec la classe `JFileChooser`

Exemple :

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
package fr.upec.epo;

import java.io.File;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.nio.channels.FileChannel.MapMode;
import java.nio.charset.Charset;
import java.nio.file.StandardOpenOption;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

public class JOPTest {
  public static void main(String[] args) {
    JFileChooser chooser = new JFileChooser(System.getProperty("user.dir"));
    chooser.setMultiSelectionEnabled(false);
    chooser.showOpenDialog(null);
    File file = chooser.getSelectedFile();
    String message;
    try {
      message = Charset.defaultCharset()
          .decode(FileChannel.open(file.toPath(), StandardOpenOption.READ)
              .map(MapMode.READ_ONLY, 0, file.length()))
          .toString();
      JOptionPane.showMessageDialog(null, message, file.getName(),
          JOptionPane.INFORMATION_MESSAGE);
    } catch (IOException e) {
      JOptionPane.showMessageDialog(null,
          e.getClass().getSimpleName() + ": " + e.getMessage(), "Error",
          JOptionPane.ERROR_MESSAGE);
    }
  }
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
