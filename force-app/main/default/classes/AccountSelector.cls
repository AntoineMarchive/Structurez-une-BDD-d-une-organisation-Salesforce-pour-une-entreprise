// Classe de gestion des Comptes Salesforce. Interagit avec la base de données.
public with sharing class AccountSelector {

    // Récupère un compte par son Id
    public static Account getAccountById(Id accountId) {
        return [
            SELECT Id, Name, Type, Industry, Phone, Website,
                   BillingStreet, BillingPostalCode, BillingCity, BillingCountry
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];
    }

    // Crée un compte
    public static Account createAccount(Account account) {
        insert account;
        return account;
    }

    // Met à jour un compte
    public static Account updateAccount(Account account) {
        update account;
        return account;
    }

    // Supprime un compte par Id
    public static void deleteAccountById(Id accountId) {
        Account accToDelete = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
        delete accToDelete;
    }
}
