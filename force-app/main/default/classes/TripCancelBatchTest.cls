@isTest
public class TripCancelBatchTest {

    @isTest
    static void testTripCancelBatch() {
        // Créer un compte
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Créer une destination
        Destination__c dest = new Destination__c(Name = 'Grèce', Cost_Per_Person_Per_Day__c = 250);
        insert dest;

        // Trip à annuler : < 10 participants, commence dans moins de 7 jours
        Trip__c cancelTrip = new Trip__c(
            Name = 'Voyage à annuler',
            AccountId__c = acc.Id,
            Destination__c = dest.Id,
            Start_Date__c = Date.today().addDays(5),
            End_Date__c = Date.today().addDays(10),
            Number_of_Participants__c = 5,
            Status__c = 'To come'
        );

        // Trip à conserver : 12 participants
        Trip__c keepTrip = new Trip__c(
            Name = 'Voyage maintenu',
            AccountId__c = acc.Id,
            Destination__c = dest.Id,
            Start_Date__c = Date.today().addDays(5),
            End_Date__c = Date.today().addDays(10),
            Number_of_Participants__c = 12,
            Status__c = 'To come'
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

        System.assertEquals('Cancelled', updatedTrip1.Status__c, 'Le voyage doit être annulé');
        System.assertEquals('To come', updatedTrip2.Status__c, 'Le voyage ne doit pas être annulé');
    }
}
