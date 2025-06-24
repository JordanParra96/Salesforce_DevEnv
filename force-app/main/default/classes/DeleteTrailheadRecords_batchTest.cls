/* @description This class is a test for the DeleteTrailheadRecords_batch Apex batch class.
 * It ensures that the batch can be executed without errors.
 */
@isTest
private class DeleteTrailheadRecords_batchTest {
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
   * @description Test method to verify the batch execution.
   * It creates a test trailheadapp__Badge__c record, executes the batch,
   * and verifies that the record is deleted.
   */
  @isTest
  static void testBatchExecution() {
    // Verify the record was created
    List<trailheadapp__Badge__c> badges = [
      SELECT Id
      FROM trailheadapp__Badge__c
    ];
    System.assertEquals(1, badges.size(), 'One badge should be created.');

    // Execute the batch
    Test.startTest();
    DeleteTrailheadRecords_batch batch = new DeleteTrailheadRecords_batch();
    Database.executeBatch(batch);
    Test.stopTest();

    // Verify the badge was deleted
    badges = [SELECT Id FROM trailheadapp__Badge__c];
    System.assertEquals(0, badges.size(), 'The badge should be deleted.');
  }
}
