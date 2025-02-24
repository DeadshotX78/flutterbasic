import 'package:flutter/material.dart';
import 'package:ratealert_app/models/exchange_rate_model.dart';
import 'package:ratealert_app/services/rate_api_service.dart';

class ExchangeRateProvider extends ChangeNotifier {
  ExchangeRateModel? exchangeRate;
  bool isLoading = false;
  String? errorMessage;

  final ExchangeRateService _apiService = ExchangeRateService();

  Future<void> fetchExchangeRates(String baseCurrency) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      //debbugging log
      print("Fetching exchange rates for: $baseCurrency");

      exchangeRate = await _apiService.getRates(baseCurrency);
      if (exchangeRate != null) {
        print("Exchange rates loaded: ${exchangeRate!.rates}");
        // Log response
      } else {
        print("Exchange rate model is null");
        // Log if data is null
      }
    } catch (e) {
      errorMessage = "Failed to fetch exchange rates";
      print("Error fetching exchange rates: $e");
      // Log the error
    }
    isLoading = false;

    notifyListeners();
  }
}
