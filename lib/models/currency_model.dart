dart
class Currency {
  final String code;
  final String name;
  final String symbol;
  final double exchangeRate; // 1 unit = X NPR
  final String flagEmoji;

  Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.exchangeRate,
    required this.flagEmoji,
  });

  double convertFromNPR(double nprAmount) {
    return nprAmount / exchangeRate;
  }

  double convertToNPR(double amount) {
    return amount * exchangeRate;
  }

