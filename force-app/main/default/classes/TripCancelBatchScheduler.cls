// planifiation automatique des annulations de voyages

public with sharing class TripCancelBatchScheduler implements Schedulable {
    public void execute(SchedulableContext context) {
        TripCancelBatch batch = new TripCancelBatch();
        Database.executeBatch(batch);
    }
}
