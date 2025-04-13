// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:number_converter_app/utils/functions.dart';

void main() {
  group("convertBaseIdToName", () {
    test("deve retornar Decimal para 10", () {
      expect(convertBaseIdToName(10), "Decimal");
    });

    test("deve retornar Binary para 2", () {
      expect(convertBaseIdToName(2), "Binary");
    });

    test("deve retornar Octal para 8", () {
      expect(convertBaseIdToName(8), "Octal");
    });

    test("deve retornar Hexadecimal para 16", () {
      expect(convertBaseIdToName(16), "Hexadecimal");
    });
  });

  group('validateInput', () {
    test('retorna false se o input for null', () {
      expect(validateInput(null, 10), isFalse);
    });

    test('retorna false se o input estiver vazio', () {
      expect(validateInput('', 10), isFalse);
    });

    test('retorna false se o número não for válido para a base', () {
      expect(validateInput('2', 2), isFalse); // 2 não existe em binário
    });

    test('retorna true para número válido', () {
      expect(validateInput('1010', 2), isTrue);
    });
  });
}
