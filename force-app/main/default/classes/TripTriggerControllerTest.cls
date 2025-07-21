@isTest
public class TripTriggerControllerTest {

    @isTest
    static void testTripDateValidation() {
        // Création d’un compte (requis si Account__c est obligatoire)
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Trip invalide : Start_date >= End_date
        Trip__c invalidTrip = new Trip__c(
            Status__c = 'A venir',
            Start_date__c = Date.today().addDays(10),
            End_date__c = Date.today().addDays(5),
            Number_of_participants__c = 15,
            Destination__c = 'Lisbonne',
            Account__c = acc.Id
        );

        Test.startTest();
        try {
            insert invalidTrip;
            System.assert(false, 'Une erreur aurait dû être levée à cause des dates incohérentes');
        } catch (DmlException e) {
            System.assert(
                e.getMessage().contains('La date de début doit être antérieure à la date de fin du voyage'),
                'Le message d\'erreur attendu n\'a pas été trouvé.'
            );
        }
        Test.stopTest();
    }
}
