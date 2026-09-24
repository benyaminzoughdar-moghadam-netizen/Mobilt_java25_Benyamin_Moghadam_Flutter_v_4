import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/home_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const CurrencyMateApp());
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);

class CurrencyMateApp extends StatelessWidget {
  const CurrencyMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CurrencyMate',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
    );
  }
}