public with sharing class TripCancelBatch implements Database.Batchable<Trip__c> {

    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([
            SELECT Id, Status__c, Start_Date__c, Number_of_Participants__c
            FROM Trip__c
            WHERE Status__c = 'To come' AND Start_Date__c != null AND Number_of_Participants__c != null
        ]);
    }

    public void execute(Database.BatchableContext context, List<Trip__c> scope) {
        Date today = Date.today();

        for (Trip__c trip : scope) {
            Integer daysBeforeStart = today.daysBetween(trip.Start_Date__c);
            Boolean tooFewParticipants = trip.Number_of_Participants__c < 10;
            Boolean startsSoon = daysBeforeStart <= 7 && daysBeforeStart >= 0;

            if (tooFewParticipants && startsSoon) {
                trip.Status__c = 'Cancelled';
            }
        }

        update scope;
    }

    public void finish(Database.BatchableContext context) {
        System.debug('TripCancelBatch terminé.');
    }
}
