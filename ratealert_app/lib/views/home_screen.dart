import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ratealert_app/providers/exchange_rate_provider.dart';
import 'package:ratealert_app/widgets/currency_selection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? baseCurrency;
  String? targetCurrency;
  double? convertedAmount;
  final TextEditingController amountController = TextEditingController();

  void convertCurrency() async {
    if (baseCurrency != null &&
        targetCurrency != null &&
        amountController.text.isNotEmpty) {
      final provider =
          Provider.of<ExchangeRateProvider>(context, listen: false);
      double amount = double.parse(amountController.text) ?? 1.0;

      if (provider.exchangeRate != null) {
        setState(() {
          convertedAmount =
              amount * (provider.exchangeRate!.rates[targetCurrency!] ?? 1.0);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final exchangeRateProvider = Provider.of<ExchangeRateProvider>(context);
    final numberFormat = NumberFormat("#,##0", "en_US");

    return Scaffold(
      appBar: AppBar(
        title: const Text("RateAlert"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth > 600
                        ? 500
                        : constraints.maxWidth * 0.9,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Select Base Currency"),
                      SizedBox(height: 8),
                      CurrencySelectionWidget(
                        currencies: [
                          "USD",
                          "EUR",
                          "GBP",
                          "JPY",
                          "NGN"
                        ], // Sample currencies
                        onCurrencySelected: (currency) {
                          setState(() {
                            baseCurrency = currency;
                            exchangeRateProvider.fetchExchangeRates(currency);
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text("Select Target Currency"),
                      SizedBox(height: 8),
                      CurrencySelectionWidget(
                        currencies: [
                          "USD",
                          "EUR",
                          "GBP",
                          "JPY",
                          "NGN"
                        ], // Sample currencies
                        onCurrencySelected: (currency) {
                          setState(() => targetCurrency = currency);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Enter Amount",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => convertCurrency(),
                        child: const Text("Convert"),
                      ),
                      const SizedBox(height: 16),
                      //loading indicator
                      if (exchangeRateProvider.isLoading)
                        const Center(child: CircularProgressIndicator()),
                      //error message
                      if (exchangeRateProvider.errorMessage != null)
                        Center(
                          child: Text(
                            exchangeRateProvider.errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      //converted amount
                      if (convertedAmount != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Converted Amount: $targetCurrency ${numberFormat.format(convertedAmount)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
