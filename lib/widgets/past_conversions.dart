import 'package:flutter/material.dart';
import 'package:number_converter_app/models/conversion.dart';

/// Widget que exibe o resultado da conversão num cartão estilizado.
///
/// Mostra o valor convertido de forma centralizada e com destaque.
class PastConversions extends StatelessWidget {
  final List<Conversion> conversions;
  final void Function(int index) onDelete;
  final void Function() onClear;

  /// Construtor do widget [PastConversions].
  const PastConversions({
    super.key,
    required this.conversions,
    required this.onDelete,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Sombra do cartão
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento interno do cartão
        child: Column(
          children: [
            const Text(
              "Conversões anteriores",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Botão para limpar o histórico
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => onClear,
                icon: const Icon(Icons.delete_sweep, color: Colors.white),
                label: const Text(
                  "Limpar tudo",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            // Lista de conversões
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 110, // máximo que pode crescer
              ),
              child: ListView.builder(
                itemCount: conversions.length,
                itemBuilder:
                    (context, index) => Center(
                      child: ListTile(
                        title: Text(
                          conversions[index].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => onDelete(index),
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
