@IsTest
public class DreamhouseTests {
  static testMethod void testController() {
    // Create a test user for runAs
    Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
    User u = new User(
      Alias = 'standt',
      Email = 'standarduser@testorg.com',
      EmailEncodingKey = 'UTF-8',
      LastName = 'Testing',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US',
      ProfileId = p.Id,
      TimeZoneSidKey = 'America/Los_Angeles',
      Username = 'standarduser@testorg.com'
    );
    insert u;

    System.runAs(u) {
      DreamHouseSampleDataController.deleteAll();
      System.assertEquals(0, [SELECT COUNT() FROM favorite__c]);
      System.assertEquals(0, [SELECT COUNT() FROM favorite__c]);
      System.assertEquals(0, [SELECT COUNT() FROM property__c]);
      System.assertEquals(0, [SELECT COUNT() FROM broker__c]);
      System.assertEquals(0, [SELECT COUNT() FROM LeadAssociation__c]);
      System.assertEquals(
        0,
        [SELECT COUNT() FROM Lead WHERE company = 'Dreamhouse']
      );
    }
  }

  static testMethod void testGetPropertiesApexController() {
    // Create a test user for runAs
    Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
    User u = new User(
      Alias = 'standt2',
      Email = 'standarduser2@testorg.com',
      EmailEncodingKey = 'UTF-8',
      LastName = 'Testing2',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US',
      ProfileId = p.Id,
      TimeZoneSidKey = 'America/Los_Angeles',
      Username = 'standarduser2@testorg.com'
    );
    insert u;

    System.runAs(u) {
      Property__c p1 = new Property__c(
        Name = 'Prop 1',
        Beds__c = 2,
        Baths__c = 2,
        Price__c = 1000
      );
      Property__c p2 = new Property__c(
        Name = 'Prop 2',
        Beds__c = 2,
        Baths__c = 2,
        Price__c = 2000
      );
      insert p1;
      insert p2;

      PageReference pref = Page.Similar_Properties;
      pref.getParameters().put('id', p1.id);
      Test.setCurrentPage(pref);

      ApexPages.StandardController con = new ApexPages.StandardController(p1);
      GetPropertiesApexController ext = new GetPropertiesApexController(con);
      System.assertEquals(1, ext.getProperties().size());
    }
  }

  static testMethod void testDreamhouseProspects() {
    // Create a test user for runAs
    Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
    User u = new User(
      Alias = 'standt3',
      Email = 'standarduser3@testorg.com',
      EmailEncodingKey = 'UTF-8',
      LastName = 'Testing3',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US',
      ProfileId = p.Id,
      TimeZoneSidKey = 'America/Los_Angeles',
      Username = 'standarduser3@testorg.com'
    );
    insert u;

    System.runAs(u) {
      Lead l = new Lead(LastName = 'the Bear', Company = 'Dreamhouse');
      insert l;
      DreamhouseProspects dhp = new DreamhouseProspects();
      System.assertEquals(1, dhp.getLeads().size());
      dhp.sortList();
      dhp.sortOrder = 'LastName';
      System.assertEquals(1, dhp.getLeads().size());
      //List<Lead> leads = dhp.getLeads();
    }
  }
}
