import 'package:flutter/material.dart';
import 'package:number_converter_app/constants/constants.dart';

/// Widget reutilizável que representa um DropdownButton para seleção de base numérica.
///
/// Este dropdown permite escolher entre Decimal, Binário, Octal e Hexadecimal.
/// Recebe um valor atual e uma função de callback para tratar mudanças.
class ConversionDropdown extends StatelessWidget {
  /// Valor atualmente selecionado no dropdown.
  final int value;

  /// Função a executar quando o utilizador seleciona uma nova base.
  final void Function(int?) onChanged;

  /// Construtor do widget [ConversionDropdown].
  const ConversionDropdown({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: value, // Base atualmente selecionada
      onChanged: onChanged, // Callback quando o utilizador muda a seleção
      items: const [
        // Item: Decimal
        DropdownMenuItem(
          value: baseDecimal,
          child: Row(
            children: [Icon(Icons.pin), SizedBox(width: 8), Text('Decimal')],
          ),
        ),
        // Item: Binário
        DropdownMenuItem(
          value: baseBinary,
          child: Row(
            children: [Icon(Icons.code), SizedBox(width: 8), Text('Binary')],
          ),
        ),
        // Item: Octal
        DropdownMenuItem(
          value: baseOctal,
          child: Row(
            children: [Icon(Icons.blur_on), SizedBox(width: 8), Text('Octal')],
          ),
        ),
        // Item: Hexadecimal
        DropdownMenuItem(
          value: baseHexadecimal,
          child: Row(
            children: [
              Icon(Icons.grid_view),
              SizedBox(width: 8),
              Text('Hexadecimal'),
            ],
          ),
        ),
      ],
    );
  }
}
