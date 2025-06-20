public class OpportunityTriggerHandler {
    public static void handleAfterUpdate(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        List<Trip__c> tripsToInsert = new List<Trip__c>();

        for (Opportunity opp : newList) {
            Opportunity oldOpp = oldMap.get(opp.Id);

            // Vérifie que le stage est passé à "Closed Won"
            if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
                Trip__c newTrip = new Trip__c(
                    Status__c = 'A venir',
                    Destination__c = opp.Destination__c,
                    Start_Date__c = opp.Start_Date__c,
                    End_Date__c = opp.End_Date__c,
                    Number_of_Participants__c = opp.Number_of_Participants__c,
                    Total_Cost__c = opp.Amount,
                    Account__c = opp.AccountId,
                    Opportunity__c = opp.Id
                );
                tripsToInsert.add(newTrip);
            }
        }

        if (!tripsToInsert.isEmpty()) {
            insert tripsToInsert;
        }
    }
}
