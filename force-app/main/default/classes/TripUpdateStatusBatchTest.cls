@isTest
public class TripUpdateStatusBatchTest {

    @isTest
    static void testTripUpdateStatusBatch() {
        // Créer un compte
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Créer une destination
        Destination__c dest = new Destination__c(Name = 'Italie', Cost_Per_Person_Per_Day__c = 200);
        insert dest;

        // Trip 1 : à venir (start date > today)
        Trip__c futureTrip = new Trip__c(
            Name = 'Futur Voyage',
            AccountId__c = acc.Id,
            Destination__c = dest.Id,
            Start_Date__c = Date.today().addDays(10),
            End_Date__c = Date.today().addDays(15),
            Number_of_Participants__c = 15,
            Status__c = 'Draft'
        );

        // Trip 2 : en cours (today entre start et end)
        Trip__c ongoingTrip = new Trip__c(
            Name = 'Voyage En Cours',
            AccountId__c = acc.Id,
            Destination__c = dest.Id,
            Start_Date__c = Date.today().addDays(-2),
            End_Date__c = Date.today().addDays(3),
            Number_of_Participants__c = 12,
            Status__c = 'Draft'
        );

        // Trip 3 : terminé (end date < today)
        Trip__c finishedTrip = new Trip__c(
            Name = 'Voyage Terminé',
            AccountId__c = acc.Id,
            Destination__c = dest.Id,
            Start_Date__c = Date.today().addDays(-10),
            End_Date__c = Date.today().addDays(-5),
            Number_of_Participants__c = 20,
            Status__c = 'Draft'
        );

        insert new List<Trip__c>{futureTrip, ongoingTrip, finishedTrip};

        // Lancer le batch
        Test.startTest();
        TripUpdateStatusBatch batch = new TripUpdateStatusBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        // Vérifier les résultats
        List<Trip__c> trips = [
            SELECT Id, Status__c FROM Trip__c WHERE Id IN :new List<Id>{futureTrip.Id, ongoingTrip.Id, finishedTrip.Id}
        ];

        for (Trip__c t : trips) {
            if (t.Id == futureTrip.Id) {
                System.assertEquals('To come', t.Status__c);
            } else if (t.Id == ongoingTrip.Id) {
                System.assertEquals('Ongoing', t.Status__c);
            } else if (t.Id == finishedTrip.Id) {
                System.assertEquals('Finished', t.Status__c);
            }
        }
    }
}
