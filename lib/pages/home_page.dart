import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/currency_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController amountController = TextEditingController();
  final CurrencyService currencyService = CurrencyService();

  String fromCurrency = 'SEK';
  String toCurrency = 'EUR';
  String result = 'Enter an amount to convert';

  bool notificationsEnabled = true;
  bool isLoading = false;

  final List<String> currencies = [
    'SEK',
    'EUR',
    'USD',
    'GBP',
  ];

  Future<void> convertCurrency() async {
    final double? amount = double.tryParse(amountController.text);

    if (amount == null) {
      setState(() {
        result = 'Please enter a valid number';
      });
      return;
    }

    setState(() {
      isLoading = true;
      result = 'Converting...';
    });

    try {
      final convertedAmount = await currencyService.convertCurrency(
        amount: amount,
        from: fromCurrency,
        to: toCurrency,
      );

      setState(() {
        result =
        '${amount.toStringAsFixed(2)} $fromCurrency = '
            '${convertedAmount.toStringAsFixed(2)} $toCurrency';
      });
    } catch (e) {
      setState(() {
        result = 'Could not convert currency';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CurrencyMate'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/currencymate_logo.png',
                  width: 140,
                  height: 140,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Currency Converter',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.money),
                  ),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  initialValue: fromCurrency,
                  decoration: const InputDecoration(
                    labelText: 'From',
                    border: OutlineInputBorder(),
                  ),
                  items: currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      fromCurrency = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  initialValue: toCurrency,
                  decoration: const InputDecoration(
                    labelText: 'To',
                    border: OutlineInputBorder(),
                  ),
                  items: currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      toCurrency = value!;
                    });
                  },
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : convertCurrency,
                    child: isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : const Text('Convert'),
                  ),
                ),

                const SizedBox(height: 25),

                Text(
                  result,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                SwitchListTile(
                  title: const Text('Notifications'),
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    context.go('/settings');
                  },
                  child: const Text('Open Settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}