// Pour que le Batch s'execute automatiquement tous les jours.

public with sharing class TripUpdateStatusBatchScheduler implements Schedulable {
    public void execute(SchedulableContext context) {
        TripUpdateStatusBatch.runTripUpdateStatusBatch();
    }
}
