@isTest
public class TripCancelBatchTest {

    @isTest
    static void testTripCancelBatch() {
        // Créer un compte
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Trip à annuler : < 10 participants, commence dans moins de 7 jours
        Trip__c cancelTrip = new Trip__c(
            Destination__c = 'Rome',
            Start_Date__c = Date.today().addDays(5),
            End_Date__c = Date.today().addDays(10),
            Number_of_Participants__c = 5,
            Status__c = 'A venir',
            Total_Cost__c = 2000,
            Account__c = acc.Id
        );

        // Trip à conserver : 12 participants
        Trip__c keepTrip = new Trip__c(
            Destination__c = 'Rome',
            Start_Date__c = Date.today().addDays(5),
            End_Date__c = Date.today().addDays(10),
            Number_of_Participants__c = 12,
            Status__c = 'A venir',
            Total_Cost__c = 4000,
            Account__c = acc.Id
        );

        insert new List<Trip__c>{cancelTrip, keepTrip};

        // Exécuter le batch
        Test.startTest();
        TripCancelBatch batch = new TripCancelBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        // Vérifier que seul le premier a été annulé
        Trip__c updatedTrip1 = [SELECT Id, Status__c FROM Trip__c WHERE Id = :cancelTrip.Id];
        Trip__c updatedTrip2 = [SELECT Id, Status__c FROM Trip__c WHERE Id = :keepTrip.Id];

        System.assertEquals('Annulé', updatedTrip1.Status__c, 'Le voyage doit être annulé');
        System.assertEquals('A venir', updatedTrip2.Status__c, 'Le voyage ne doit pas être annulé');
    }
}
