// Classe de gestion des Destinations. Utilise DestinationSelector pour interagir avec la base de données.
public with sharing class DestinationController {
    
    // Récupère toutes les destinations disponibles
    public static List<Destination__c> getDestinations() {
        return DestinationSelector.getDestinations();
    }

    // Crée une nouvelle destination après avoir validé le tarif
    public static Destination__c createDestination(Destination__c newDestination) {
        if (newDestination.Cost_Per_Person_Per_Day__c < 0) {
            throw new IllegalArgumentException('Le coût par personne par jour ne peut pas être négatif.');
        }
        return DestinationSelector.createDestination(newDestination);
    }

    // Met à jour une destination existante après vérification du tarif
    public static Destination__c updateDestination(Destination__c destinationToUpdate) {
        if (destinationToUpdate.Cost_Per_Person_Per_Day__c < 0) {
            throw new IllegalArgumentException('Le coût par personne par jour ne peut pas être négatif.');
        }
        return DestinationSelector.updateDestination(destinationToUpdate);
    }

    // Supprime une destination via son Id
    public static void deleteDestination(Id destinationId) {
        DestinationSelector.deleteDestination(destinationId);
    }
}
