abstract class CurrencyConverterException implements Exception {
  final String message;

  CurrencyConverterException(this.message);

  @override
  String toString() => message;
}

class InvalidAmountException extends CurrencyConverterException {
  InvalidAmountException(String message) : super(message);
}

class InvalidCurrencyException extends CurrencyConverterException {
  InvalidCurrencyException(String message) : super(message);
}

class ApiException extends CurrencyConverterException {
  ApiException(String message) : super(message);
}

class NetworkException extends CurrencyConverterException {
  NetworkException(String message) : super(message);
}
