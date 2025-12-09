import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/currency_input_field.dart';
import '../widgets/currency_dropdown.dart';
import '../widgets/result_display.dart';
import '../providers/currency_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nepal Currency Converter'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Convert NPR to Other Currencies',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CurrencyInputField(
                        controller: _amountController,
                        hint: 'Enter amount in NPR',
                      ),
                      const SizedBox(height: 20),
                      CurrencyDropdown(
                        onChanged: (currency) {
                          context
                              .read<CurrencyProvider>()
                              .setTargetCurrency(currency);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Consumer<CurrencyProvider>(
                builder: (context, provider, _) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_amountController.text.isNotEmpty) {
                        provider.convertCurrency(
                          double.parse(_amountController.text),
                        );
                      }
                    },
                    child: const Text(
                      'Convert',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              Consumer<CurrencyProvider>(
                builder: (context, provider, _) {
                  return ResultDisplay(
                    amount: _amountController.text,
                    targetCurrency: provider.targetCurrency,
                    convertedAmount: provider.convertedAmount,
                    isError: provider.isError,
                    errorMessage: provider.errorMessage,
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
