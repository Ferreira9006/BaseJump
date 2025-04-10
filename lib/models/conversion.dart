import 'package:number_converter_app/functions.dart';

class Conversion {
  final String input;
  final int fromBase;
  final int toBase;
  final String result;

  Conversion({
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
