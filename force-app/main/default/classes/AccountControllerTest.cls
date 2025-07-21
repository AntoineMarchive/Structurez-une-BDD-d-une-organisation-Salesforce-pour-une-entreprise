@isTest
public class AccountControllerTest {
    
    @isTest
    static void testCreateGetUpdateDeleteAccount() {
        // Création
        Account acc = new Account(Name = 'Test Account');
        AccountController.createAccount(acc);
        
        // Requête explicite ou récupération après DML (si AccountSelector fait bien le insert)
        Account accInDb = [SELECT Id, Name FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        // Récupération
        Account fetchedAcc = AccountController.getAccountById(accInDb.Id);
        System.assertEquals(accInDb.Id, fetchedAcc.Id, 'Le compte récupéré doit correspondre');
        
        // Mise à jour
        accInDb.Phone = '0102030405';
        AccountController.updateAccount(accInDb);
        Account updatedAcc = AccountController.getAccountById(accInDb.Id);
        System.assertEquals('0102030405', updatedAcc.Phone, 'Le numéro de téléphone doit être mis à jour');
        
        // Suppression
        AccountController.deleteAccountById(accInDb.Id);
        
        Test.startTest();
        try {
            AccountController.getAccountById(accInDb.Id);
            System.assert(false, 'Une exception aurait dû être levée');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('List has no rows'), 'Erreur attendue après suppression');
        }
        Test.stopTest();
    }
}