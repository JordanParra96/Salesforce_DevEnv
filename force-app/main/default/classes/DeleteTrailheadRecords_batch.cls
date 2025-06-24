/**
 * @description Batch class to delete all trailheadapp__Badge__c records.
 * Tracks successes and failures during batch execution.
 */
public class DeleteTrailheadRecords_batch implements Database.Batchable<SObject>, Database.Stateful {
  private List<Id> successes = new List<Id>();
  private List<Id> failures = new List<Id>();
  private final String queryString = 'SELECT Id, Name FROM trailheadapp__Badge__c';
  @testVisible
  private static String result = '';
  @testVisible
  private Boolean throwError = false;

  /**
   * @description Starts the batch process by returning a QueryLocator for trailheadapp__Badge__c records.
   * @param context The batch context.
   * @return Database.QueryLocator for the batch scope.
   */
  public Database.QueryLocator start(Database.BatchableContext context) {
    return Database.getQueryLocator(queryString);
  }

  /**
   * @description Executes the batch delete operation for the given scope of trailheadapp__Badge__c records.
   * @param context The batch context.
   * @param scope The list of trailheadapp__Badge__c records to delete in this batch.
   */
  public void execute(
    Database.BatchableContext context,
    List<trailheadapp__Badge__c> scope
  ) {
    // Batch Processing
    List<Database.DeleteResult> saveResults = new List<Database.DeleteResult>();

    saveResults = Database.delete(scope, false);
    for (Database.DeleteResult sr : saveResults) {
      if (sr.isSuccess()) {
        successes.add(sr.id);
      } else {
        failures.add(sr.id);
      }
    }
  }

  /**
   * @description Called after all batches are processed; summarizes the results of the batch execution.
   * @param context The batch context.
   */
  public void finish(Database.BatchableContext context) {
    DeleteTrailheadRecords_batch.result =
      'Successes: ' +
      successes.size() +
      ' Failures: ' +
      failures.size();
  }
}
