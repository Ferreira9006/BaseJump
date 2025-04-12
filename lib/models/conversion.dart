import '../utils/functions.dart';

class Conversion { // Conversão para armazenar os dados de conversão
  final String input;
  final int fromBase;
  final int toBase;
  final String result;

  Conversion({ // Constructor para a conversão de números
    required this.input,
    required this.fromBase,
    required this.toBase,
    required this.result,
  });

  @override
  String toString() {
    return '$input (${convertBaseIdToName(fromBase)}) → $result (${convertBaseIdToName(toBase)})';
  }
}
