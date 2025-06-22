global with sharing class DreamHouseSampleDataController {
  @RemoteAction
  global static void deleteAll() {
    delete [SELECT ID FROM favorite__c];
    delete [SELECT ID FROM property__c];
    delete [SELECT ID FROM broker__c];
    delete [SELECT ID FROM LeadAssociation__c];
    delete [SELECT ID FROM Lead WHERE company = 'Dreamhouse'];
  }
}
