/**
 * @description Apex controller for retrieving Property__c records with similar attributes.
 * Provides logic for fetching properties with matching Beds__c values, excluding the current property.
 */
public without sharing class GetPropertiesApexController {
  private final Property__c prop;

  /**
   * @description Constructor for GetPropertiesApexController.
   * Initializes the controller with the current Property__c record from the standard controller.
   * @param stdController The standard controller for Property__c.
   */
  public GetPropertiesApexController(
    ApexPages.StandardController stdController
  ) {
    if (!Test.isRunningTest()) {
      stdController.addFields(
        new List<String>{
          'Beds__c',
          'Baths__c',
          'Price__c',
          'Broker__c',
          'Status__c'
        }
      );
    }
    this.prop = (Property__c) stdController.getRecord();
  }

  /**
   * @description Retrieves a list of Property__c records with the same Beds__c value as the current property,
   * excluding the current property itself.
   * @return List<Property__c> - List of matching properties.
   */
  public List<Property__c> getProperties() {
    List<Property__c> properties = [
      SELECT Id, Name, Beds__c, Baths__c, Price__c, Broker__c, Status__c
      FROM Property__c
      WHERE Id != :prop.Id AND Beds__c = :prop.Beds__c
      WITH SYSTEM_MODE
    ];
    return properties;
  }
}
