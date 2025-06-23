/**
 * @description  This class provides methods for book-related operations, such as applying discounts.
 */
public with sharing class MyHelloWorld {
  /**
   * @description Applies a 10% discount to the Price__c field of each Book__c record in the provided list.
   * @param books List of Book__c records to apply the discount to.
   */
  public static void applyDiscount(Book__c[] books) {
    for (Book__c b : books) {
      b.Price__c *= 0.9;
    }
    system.debug(LoggingLevel.DEBUG, 'Test debug');
  }
}
