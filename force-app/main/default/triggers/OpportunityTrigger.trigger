trigger OpportunityTrigger on Opportunity (after update) {
    OpportunityTriggerHandler.handleAfterUpdate(Trigger.new);
}
