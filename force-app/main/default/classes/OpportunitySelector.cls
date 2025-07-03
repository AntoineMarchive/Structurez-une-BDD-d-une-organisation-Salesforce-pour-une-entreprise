// Classe de gestion des Opportunités Salesforce. Interagit avec la base de données.
public with sharing class OpportunitySelector {

    // Récupère une opportunité par son Id
    public static Opportunity getOpportunityById(Id opportunityId) {
        return [
            SELECT Id, Name, AccountId, Type, CloseDate, StageName, Destination__c,
                   Number_of_participants__c, Start_date__c, End_date__c, Amount
            FROM Opportunity
            WHERE Id = :opportunityId
            LIMIT 1
        ];
    }

    // Récupère toutes les opportunités rattachées à un compte
    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId) {
        return [
            SELECT Id, Name, AccountId, Type, CloseDate, StageName, Destination__c,
                   Number_of_participants__c, Start_date__c, End_date__c, Amount
            FROM Opportunity
            WHERE AccountId = :accountId
        ];
    }

    // Récupère toutes les opportunités à un certain stade
    public static List<Opportunity> getOpportunitiesByStageName(String stageName) {
        return [
            SELECT Id, Name, AccountId, Type, CloseDate, StageName, Destination__c,
                   Number_of_participants__c, Start_date__c, End_date__c, Amount
            FROM Opportunity
            WHERE StageName = :stageName
        ];
    }

    // Récupère un contrat lié à une opportunité
    public static Contract getContractByOppId(Id opportunityId) {
        return [
            SELECT Id, ContractNumber, AccountId, Status, StartDate, EndDate, ContractTerm 
            FROM Contract  
            LIMIT 1
        ];
    }

    // Crée une opportunité
    public static Opportunity createOpportunity(Opportunity newOpp) {
        insert newOpp;
        return newOpp;
    }

    // Met à jour une opportunité
    public static Opportunity updateOpportunity(Opportunity oppToUpdate) {
        update oppToUpdate;
        return oppToUpdate;
    }

    // Supprime une opportunité par Id
    public static void deleteOpportunityById(Id opportunityId) {
        Opportunity oppToDelete = [SELECT Id FROM Opportunity WHERE Id = :opportunityId LIMIT 1];
        delete oppToDelete;
    }

    // Supprime toutes les opportunités liées à un compte
    public static void deleteOpportunitiesByAccountId(Id accountId) {
        List<Opportunity> oppsToDelete = [SELECT Id FROM Opportunity WHERE AccountId = :accountId];
        delete oppsToDelete;
    }
}
