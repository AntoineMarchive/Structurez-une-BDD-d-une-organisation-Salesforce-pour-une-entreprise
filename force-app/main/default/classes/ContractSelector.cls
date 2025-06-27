// Classe de gestion des contrats Salesforce. Interagit avec la base de données.
public with sharing class ContractSelector {

    // Crée un contrat
    public static Contract createContract(Contract contract) {
        insert contract;
        return contract;
    }

    // Récupère un contrat lié à une opportunité
    public static Contract getContractByOppId(Id opportunityId) {
        return [
            SELECT Id, ContractNumber, AccountId, OpportunityId__c, Status, StartDate, EndDate, ContractTerm 
            FROM Contract 
            WHERE OpportunityId__c = :opportunityId 
            LIMIT 1
        ];
    }

    // Récupère tous les contrats liés à un compte
    public static List<Contract> getContractsByAccountId(Id accountId) {
        return [
            SELECT Id, ContractNumber, AccountId, OpportunityId__c, Status, StartDate, EndDate, ContractTerm 
            FROM Contract 
            WHERE AccountId = :accountId
        ];
    }

    // Met à jour un contrat
    public static Contract updateContract(Contract contractToUpdate) {
        update contractToUpdate;
        return contractToUpdate;
    }

    // Supprime un contrat via son Id
    public static void deleteContractById(Id contractId) {
        Contract contractToDelete = [
            SELECT Id 
            FROM Contract 
            WHERE Id = :contractId 
            LIMIT 1
        ];
        delete contractToDelete;
    }

    // Supprime un contrat lié à une opportunité
    public static void deleteContractByOpportunityId(Id opportunityId) {
        Contract contractToDelete = [
            SELECT Id 
            FROM Contract 
            WHERE OpportunityId__c = :opportunityId 
            LIMIT 1
        ];
        delete contractToDelete;
    }

    // Supprime tous les contrats liés à un compte
    public static void deleteContractsByAccountId(Id accountId) {
        List<Contract> contractsListToDelete = [
            SELECT Id 
            FROM Contract 
            WHERE AccountId = :accountId
        ];
        delete contractsListToDelete;
    }
}
