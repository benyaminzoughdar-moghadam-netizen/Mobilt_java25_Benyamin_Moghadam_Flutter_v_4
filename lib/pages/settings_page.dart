import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController nameController = TextEditingController();

  double textSize = 16;
  String preferredCurrency = 'SEK';
  String savedName = '';
  bool isLoading = true;

  final List<String> currencies = [
    'SEK',
    'EUR',
    'USD',
    'GBP',
  ];

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final loadedName = prefs.getString('name') ?? '';
    final loadedCurrency = prefs.getString('preferredCurrency') ?? 'SEK';
    final loadedTextSize = prefs.getDouble('textSize') ?? 16;

    if (!mounted) return;

    setState(() {
      nameController.text = loadedName;
      savedName = loadedName;
      preferredCurrency = loadedCurrency;
      textSize = loadedTextSize;
      isLoading = false;
    });
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'name',
      nameController.text,
    );

    await prefs.setString(
      'preferredCurrency',
      preferredCurrency,
    );

    await prefs.setDouble(
      'textSize',
      textSize,
    );

    if (!mounted) return;

    setState(() {
      savedName = nameController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings saved locally'),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.settings,
                  size: 80,
                ),

                const SizedBox(height: 20),

                const Text(
                  'App Settings',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  initialValue: preferredCurrency,
                  decoration: const InputDecoration(
                    labelText: 'Preferred currency',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.currency_exchange),
                  ),
                  items: currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      preferredCurrency = value!;
                    });
                  },
                ),

                const SizedBox(height: 30),

                Text(
                  'Text size: ${textSize.round()}',
                  style: TextStyle(
                    fontSize: textSize,
                  ),
                ),

                Slider(
                  value: textSize,
                  min: 12,
                  max: 30,
                  divisions: 18,
                  label: textSize.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      textSize = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveSettings,
                    child: const Text('Save Settings'),
                  ),
                ),

                const SizedBox(height: 25),

                if (savedName.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            'Saved locally',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('Name: $savedName'),
                          Text(
                            'Preferred currency: $preferredCurrency',
                          ),
                          Text(
                            'Text size: ${textSize.round()}',
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text(
                    'Back to Currency Converter',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}