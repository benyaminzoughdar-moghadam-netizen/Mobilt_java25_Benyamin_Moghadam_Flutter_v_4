import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  Future<double> convertCurrency({
    required double amount,
    required String from,
    required String to,
  }) async {
    // No conversion needed if both currencies are the same.
    if (from == to) {
      return amount;
    }

    final url = Uri.parse(
      'https://api.frankfurter.dev/v1/latest'
          '?base=$from&symbols=$to',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
      jsonDecode(response.body);

      final rate = data['rates'][to];

      if (rate == null) {
        throw Exception('Exchange rate not found');
      }

      final double exchangeRate =
      (rate as num).toDouble();

      return amount * exchangeRate;
    } else {
      throw Exception(
        'API error: ${response.statusCode}',
      );
    }
  }
}