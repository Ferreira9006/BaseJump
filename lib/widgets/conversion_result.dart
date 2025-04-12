import 'package:flutter/material.dart';

class ConversionResultCard extends StatelessWidget {
  final String resultText;

  const ConversionResultCard({
    /// Constructor
    required this.resultText, // Callback function to handle changes
    super.key, // Widget Key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Result:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              resultText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
