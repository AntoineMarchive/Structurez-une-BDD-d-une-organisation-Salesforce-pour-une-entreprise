@isTest
public class ContractControllerTest {

    // Méthode utilitaire pour créer un compte + opportunité de test
    private static Opportunity createTestOpportunity() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            AccountId = acc.Id,
            CloseDate = Date.today().addDays(30),
            StageName = 'Proposal/Price Quote',
            Start_date__c = Date.today().addDays(10),
            End_date__c = Date.today().addDays(20),
            Number_Of_participants__c = 10,
            Destination__c = 'Canada'
        );
        insert opp;

        return opp;
    }

    @isTest
    static void testCreateAndUpdateContract() {
        Opportunity opp = createTestOpportunity();

        // Création
        Contract con = ContractController.createContractWithStatusAndTerm(opp, 'Draft', 2);
        System.assertNotEquals(null, con.Id, 'Le contrat doit être inséré');

        // Mise à jour du statut
        Contract updated = ContractController.updateContractStatus(con, 'Activated');
        System.assertEquals('Activated', updated.Status, 'Le statut doit être mis à jour');
    }

    @isTest
    static void testDeleteContractById() {
        Opportunity opp = createTestOpportunity();

        // Création d’un contrat
        Contract con = ContractController.createContractWithStatusAndTerm(opp, 'Draft', 2);

        // Suppression
        ContractController.deleteContractById(con.Id);

        // Vérification que le contrat n’existe plus
        List<Contract> results = [SELECT Id FROM Contract WHERE Id = :con.Id];
        System.assertEquals(0, results.size(), 'Le contrat doit avoir été supprimé');
    }

    @isTest
    static void testGetContractsByAccountId() {
        Opportunity opp = createTestOpportunity();

        // Création d’un contrat
        Contract con = ContractController.createContractWithStatusAndTerm(opp, 'Draft', 3);

        // Test de récupération via l’Account
        List<Contract> contracts = ContractController.getContractsByAccountId(opp.AccountId);
        System.assertEquals(1, contracts.size(), 'Un contrat doit être récupéré pour ce compte');
        System.assertEquals(con.Id, contracts[0].Id, 'Le contrat récupéré doit correspondre à celui créé');
    }

    @isTest
    static void testDeleteContractsByAccountId() {
        Opportunity opp = createTestOpportunity();

        // Création de deux contrats
        Contract con1 = ContractController.createContractWithStatusAndTerm(opp, 'Draft', 2);
        Contract con2 = ContractController.createContractWithStatusAndTerm(opp, 'Draft', 2);

        // Suppression de tous les contrats liés au compte
        ContractController.deleteContractsByAccountId(opp.AccountId);

        // Vérification qu’il ne reste aucun contrat
        List<Contract> remaining = [SELECT Id FROM Contract WHERE AccountId = :opp.AccountId];
        System.assertEquals(0, remaining.size(), 'Tous les contrats doivent avoir été supprimés');
    }
}
