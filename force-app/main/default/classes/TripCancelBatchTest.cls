@isTest
public class TripCancelBatchTest {

    @isTest
    static void testTripCancelBatch() {
        // Préparation
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Test.startTest();

        // Insertion des voyages DANS le bloc test
        Trip__c cancelTrip = new Trip__c(
            Destination__c = 'Rome',
            Start_date__c = Date.today().addDays(5),
            End_date__c = Date.today().addDays(10),
            Number_of_participants__c = 5,
            Status__c = 'A venir',
            Total_cost__c = 2000,
            Account__c = acc.Id
        );

        Trip__c keepTrip = new Trip__c(
            Destination__c = 'Rome',
            Start_date__c = Date.today().addDays(5),
            End_date__c = Date.today().addDays(10),
            Number_of_participants__c = 12,
            Status__c = 'A venir',
            Total_cost__c = 4000,
            Account__c = acc.Id
        );

        Trip__c lateTrip = new Trip__c(
            Destination__c = 'Rome',
            Start_date__c = Date.today().addDays(10),
            End_date__c = Date.today().addDays(15),
            Number_of_participants__c = 5,
            Status__c = 'A venir',
            Total_cost__c = 2500,
            Account__c = acc.Id
        );

        insert new List<Trip__c>{cancelTrip, keepTrip, lateTrip};

        // Exécution du batch
        Database.executeBatch(new TripCancelBatch());
        Test.stopTest();

        // Vérification post-traitement
        List<Trip__c> trips = [
            SELECT Id, Status__c FROM Trip__c WHERE Id IN :new List<Id>{cancelTrip.Id, keepTrip.Id, lateTrip.Id}
        ];

        Map<Id, Trip__c> tripMap = new Map<Id, Trip__c>(trips);

        System.assertEquals('Annulé', tripMap.get(cancelTrip.Id).Status__c, 'Le voyage doit être annulé');
        System.assertEquals('A venir', tripMap.get(keepTrip.Id).Status__c, 'Le voyage ne doit pas être annulé');
        System.assertEquals('A venir', tripMap.get(lateTrip.Id).Status__c, 'Le voyage ne doit pas être annulé (départ trop lointain)');
    }
}
