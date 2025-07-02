@isTest
public class TripControllerTest {

    @isTest
    static void testCreateGetUpdateDeleteTrip() {
        // 1. Créer les données nécessaires : Account, Opportunity
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            AccountId = acc.Id,
            CloseDate = Date.today().addDays(30),
            StageName = 'Closed Won',
            Destination__c = 'Lisbonne',
            Number_Of_Participants__c = 20,
            Start_Date__c = Date.today().addDays(10),
            End_Date__c = Date.today().addDays(15),
            Amount = 10000
        );
        insert opp;

        // 2. Tester la création d'un voyage
        Trip__c trip = TripController.createTrip(opp);
        System.assertNotEquals(null, trip.Id, 'Trip should be inserted');
        System.assertEquals('A venir', trip.Status__c);

        // 3. Tester la récupération du voyage
        Trip__c fetchedTrip = TripController.getTripById(trip.Id);
        System.assertEquals(trip.Id, fetchedTrip.Id);

        // 4. Tester la mise à jour du voyage
        trip.Status__c = 'En cours';
        Trip__c updatedTrip = TripController.updateTrip(trip);
        System.assertEquals('En cours', updatedTrip.Status__c);

        // 5. Tester la récupération par compte
        List<Trip__c> tripsByAccount = TripController.getTripsByAccountId(acc.Id);
        System.assertEquals(1, tripsByAccount.size());

        // 6. Tester la suppression
        TripController.deleteTripById(trip.Id);
        try {
            Trip__c deleted = [SELECT Id FROM Trip__c WHERE Id = :trip.Id LIMIT 1];
            System.assert(false, 'Le voyage aurait dû être supprimé.');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('List has no rows'), 'Erreur attendue après suppression');
        }
    }
}