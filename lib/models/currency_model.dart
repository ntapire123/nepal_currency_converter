```dart
class Currency {
  final String code;
  final String name;
  final String symbol;
  final double exchangeRateToNpr; // 1 unit = X NPR

  Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.exchangeRateToNpr,
  });

  double convertFromNpr(double nprAmount) {
    return nprAmount / exchangeRateToNpr;
  }
}

class CurrencyData {
  static final List<Currency> supportedCurrencies = [
    Currency(
      code: 'USD',
      name: 'US Dollar',
      symbol: '\$',
      exchangeRateToNpr: 133.0,
    ),
    Currency(
      code: 'INR',
      name: 'Indian Rupee',
      symbol: '₹',
      exchangeRateToNpr: 1.6,
    ),
    Currency(
      code: 'AUD',
      name: 'Australian Dollar',
      symbol: 'A\$',
      exchangeRateToNpr: 88.0,
    ),
  ];

  static Currency getByCode(String code) {
    return supportedCurrencies.firstWhere(
      (c) => c.code == code,
      orElse: () => supportedCurrencies.first,
    );
  }
}
