// Classe de gestion des Contrats Salesforce. Utilise ContractSelector pour interagir avec la base de données
public with sharing class ContractController {

    // Crée un contrat avec un statut et une durée à partir d’une opportunité
    public static Contract createContractWithStatusAndTerm(Opportunity opp, String status, Integer contractTerm) {
        Contract newContract = new Contract(
            AccountId = opp.AccountId,
            // OpportunityId__c = opp.Id,
            Status = status,
            StartDate = opp.Start_Date__c,
            ContractTerm = contractTerm
        );
        return ContractSelector.createContract(newContract);
    }

    // Récupère tous les contrats liés à un compte
    public static List<Contract> getContractsByAccountId(Id accountId) {
        return ContractSelector.getContractsByAccountId(accountId);
    }

    // Met à jour le statut d’un contrat
    public static Contract updateContractStatus(Contract contractToUpdate, String status) {
        contractToUpdate.Status = status;
        return ContractSelector.updateContract(contractToUpdate);
    }

    // Supprime un contrat via son Id
    public static void deleteContractById(Id contractId) {
        ContractSelector.deleteContractById(contractId);
    }

    // Supprime un contrat lié à une opportunité
    // public static void deleteContractByOpportunityId(Id opportunityId) {
    //     ContractSelector.deleteContractByOpportunityId(opportunityId);
    // }

    // Supprime tous les contrats liés à un compte
    public static void deleteContractsByAccountId(Id accountId) {
        ContractSelector.deleteContractsByAccountId(accountId);
    }
}
