@isTest
private class GetPropertiesApexControllerTest {
  @isTest
  static void testGetProperties() {
    // Insert properties with different Beds__c values
    Property__c prop1 = new Property__c(Name = 'Prop 1', Beds__c = 3);
    Property__c prop2 = new Property__c(Name = 'Prop 2', Beds__c = 3);
    Property__c prop3 = new Property__c(Name = 'Prop 3', Beds__c = 2);
    insert new List<Property__c>{ prop1, prop2, prop3 };

    // Reload prop1 to ensure all fields are populated
    prop1 = [SELECT Id, Beds__c FROM Property__c WHERE Id = :prop1.Id];

    // Use prop1 as the current property
    ApexPages.StandardController sc = new ApexPages.StandardController(prop1);
    GetPropertiesApexController controller = new GetPropertiesApexController(
      sc
    );

    // Call the method
    List<Property__c> result = controller.getProperties();

    // Assert: Should return only prop2 (same Beds__c, different Id)
    System.assertEquals(1, result.size(), 'Should return one property');
    System.assertEquals(
      prop2.Id,
      result[0].Id,
      'Should return the property with the same Beds__c'
    );
  }
}
