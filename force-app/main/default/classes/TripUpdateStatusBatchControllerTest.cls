@isTest
public class TripUpdateStatusBatchControllerTest {
    @isTest
    static void testRunTripUpdateStatusBatch() {
        // Préparation des données
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Opp Voyage',
            StageName = 'Closed Won',
            CloseDate = Date.today().addDays(5),
            AccountId = acc.Id,
            Destination__c = 'Canada',
            Start_Date__c = Date.today().addDays(-2), // le voyage a commencé
            End_Date__c = Date.today().addDays(3),    // et est en cours
            Number_Of_Participants__c = 12,
            Amount = 4000
        );
        insert opp;

        Trip__c trip = new Trip__c(
            Opportunity__c = opp.Id,
            Status__c = 'Brouillon', // statut initial incorrect
            Destination__c = opp.Destination__c,
            Start_Date__c = opp.Start_Date__c,
            End_Date__c = opp.End_Date__c,
            Number_of_Participants__c = opp.Number_Of_Participants__c,
            Total_Cost__c = opp.Amount,
            Account__c = acc.Id
        );
        insert trip;

        Test.startTest();
            TripUpdateStatusBatchController.runTripUpdateStatusBatch();
        Test.stopTest();

        // Vérification : le statut doit être "En cours"
        Trip__c updatedTrip = [
            SELECT Status__c FROM Trip__c WHERE Id = :trip.Id
        ];
        System.assertEquals('En cours', updatedTrip.Status__c, 'Le voyage doit être marqué comme "En cours"');
    }
}
