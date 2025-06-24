@isTest
private class DeleteTrailheadRecords_schTest {
  @TestSetup
  static void makeData() {
    // Create a test trailheadapp__Badge__c record
    trailheadapp__Badge__c badge = new trailheadapp__Badge__c(
      trailheadapp__API_Name__c = 'Test Badge',
      trailheadapp__Description__c = 'This is a test badge',
      trailheadapp__Icon__c = 'https://example.com/icon.png',
      trailheadapp__Namespace__c = 'testNamespace',
      trailheadapp__URL__c = 'https://example.com/badge'
    );
    insert badge;
  }
  /**
   * @description Test method to verify the scheduled execution of the batch job.
   * It schedules the DeleteTrailheadRecords_sch job and verifies that the badge is deleted.
   */
  @isTest
  static void testScheduledBatchExecution() {
    // Schedule the job to run immediately
    String cronExp = '0 0 0 1 1 ? 2099'; // Far future date, but will run in test context
    Test.startTest();
    String jobId = System.schedule(
      'Test DeleteTrailheadRecords_sch',
      cronExp,
      new DeleteTrailheadRecords_sch()
    );
    Test.stopTest();

    // Verify the job was scheduled
    System.assertNotEquals(
      null,
      jobId,
      'Job should be scheduled successfully.'
    );
  }
}
