import 'package:flutter/material.dart';

/// Widget que exibe o resultado da conversão num cartão estilizado.
///
/// Mostra o valor convertido de forma centralizada e com destaque.
class ConversionResultCard extends StatelessWidget {
  /// Texto com o resultado da conversão (ex: "A" ou "1010").
  final String resultText;

  /// Construtor do widget [ConversionResultCard].
  const ConversionResultCard({required this.resultText, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Sombra do cartão
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento interno do cartão
        child: Column(
          children: [
            // Título do cartão
            const Text(
              'Result:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8), // Espaço entre o título e o resultado
            // Texto do resultado da conversão
            Text(
              resultText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
