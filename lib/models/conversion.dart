import 'package:number_converter_app/utils/functions.dart';

/// Modelo que representa uma conversão entre duas bases numéricas.
/// Armazena o número original, a base de origem, a base de destino e o resultado convertido.
class Conversion {
  /// Número de entrada fornecido pelo utilizador.
  final String input;

  /// Base numérica de origem (2, 8, 10, 16).
  final int fromBase;

  /// Base numérica de destino (2, 8, 10, 16).
  final int toBase;

  /// Resultado da conversão (em formato string).
  final String result;

  /// Construtor da classe [Conversion].
  /// Recebe os dados necessários para representar uma conversão.
  Conversion({
    required this.input,
    required this.fromBase,
    required this.toBase,
    required this.result,
  });

  /// Retorna a conversão formatada como texto legível, ex:
  /// `1010 (Binary) → A (Hexadecimal)`
  @override
  String toString() {
    return '$input (${convertBaseIdToName(fromBase)}) → $result (${convertBaseIdToName(toBase)})';
  }
}
