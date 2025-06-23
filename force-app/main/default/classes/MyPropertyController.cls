/**
 * @description Controller class for retrieving similar Property__c records based on search criteria.
 */
public with sharing class MyPropertyController {
  /**
   * @description Retrieves similar Property__c records based on the provided search criteria.
   * @param criteriaWrapper Wrapper object containing search parameters.
   * @return List of Property__c records matching the criteria.
   */
  @AuraEnabled
  public static List<Property__c> getSimilarProperties(
    PropertySearchCriteria criteriaWrapper
  ) {
    if (criteriaWrapper.searchCriteria == 'Bedrooms') {
      return [
        SELECT
          Id,
          Name,
          Beds__c,
          Baths__c,
          Price__c,
          Broker__c,
          Status__c,
          Thumbnail__c
        FROM Property__c
        WHERE
          Id != :criteriaWrapper.recordId
          AND Beds__c = :criteriaWrapper.beds
        WITH SYSTEM_MODE
      ];
    } else {
      Decimal range;
      if (criteriaWrapper.priceRange == null) {
        range = 100000;
      } else {
        range = criteriaWrapper.priceRange;
      }
      return [
        SELECT
          Id,
          Name,
          Beds__c,
          Baths__c,
          Price__c,
          Broker__c,
          Status__c,
          Thumbnail__c
        FROM Property__c
        WHERE
          Id != :criteriaWrapper.recordId
          AND Price__c > :criteriaWrapper.price - range
          AND Price__c < :criteriaWrapper.price + range
        WITH SYSTEM_MODE
      ];
    }
  }

  /**
   * @description Wrapper class for property search criteria.
   */
  public class PropertySearchCriteria {
    @AuraEnabled
    public Id recordId;
    @AuraEnabled
    public String searchCriteria;
    @AuraEnabled
    public Decimal beds;
    @AuraEnabled
    public Decimal price;
    @AuraEnabled
    public Decimal priceRange;
  }
}
