import 'exceptions.dart';

class Validators {
  static bool validateAmount(String? input) {
    if (input == null || input.isEmpty) {
      throw InvalidAmountException('Amount cannot be empty');
    }

    try {
      final amount = double.parse(input);

      if (amount <= 0) {
        throw InvalidAmountException('Amount must be greater than 0');
      }

      if (amount > 999999999) {
        throw InvalidAmountException('Amount is too large');
      }

      return true;
    } on FormatException {
      throw InvalidAmountException('Please enter a valid number');
    }
  }

  static bool validateCurrencyCode(String? code) {
    if (code == null || code.isEmpty) {
      throw InvalidCurrencyException('Currency must be selected');
    }

    const validCodes = ['USD', 'INR', 'AUD'];
    if (!validCodes.contains(code)) {
      throw InvalidCurrencyException('Invalid currency code: $code');
    }

    return true;
  }

  static bool validateConversion({
    required String? amount,
    required String? currencyCode,
  }) {
    validateAmount(amount);
    validateCurrencyCode(currencyCode);
    return true;
  }

  static String sanitizeAmountInput(String input) {
    return input.trim();
  }
}
