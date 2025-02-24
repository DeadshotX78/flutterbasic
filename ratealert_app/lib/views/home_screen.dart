import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      double amount = double.parse(amountController.text);

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
                padding: EdgeInsets.all(16.0),
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
                      )
                          .animate()
                          .scale(duration: 200.ms, curve: Curves.easeOut),
                      const SizedBox(height: 16),
                      //loading indicator
                      if (exchangeRateProvider.isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        ).animate().fade(duration: 500.ms),
                      //error message
                      if (exchangeRateProvider.errorMessage != null)
                        Center(
                          child: Text(
                            exchangeRateProvider.errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ).animate().shake(duration: 500.ms),
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
                          )
                              .animate()
                              .fadeIn(duration: 500.ms)
                              .slideY(begin: 0.5, curve: Curves.easeOut),
                        ),
                      SizedBox(height: 24),
                      //historical exchange rate chart
                      if (exchangeRateProvider.exchangeRate != null)
                        _buildExchangeRateChart(exchangeRateProvider),
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

  Widget _buildExchangeRateChart(ExchangeRateProvider provider) {
    final rates = provider.exchangeRate!.rates.entries.toList();
    rates.sort((a, b) => a.value.compareTo(b.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: const Text(
            "Exchange Rate Trends",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 300,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < rates.length) {
                        return Text(rates[index].key);
                      }
                      return const Text("");
                    },
                    reservedSize: 30,
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: rates
                      .asMap()
                      .entries
                      .map((entry) => FlSpot(
                          entry.key.toDouble(), entry.value.value.toDouble()))
                      .toList(),
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
