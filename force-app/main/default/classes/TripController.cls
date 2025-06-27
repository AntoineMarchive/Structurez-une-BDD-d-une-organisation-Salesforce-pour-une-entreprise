// Classe de gestion des Voyages Salesforce. Utilise TripSelector pour interagir avec la base de données.
public with sharing class TripController {

    // Crée un voyage à partir d'une opportunité
    public static Trip__c createTrip(Opportunity opp) {
        Trip__c newTrip = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'To come',
            Destination__c = opp.Destination__c,
            Start_Date__c = opp.Start_Date__c,
            End_Date__c = opp.End_Date__c,
            Number_Of_Participants__c = opp.Number_Of_Participants__c,
            Total_Cost__c = opp.Amount,
            AccountId__c = opp.AccountId
        );
        return TripSelector.createTrip(newTrip);
    }

    // Récupère un voyage par son Id
    public static Trip__c getTripById(Id tripId) {
        return TripSelector.getTripById(tripId);
    }

    // Liste les voyages associés à un compte
    public static List<Trip__c> getTripsByAccountId(Id accountId) {
        return TripSelector.getTripsByAccountId(accountId);
    }

    // Liste les voyages associés à une destination
    public static List<Trip__c> getTripsByDestinationId(Id destinationId) {
        return TripSelector.getTripsByDestinationId(destinationId);
    }

    // Met à jour un voyage
    public static Trip__c updateTrip(Trip__c tripToUpdate) {
        return TripSelector.updateTrip(tripToUpdate);
    }

    // Supprime un voyage par son Id
    public static void deleteTripById(Id tripId) {
        TripSelector.deleteTripById(tripId);
    }

    // Supprime tous les voyages liés à un compte
    public static void deleteTripsByAccountId(Id accountId) {
        TripSelector.deleteTripsByAccountId(accountId);
    }
}
