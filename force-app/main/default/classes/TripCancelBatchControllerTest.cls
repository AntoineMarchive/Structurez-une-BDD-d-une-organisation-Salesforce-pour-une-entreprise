@isTest
public class TripCancelBatchControllerTest {

    @isTest
    static void testRunTripCancelBatch() {
        // Création des données nécessaires
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Création d'une opportunité avec données valides
        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            StageName = 'Closed Won',
            CloseDate = Date.today().addDays(10),
            AccountId = acc.Id,
            Destination__c = 'Lisbonne',
            Start_Date__c = Date.today().addDays(5),
            End_Date__c = Date.today().addDays(10),
            Number_Of_Participants__c = 5,
            Amount = 5000
        );
        insert opp;

        Trip__c trip = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'A venir',
            Destination__c = 'Lisbonne',
            Start_Date__c = Date.today().addDays(5),
            End_Date__c = Date.today().addDays(10),
            Number_of_Participants__c = 5,
            Total_Cost__c = 5000,
            Account__c = acc.Id
        );
        insert trip;

        Test.startTest();
            TripCancelBatchController.runTripCancelBatch();
        Test.stopTest();

        // Vérifie si le statut a bien été mis à jour
        Trip__c updatedTrip = [SELECT Status__c FROM Trip__c WHERE Id = :trip.Id];
        System.assertEquals('Annulé', updatedTrip.Status__c, 'Le statut du voyage doit être "Annulé"');
    }
}
