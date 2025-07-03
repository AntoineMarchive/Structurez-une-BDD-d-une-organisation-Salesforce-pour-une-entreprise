@isTest
public class TripUpdateStatusBatchTest {

    @isTest
    static void testTripUpdateStatusBatch() {
        // Créer un compte
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Trip 1 : à venir (start date > today)
        Trip__c futureTrip = new Trip__c(
            Destination__c = 'Rome',
            Account__c = acc.Id,
            Start_date__c = Date.today().addDays(10),
            End_date__c = Date.today().addDays(15),
           Number_of_participants__c = 15,
            Status__c = 'Brouillon'
        );

        // Trip 2 : en cours (today entre start et end)
        Trip__c ongoingTrip = new Trip__c(
            Destination__c = 'Paris',
            Account__c = acc.Id,
            Start_date__c = Date.today().addDays(-2),
            End_date__c = Date.today().addDays(3),
           Number_of_participants__c = 12,
            Status__c = 'Brouillon'
        );

        // Trip 3 : terminé (end date < today)
        Trip__c finishedTrip = new Trip__c(
            Destination__c = 'Tokyo',
            Account__c = acc.Id,
            Start_date__c = Date.today().addDays(-10),
            End_date__c = Date.today().addDays(-5),
           Number_of_participants__c = 20,
            Status__c = 'Brouillon'
        );

        insert new List<Trip__c>{futureTrip, ongoingTrip, finishedTrip};

        // Lancer le batch
        Test.startTest();
        TripUpdateStatusBatch batch = new TripUpdateStatusBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        // Vérifier les résultats
        List<Trip__c> trips = [
            SELECT Id, Status__c FROM Trip__c
            WHERE Id IN :new List<Id>{futureTrip.Id, ongoingTrip.Id, finishedTrip.Id}
        ];

        for (Trip__c t : trips) {
            if (t.Id == futureTrip.Id) {
                System.assertEquals('A venir', t.Status__c, 'Le voyage futur doit être marqué "A venir"');
            } else if (t.Id == ongoingTrip.Id) {
                System.assertEquals('En cours', t.Status__c, 'Le voyage en cours doit être "En cours"');
            } else if (t.Id == finishedTrip.Id) {
                System.assertEquals('Terminé', t.Status__c, 'Le voyage terminé doit être "Terminé"');
            }
        }
    }
}
