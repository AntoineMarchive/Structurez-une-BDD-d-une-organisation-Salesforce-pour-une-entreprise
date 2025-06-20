trigger OpportunityTrigger on Opportunity (after update) {
    OpportunityTriggerHandler.handleAfterUpdate(Trigger.New, Trigger.oldMap);
}
