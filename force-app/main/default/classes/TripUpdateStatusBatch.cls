public with sharing class TripUpdateStatusBatch implements Database.Batchable<SObject> {

    // Étape 1 : Query des voyages à traiter
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([
            SELECT Id, Status__c, Start_date__c, End_date__c 
            FROM Trip__c
            WHERE Start_date__c != null AND End_date__c != null
        ]);
    }

    // Étape 2 : Traitement des enregistrements
    public void execute(Database.BatchableContext context, List<SObject> scope) {
        Date today = Date.today();
        List<Trip__c> tripsToUpdate = new List<Trip__c>();

        for (SObject sObj : scope) {
            Trip__c trip = (Trip__c) sObj;
            if (today < trip.Start_date__c && trip.Status__c != 'A venir') {
                trip.Status__c = 'A venir';
                tripsToUpdate.add(trip);
            } else if (today >= trip.Start_date__c && today <= trip.End_date__c && trip.Status__c != 'En cours') {
                trip.Status__c = 'En cours';
                tripsToUpdate.add(trip);
            } else if (today > trip.End_date__c && trip.Status__c != 'Terminé') {
                trip.Status__c = 'Terminé';
                tripsToUpdate.add(trip);
            }
        }

        if (!tripsToUpdate.isEmpty()) {
            update tripsToUpdate;
        }
    }

    public void finish(Database.BatchableContext context) {
        System.debug('TripUpdateStatusBatch terminé.');
    }
}
