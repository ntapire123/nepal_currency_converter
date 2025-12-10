import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'https://api.exchangerate-api.com/v4/latest/NPR';

  static Future<Map<String, dynamic>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['rates'] as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  static Future<double> getLiveRate(String code) async {
    final rates = await fetchExchangeRates();
    final value = rates[code];
    if (value is num) {
      return value.toDouble();
    }
    return 0.0;
  }
}
