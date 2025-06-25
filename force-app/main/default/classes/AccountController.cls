// Classe de gestion des Comptes Salesforce. Utilise AccountSelector pour interagir avec la base de données.
public with sharing class AccountController {

    // Récupère un compte via son Id
    public static Account getAccountById(Id accountId) {
        return AccountSelector.getAccountById(accountId);
    }

    // Crée un nouveau compte après validation
    public static Account createAccount(Account account) {
        if (String.isEmpty(account.Name)) {
            throw new IllegalArgumentException('Le champ "Name" est requis.');
        }
        return AccountSelector.createAccount(account);
    }

    // Met à jour un compte existant
    public static Account updateAccount(Account account) {
        return AccountSelector.updateAccount(account);
    }

    // Supprime un compte via son Id
    public static void deleteAccountById(Id accountId) {
        AccountSelector.deleteAccountById(accountId);
    }
}
