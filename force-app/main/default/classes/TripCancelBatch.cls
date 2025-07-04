public with sharing class TripCancelBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([
            SELECT Id, Status__c, Start_date__c, Number_of_participants__c
            FROM Trip__c
            WHERE Status__c = 'A venir' AND Start_date__c != null AND Number_of_participants__c != null
        ]);
    }

    public void execute(Database.BatchableContext context, List<SObject> scope) {
        Date today = Date.today();
        List<Trip__c> tripsToUpdate = new List<Trip__c>();

        for (SObject sObj : scope) {
            Trip__c trip = (Trip__c) sObj;
            Integer daysBeforeStart = today.daysBetween(trip.Start_date__c);
            Boolean tooFewParticipants = trip.Number_of_participants__c < 10;
            Boolean startsSoon = daysBeforeStart <= 7;

            if (tooFewParticipants && startsSoon) {
                trip.Status__c = 'Annulé';
                tripsToUpdate.add(trip);
            }
        }

        if (!tripsToUpdate.isEmpty()) {
            update tripsToUpdate;
        }
    }

    public void finish(Database.BatchableContext context) {
        System.debug('TripCancelBatch terminé.');
    }
}
 