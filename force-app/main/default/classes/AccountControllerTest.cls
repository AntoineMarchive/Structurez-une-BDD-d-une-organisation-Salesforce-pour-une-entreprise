@isTest
public class AccountControllerTest {
    
    @isTest
    static void testCreateGetUpdateDeleteAccount() {
        // Création
        Account acc = new Account(Name = 'Test Account');
        AccountController.createAccount(acc);

        // Récupération
        Account fetchedAcc = AccountController.getAccountById(acc.Id);
        System.assertEquals(acc.Id, fetchedAcc.Id, 'Le compte récupéré doit correspondre');

        // Mise à jour
        acc.Phone = '0102030405';
        AccountController.updateAccount(acc); 
        Account updatedAcc = AccountController.getAccountById(acc.Id);
        System.assertEquals('0102030405', updatedAcc.Phone, 'Le numéro de téléphone doit être mis à jour');

        // Suppression
        AccountController.deleteAccountById(acc.Id);

        Test.startTest();
        try {
            AccountController.getAccountById(acc.Id);
            System.assert(false, 'Une exception aurait dû être levée');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('List has no rows'), 'Erreur attendue après suppression');
        }
        Test.stopTest();
    }
}
