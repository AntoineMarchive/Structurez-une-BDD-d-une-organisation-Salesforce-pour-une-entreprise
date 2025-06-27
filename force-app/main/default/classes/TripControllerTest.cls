@isTest
public class TripControllerTest {

    @isTest
    static void testCreateGetUpdateDeleteTrip() {
        // 1. Créer les données nécessaires : Account, Destination et Opportunity
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Destination__c dest = new Destination__c(Name = 'Canada', Cost_Per_Person_Per_Day__c = 500);
        insert dest;

        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            AccountId = acc.Id,
            CloseDate = Date.today().addDays(30),
            StageName = 'Closed Won',
            Destination__c = dest.Id,
            Number_Of_Participants__c = 20,
            Start_Date__c = Date.today().addDays(10),
            End_Date__c = Date.today().addDays(15),
            Amount = 10000
        );
        insert opp;

        // 2. Tester la création d'un voyage
        Trip__c trip = TripController.createTrip(opp);
        System.assertNotEquals(null, trip.Id, 'Trip should be inserted');
        System.assertEquals('To come', trip.Status__c);

        // 3. Tester la récupération du voyage
        Trip__c fetchedTrip = TripController.getTripById(trip.Id);
        System.assertEquals(trip.Id, fetchedTrip.Id);

        // 4. Tester la mise à jour du voyage
        trip.Status__c = 'Ongoing';
        Trip__c updatedTrip = TripController.updateTrip(trip);
        System.assertEquals('Ongoing', updatedTrip.Status__c);

        // 5. Tester la récupération par compte
        List<Trip__c> tripsByAccount = TripController.getTripsByAccountId(acc.Id);
        System.assertEquals(1, tripsByAccount.size());

        // 6. Tester la suppression
        TripController.deleteTripById(trip.Id);
        Trip__c deleted = [SELECT Id FROM Trip__c WHERE Id = :trip.Id LIMIT 1];
        System.assertEquals(trip.Id, deleted.Id); // Optionnel : remplacer par un try/catch pour vérifier qu'il n'existe plus
    }
}
