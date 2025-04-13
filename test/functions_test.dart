// Importa a biblioteca de testes do Flutter
import 'package:flutter_test/flutter_test.dart';

// Importa o ficheiro com as funções a testar
import 'package:number_converter_app/utils/functions.dart';

void main() {
  // Teste unitário simples para a função que converte o ID da base para o nome legível
  test("Testing base convert id to name function (convertBaseIdToName)", () {
    expect(convertBaseIdToName(10), "Decimal"); // Espera "Decimal" para base 10
    expect(convertBaseIdToName(2), "Binary"); // Espera "Binary" para base 2
    expect(convertBaseIdToName(8), "Octal"); // Espera "Octal" para base 8
    expect(
      convertBaseIdToName(16),
      "Hexadecimal",
    ); // Espera "Hexadecimal" para base 16
    expect(
      convertBaseIdToName(24),
      "Desconhecida",
    ); // Base inválida → resultado por omissão
  });

  // Agrupa todos os testes relacionados com a função validateInput
  group('validateInput', () {
    // Testa se retorna falso quando o input é nulo
    test('retorna false se o input for null', () {
      expect(validateInput(null, 10), isFalse);
    });

    // Testa se retorna falso quando o input é uma string vazia
    test('retorna false se o input estiver vazio', () {
      expect(validateInput('', 10), isFalse);
    });

    // Testa se retorna falso quando o número não é válido para a base fornecida
    test('retorna false se o número não for válido para a base', () {
      expect(
        validateInput('2', 2),
        isFalse,
      ); // "2" não é válido em binário (base 2)
    });

    // Testa se retorna verdadeiro para um número válido na base indicada
    test('retorna true para número válido', () {
      expect(
        validateInput('1010', 2),
        isTrue,
      ); // "1010" é válido em base binária
    });
  });
}
