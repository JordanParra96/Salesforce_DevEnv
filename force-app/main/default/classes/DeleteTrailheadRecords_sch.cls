/**
 * @description Schedulable class to execute the DeleteTrailheadRecords_batch batch job.
 * Implements scheduled deletion of Trailhead records.
 */
public without sharing class DeleteTrailheadRecords_sch implements Schedulable {
  /**
   * @description Executes the scheduled job to delete Trailhead records by running the batch class.
   * @param context The SchedulableContext provided by the system.
   */
  public void execute(SchedulableContext context) {
    DeleteTrailheadRecords_batch badgeBatch = new DeleteTrailheadRecords_batch();
    database.executeBatch(badgeBatch);
  }
}
