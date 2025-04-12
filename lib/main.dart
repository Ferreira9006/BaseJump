import 'package:flutter/material.dart';
import 'views/spash_screen.dart';

void main() {
  runApp(const NumberConverterApp());
}

class NumberConverterApp extends StatelessWidget {
  const NumberConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Converter',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF003945),
        scaffoldBackgroundColor: const Color(0xFF003945),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF003945),
          brightness: Brightness.dark,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

