import 'package:flutter/material.dart';
import '../models/currency_model.dart';

class CurrencyDropdown extends StatefulWidget {
  final Function(String) onChanged;
  final String initialCurrency;

  const CurrencyDropdown({
    Key? key,
    required this.onChanged,
    this.initialCurrency = 'USD',
  }) : super(key: key);

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  late String selectedCurrency;

  @override
  void initState() {
    super.initState();
    selectedCurrency = widget.initialCurrency;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Target Currency',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: DropdownButton<String>(
            value: selectedCurrency,
            isExpanded: true,
            underline: const SizedBox(),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            items:
                CurrencyData.supportedCurrencies.map((Currency currency) {
              return DropdownMenuItem<String>(
                value: currency.code,
                child: Row(
                  children: [
                    Text(
                      currency.flagEmoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currency.code,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          currency.name,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedCurrency = newValue;
                });
                widget.onChanged(newValue);
              }
            },
          ),
        ),
      ],
    );
  }
}
