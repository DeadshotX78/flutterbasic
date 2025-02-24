class ExchangeRateModel {
  final String baseCurrency;
  final Map<String, double> rates;
  final DateTime lastUpdated;

  ExchangeRateModel({
    required this.baseCurrency,
    required this.rates,
    required this.lastUpdated,
  });

  // Factory method to create an instance from JSON response
  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
    return ExchangeRateModel(
      baseCurrency: json["base_code"],
      rates: Map<String, double>.from(json["conversion_rates"]),
      lastUpdated: DateTime.now(), // API does not provide a timestamp
    );
  }
}
