@isTest
public class TripUpdateStatusBatchControllerTest {
    @isTest
    static void testRunTripUpdateStatusBatch() {
        // Préparation des données
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Destination__c dest = new Destination__c(Name = 'Canada', Cost_Per_Person_Per_Day__c = 100);
        insert dest;

        Opportunity opp = new Opportunity(
            Name = 'Opp Voyage',
            StageName = 'Closed Won',
            CloseDate = Date.today().addDays(5),
            AccountId = acc.Id,
            Destination__c = dest.Id,
            Start_Date__c = Date.today().addDays(-2), // le voyage a commencé
            End_Date__c = Date.today().addDays(3),    // et est en cours
            Number_Of_Participants__c = 12,
            Amount = 4000
        );
        insert opp;

        Trip__c trip = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'To come', // status initial incorrect
            Destination__c = dest.Id,
            Start_Date__c = opp.Start_Date__c,
            End_Date__c = opp.End_Date__c,
            Number_of_Participants__c = opp.Number_Of_Participants__c,
            Total_Cost__c = opp.Amount,
            AccountId__c = acc.Id
        );
        insert trip;

        Test.startTest();
            TripUpdateStatusBatchController.runTripUpdateStatusBatch();
        Test.stopTest();

        // Vérification : le statut doit être "Ongoing"
        Trip__c updatedTrip = [SELECT Status__c FROM Trip__c WHERE Id = :trip.Id];
        System.assertEquals('Ongoing', updatedTrip.Status__c, 'Le voyage doit être marqué comme "Ongoing"');
    }
}
