public with sharing class TripUpdateStatusBatchController {
    public static void runTripUpdateStatusBatch() {
        TripUpdateStatusBatch batch = new TripUpdateStatusBatch();
        Database.executeBatch(batch);
    }
}
