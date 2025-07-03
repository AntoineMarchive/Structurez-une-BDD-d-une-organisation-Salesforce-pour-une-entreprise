// Classe de gestion des événements déclenchés par TripTrigger
public with sharing class TripTriggerController {

    // Vérifie que la date de début est antérieure à la date de fin pour chaque voyage
    public static void handleTripDates(List<Trip__c> trips) {
        for (Trip__c trip : trips) {
            if (trip.Start_date__c != null && trip.End_date__c != null && trip.Start_date__c >= trip.End_date__c) {
                trip.addError('La date de début doit être antérieure à la date de fin du voyage.');
            }
        }
    }
}
