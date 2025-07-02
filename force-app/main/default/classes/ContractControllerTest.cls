@isTest
public class ContractControllerTest {

    @isTest
    static void testCreateUpdateDeleteContract() {
        // Données de test : compte et opportunité
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Supposons que Destination__c est une simple chaîne (picklist ou texte), pas un objet personnalisé
        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            AccountId = acc.Id,
            CloseDate = Date.today().addDays(30),
            StageName = 'Proposal/Price Quote',
            Start_Date__c = Date.today().addDays(10),
            End_Date__c = Date.today().addDays(20),
            Number_Of_Participants__c = 10,
            Destination__c = 'Canada'
        );
        insert opp;

        // Création du contrat
        Contract con = ContractController.createContractWithStatusAndTerm(opp, 'Draft', 2);
        System.assertNotEquals(null, con.Id, 'Le contrat doit être inséré');

        // Mise à jour du statut
        Contract updated = ContractController.updateContractStatus(con, 'Activated');
        System.assertEquals('Activated', updated.Status, 'Statut mis à jour');

        // Suppression par ID
        ContractController.deleteContractById(updated.Id);

        // Suppression par ID compte (ne doit rien faire car déjà supprimé)
        ContractController.deleteContractsByAccountId(acc.Id);
    }
}
