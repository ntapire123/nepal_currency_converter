import '../services/currency_service.dart';
import '../utils/validators.dart';
import '../utils/exceptions.dart';

class CurrencyController {
  String _targetCurrency = 'USD';
  double _convertedAmount = 0.0;
  bool _isError = false;
  String _errorMessage = '';

  String get targetCurrency => _targetCurrency;
  double get convertedAmount => _convertedAmount;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  void setTargetCurrency(String currency) {
    try {
      Validators.validateCurrencyCode(currency);
      _targetCurrency = currency;
      _clearError();
    } on InvalidCurrencyException catch (e) {
      _setError(e.message);
    }
  }

  void convert(String amountInput) {
    try {
      final sanitized = Validators.sanitizeAmountInput(amountInput);

      Validators.validateConversion(
        amount: sanitized,
        currencyCode: _targetCurrency,
      );

      final amount = double.parse(sanitized);
      _convertedAmount = CurrencyService.convertNPRToCurrency(
        nprAmount: amount,
        targetCurrencyCode: _targetCurrency,
      );

      _clearError();
    } on InvalidAmountException catch (e) {
      _setError(e.message);
    } on InvalidCurrencyException catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError('An unexpected error occurred: $e');
    }
  }

  void _setError(String message) {
    _isError = true;
    _errorMessage = message;
  }

  void _clearError() {
    _isError = false;
    _errorMessage = '';
  }
}
