// Classe de gestion des Voyages Salesforce. Interagit avec la base de données.
public with sharing class TripSelector {

    // Insère un nouveau voyage
    public static Trip__c createTrip(Trip__c trip) {
        insert trip;
        return trip;
    }

    // Récupère un voyage par son Id
    public static Trip__c getTripById(Id tripId) {
        return [
            SELECT Id, Name, Status__c, Opportunity__c, Account__c, Destination__c,
                   Start_Date__c, End_Date__c, Number_of_Participants__c, Total_Cost__c
            FROM Trip__c
            WHERE Id = :tripId
            LIMIT 1
        ];
    }

    // Récupère les voyages liés à un compte
    public static List<Trip__c> getTripsByAccountId(Id accountId) {
        return [
            SELECT Id, Name, Status__c, Opportunity__c, Destination__c
            FROM Trip__c
            WHERE Account__c = :accountId
        ];
    }

    // Récupère les voyages liés à une destination
    public static List<Trip__c> getTripsByDestinationId(Id destinationId) {
        return [
            SELECT Id, Name, Status__c, Opportunity__c, Account__c
            FROM Trip__c
            WHERE Destination__c = :destinationId
        ];
    }

    // Met à jour un voyage
    public static Trip__c updateTrip(Trip__c tripToUpdate) {
        update tripToUpdate;
        return tripToUpdate;
    }

    // Supprime un voyage par son Id
    public static void deleteTripById(Id tripId) {
        Trip__c tripToDelete = [SELECT Id FROM Trip__c WHERE Id = :tripId LIMIT 1];
        delete tripToDelete;
    }

    // Supprime tous les voyages liés à un compte
    public static void deleteTripsByAccountId(Id accountId) {
        List<Trip__c> tripsToDelete = [SELECT Id FROM Trip__c WHERE Account__c = :accountId];
        delete tripsToDelete;
    }
}
