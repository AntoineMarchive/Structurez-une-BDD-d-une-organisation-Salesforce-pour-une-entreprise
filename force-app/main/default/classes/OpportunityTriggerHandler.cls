// Gestion des événements déclenchés par OpportunityTrigger
public class OpportunityTriggerHandler {
    // Méthode pour gérer les événements après la mise à jour des opportunités
    public static void handleAfterUpdate(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        List<Trip__c> tripsToInsert = new List<Trip__c>();
        
        // Vérification que la liste des nouvelles opportunités n'est pas vide
        for (Opportunity opp : newList) {
            Opportunity oldOpp = oldMap.get(opp.Id);
            // Vérification que l'opportunité est passée à l'état 'Closed Won'
            if (opp.IsWon  && !oldOpp.IsWon) {
                Trip__c newTrip = new Trip__c(
                    Destination__c = opp.Destination__c,
                    Start_date__c = opp.Start_date__c,
                    End_date__c = opp.End_date__c,
                    Number_of_participants__c = opp.Number_of_participants__c,
                    Total_cost__c = opp.Amount,
                    Account__c = opp.AccountId,
                    Opportunity__c = opp.Id
                );
                tripsToInsert.add(newTrip);
            }
        }
// Insertion des nouveaux voyages si la liste n'est pas vide
        if (!tripsToInsert.isEmpty()) {
            insert tripsToInsert;
        }
    }
}

//Si l'opportunité passe à l'état 'Closed Won', un nouveau voyage est créé 