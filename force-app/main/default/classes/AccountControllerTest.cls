@isTest
public class AccountControllerTest {
    
    @isTest
    static void testCreateGetUpdateDeleteAccount() {
        // Création
        Account acc = new Account(Name = 'Test Account');
        Account createdAcc = AccountController.createAccount(acc);
        System.assertNotEquals(null, createdAcc.Id, 'Le compte doit être inséré');

        // Récupération
        Account fetchedAcc = AccountController.getAccountById(createdAcc.Id);
        System.assertEquals(createdAcc.Id, fetchedAcc.Id, 'Le compte récupéré doit correspondre');

        // Mise à jour
        createdAcc.Phone = '0102030405';
        Account updatedAcc = AccountController.updateAccount(createdAcc);
        System.assertEquals('0102030405', updatedAcc.Phone, 'Le numéro de téléphone doit être mis à jour');

        // Suppression
        AccountController.deleteAccountById(createdAcc.Id);
        Test.startTest();
        try {
            AccountController.getAccountById(createdAcc.Id);
            System.assert(false, 'Une exception aurait dû être levée');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('List has no rows'), 'Erreur attendue après suppression');
        }
        Test.stopTest();
    }
}
