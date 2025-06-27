@isTest
public class TripTriggerControllerTest {

    @isTest
    static void testTripDateValidation() {
        // Création d’un Trip avec une date de début > date de fin → doit générer une erreur
        Trip__c invalidTrip = new Trip__c(
            Name = 'Voyage Test',
            Status__c = 'To come',
            Start_Date__c = Date.today().addDays(10),
            End_Date__c = Date.today().addDays(5),
            Number_of_Participants__c = 15
        );

        Test.startTest();
        try {
            insert invalidTrip;
            System.assert(false, 'Une erreur aurait dû être levée à cause des dates incohérentes');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('The start date should be earlier than the end date'), 'Le message d\'erreur attendu n\'a pas été trouvé.');
        }
        Test.stopTest();
    }

}
