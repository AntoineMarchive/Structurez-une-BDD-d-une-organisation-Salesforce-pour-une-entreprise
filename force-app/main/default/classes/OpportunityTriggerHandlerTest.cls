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
            SELECT Id, Destination__c, Start_date__c, End_date__c,
                   Number_of_participants__c, Total_cost__c, Opportunity__c, Account__c
            FROM Trip__c
            WHERE Opportunity__c = :opp.Id
        ];

        System.assertEquals(1, trips.size(), 'Un voyage doit être créé');
        Trip__c trip = trips[0];
        System.assertEquals('Lisbonne', trip.Destination__c);
        System.assertEquals(Date.today().addDays(30), trip.Start_date__c);
        System.assertEquals(Date.today().addDays(35), trip.End_date__c);
        System.assertEquals(25, trip.Number_of_participants__c);
        System.assertEquals(8000, trip.Total_cost__c);
        System.assertEquals(opp.Id, trip.Opportunity__c);
        System.assertEquals(acc.Id, trip.Account__c);
        
    }
}
