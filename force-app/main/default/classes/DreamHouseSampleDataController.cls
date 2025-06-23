/**
 * @description Controller class for managing DreamHouse sample data.
 * Provides a method to delete all sample records from custom and standard objects.
 */
public with sharing class DreamHouseSampleDataController {
  /**
   * @description Deletes all sample data records from the DreamHouse application.
   * This method removes all records from custom objects like Favorite, Property, Broker,
   * LeadAssociation, and standard Lead records associated with the company 'Dreamhouse'.
   */
  @RemoteAction
  public static void deleteAll() {
    delete [SELECT ID FROM favorite__c];
    delete [SELECT ID FROM property__c];
    delete [SELECT ID FROM broker__c];
    delete [SELECT ID FROM LeadAssociation__c];
    delete [SELECT ID FROM Lead WHERE company = 'Dreamhouse'];
  }
}
