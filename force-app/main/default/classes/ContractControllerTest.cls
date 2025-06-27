@isTest
public class ContractControllerTest {

    @isTest
    static void testCreateUpdateDeleteContract() {
        // Données de test : compte, destination, opportunité
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Destination__c dest = new Destination__c(Name = 'Canada', Cost_Per_Person_Per_Day__c = 600);
        insert dest;

        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            AccountId = acc.Id,
            CloseDate = Date.today().addDays(30),
            StageName = 'Proposal/Price Quote',
            Start_Date__c = Date.today().addDays(10),
            End_Date__c = Date.today().addDays(20),
            Number_Of_Participants__c = 10,
            Destination__c = dest.Id
        );
        insert opp;

        // Création du contrat
        Contract con = ContractController.createContractWithStatusAndTerm(opp, 'Draft', 2);
        System.assertNotEquals(null, con.Id, 'Le contrat doit être inséré');

        // Récupération par ID d'opportunité
        Contract fetched = ContractController.getContractByOppId(opp.Id);
        System.assertEquals(con.Id, fetched.Id, 'Contrat récupéré correctement');

        // Mise à jour du statut
        Contract updated = ContractController.updateContractStatus(fetched, 'Activated');
        System.assertEquals('Activated', updated.Status, 'Statut mis à jour');

        // Suppression par ID
        ContractController.deleteContractById(updated.Id);

        // Suppression par ID opportunité (ne doit rien faire car déjà supprimé)
        ContractController.deleteContractByOpportunityId(opp.Id);

        // Suppression par ID compte (ne doit rien faire car déjà supprimé)
        ContractController.deleteContractsByAccountId(acc.Id);
    }
}
