import 'package:flutter/material.dart';

class CurrencySelectionWidget extends StatefulWidget {
  final List<String> currencies;
  final Function(String) onCurrencySelected;

  const CurrencySelectionWidget({
    super.key,
    required this.currencies,
    required this.onCurrencySelected,
  });

  @override
  State<CurrencySelectionWidget> createState() =>
      _CurrencySelectionWidgetState();
}

class _CurrencySelectionWidgetState extends State<CurrencySelectionWidget> {
  TextEditingController searchController = TextEditingController();
  List<String> filteredCurrencies = [];
  String? selectedCurrency;

  @override
  void initState() {
    super.initState();
    filteredCurrencies = widget.currencies;
  }

  void filterCurrencies(String query) {
    setState(() {
      filteredCurrencies = widget.currencies
          .where((currency) =>
              currency.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search currency...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onChanged: filterCurrencies,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200, // Ensures the ListView has a defined height
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: filteredCurrencies.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredCurrencies[index]),
                onTap: () {
                  setState(() {
                    selectedCurrency = filteredCurrencies[index];
                  });
                  widget.onCurrencySelected(filteredCurrencies[index]);
                  // Navigator.pop(context);
                },
              );
            },
          ),
        ),
        if (selectedCurrency != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Selected: $selectedCurrency"),
          ),
      ],
    );
  }
}
