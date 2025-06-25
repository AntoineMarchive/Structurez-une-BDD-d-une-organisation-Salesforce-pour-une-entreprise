// Trigger sur Opportunité, Utiliser les méthodes de la classe OpportunityTriggerHandler
trigger OpportunityTrigger on Opportunity (after update) {
    // Appel de la méthode handleAfterUpdate de la classe OpportunityTriggerHandler
    OpportunityTriggerHandler.handleAfterUpdate(Trigger.New, Trigger.oldMap);
}


// Quand mon opportunité est mise a jour, appelle ma classe OpportunityTriggerHandler pour gerer ce qui doit etre fait.