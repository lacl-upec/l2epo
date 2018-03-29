*Éléments de programmation objet*
===================================

Concepts objets élémentaires
============================



 


 
	                       this.l2.copieProfonde());
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
    }

    javadoc -link https://docs.oracle.com/javase/8/docs/api -d doc Degree.java Identity.java Student.java

- Il est possible d'agrémenter la documentation produite à l'aide de commentaires, cela sera vu plus tard.
- Notez que les noms des paramètres de méthodes et de constructeurs sont visibles et sont un élément de documentation : ils doivent être **parlants**.