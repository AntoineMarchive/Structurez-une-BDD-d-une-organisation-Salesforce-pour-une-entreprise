public with sharing class TripCancelBatchController {
    public static void runTripCancelBatch() {
        TripCancelBatch batch = new TripCancelBatch();
        Database.executeBatch(batch);
    }
}
