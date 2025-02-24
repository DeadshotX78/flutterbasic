import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ratealert_app/models/exchange_rate_model.dart';

class ExchangeRateService {
//api key
  final String apikey = "07e9c7f5dd4429309c1c9c72";
  final String baseUrl = "https://v6.exchangerate-api.com/v6";

  Future<ExchangeRateModel?> getRates(String baseCurrency) async {
    final url = Uri.parse("$baseUrl/$apikey/latest/$baseCurrency");

    print("Requesting: $url"); // ✅ Log request URL

    try {
      final response = await http.get(url);

      print("Response status: ${response.statusCode}"); // ✅ Log status code
      print("Response body: ${response.body}"); // ✅ Log full response body

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ExchangeRateModel.fromJson(data);
      } else {
        print("API returned error: ${response.body}"); // ✅ Log API errors
        return null;
      }
    } catch (e) {
      print("Error making API request: $e"); // ✅ Log network errors
      return null;
    }
  }
}
