public without sharing class CurrencyConverter {
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
    return amount;
  }
}
