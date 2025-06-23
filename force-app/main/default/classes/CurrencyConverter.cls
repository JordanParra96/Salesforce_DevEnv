/**
 * @description  This class provides a method to convert currency amounts between different currencies using Apex code.
 */
public without sharing class CurrencyConverter {
  /**
   * @description Converts a currency amount from one currency to another using Apex code.
   * @param fromCurrency The ISO code of the currency to convert from.
   *  @param toCurrency The ISO code of the currency to convert to.
   * @param amount The amount in the fromCurrency to be converted.
   *  @return The converted amount in the toCurrency.
   */
  public static Decimal convertCurrencyWithApexCode(
    String fromCurrency,
    String toCurrency,
    Decimal amount
  ) {
    Map<String, Decimal> conversionRates = new Map<String, Decimal>();
    List<CurrencyType> currencyTypes = [
      SELECT IsoCode, ConversionRate
      FROM CurrencyType
      WHERE IsoCode IN (:fromCurrency, :toCurrency)
      WITH SYSTEM_MODE
    ];

    for (CurrencyType curr : currencyTypes) {
      conversionRates.put(curr.IsoCode, curr.ConversionRate);
    }

    Decimal conversionRate = conversionRates.get(fromCurrency);
    amount = amount / conversionRate;

    if (toCurrency != 'USD') {
      conversionRate = conversionRates.get(toCurrency);
      amount = amount * conversionRate;
    }

    // Ensure the amount is rounded to two decimal places
    amount = Math.round(amount * 100) / 100;
    return amount;
  }
}
