@isTest
public class OpportunityTriggerHandlerTest {

    @isTest
    static void testTripCreatedWhenOpportunityClosedWon() {
        // Création d’un compte
        Account acc = new Account(Name = 'Client Test');
        insert acc;

        // Création d’une opportunité en statut initial
        Opportunity opp = new Opportunity(
            Name = 'Voyage Groupe Test',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10),
            AccountId = acc.Id,
            Destination__c = 'Lisbonne',
            Start_date__c = Date.today().addDays(30),
            End_date__c = Date.today().addDays(35),
            Number_of_Participants__c = 25,
            Amount = 8000
        );
        insert opp;

        // Mise à jour du statut en "Closed Won" pour déclencher le trigger
        opp.StageName = 'Closed Won';
        update opp;

        // Vérification : un Trip__c doit avoir été créé
        List<Trip__c> trips = [
            SELECT Id, Status__c, Destination__c, Opportunity__c, Account__c
            FROM Trip__c
            WHERE Opportunity__c = :opp.Id
        ];

        System.assertEquals(1, trips.size(), 'Un voyage doit être créé');
        System.assertEquals('A venir', trips[0].Status__c);
        System.assertEquals('Lisbonne', trips[0].Destination__c);
        System.assertEquals(opp.Id, trips[0].Opportunity__c);
        System.assertEquals(acc.Id, trips[0].Account__c);
    }
}
