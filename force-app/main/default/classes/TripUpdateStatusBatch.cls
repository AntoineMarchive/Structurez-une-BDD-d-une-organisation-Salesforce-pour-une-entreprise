public with sharing class TripUpdateStatusBatch implements Database.Batchable<Trip__c> {

    // Étape 1 : Query des voyages à traiter
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([
            SELECT Id, Status__c, Start_Date__c, End_Date__c 
            FROM Trip__c
            WHERE Start_Date__c != null AND End_Date__c != null
        ]);
    }

    // Étape 2 : Traitement des enregistrements
    public void execute(Database.BatchableContext context, List<Trip__c> scope) {
        Date today = Date.today();

        for (Trip__c trip : scope) {
            if (today < trip.Start_Date__c) {
                trip.Status__c = 'To come';
            } else if (today >= trip.Start_Date__c && today <= trip.End_Date__c) {
                trip.Status__c = 'Ongoing';
            } else if (today > trip.End_Date__c) {
                trip.Status__c = 'Finished';
            }
        }

        update scope;
    }

    // Étape 3 : Fin du traitement
    public void finish(Database.BatchableContext context) {
        System.debug('TripUpdateStatusBatch terminé.');
    }
}
