@isTest
public class TripCancelBatchControllerTest {
    @isTest
    static void testRunTripCancelBatch() {
        // Création des données nécessaires
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Destination__c dest = new Destination__c(Name = 'Test Destination', Cost_Per_Person_Per_Day__c = 200);
        insert dest;

        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            StageName = 'Closed Won',
            CloseDate = Date.today().addDays(10),
            AccountId = acc.Id,
            Destination__c = dest.Id,
            Start_Date__c = Date.today().addDays(5),
            End_Date__c = Date.today().addDays(10),
            Number_Of_Participants__c = 5,
            Amount = 5000
        );
        insert opp;

        Trip__c trip = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'To come',
            Destination__c = dest.Id,
            Start_Date__c = Date.today().addDays(5),
            End_Date__c = Date.today().addDays(10),
            Number_of_Participants__c = 5,
            Total_Cost__c = 5000,
            AccountId__c = acc.Id
        );
        insert trip;

        Test.startTest();
            TripCancelBatchController.runTripCancelBatch();
        Test.stopTest();

        // Vérifie si le statut a bien été mis à jour
        Trip__c updatedTrip = [SELECT Status__c FROM Trip__c WHERE Id = :trip.Id];
        System.assertEquals('Cancelled', updatedTrip.Status__c, 'Le statut du voyage doit être "Cancelled"');
    }
}
