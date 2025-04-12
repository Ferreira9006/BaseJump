String convertBaseIdToName(int base) {
  String baseName = "";
  switch (base) {
    case 10:
      baseName = "Decimal";
      break;
    case 2:
      baseName = "Binary";
      break;
    case 8:
      baseName = "Octal";
      break;
    case 16:
      baseName = "Hexadecimal";
      break;
    default:
      baseName = "Undefined";
      break;
  }
  return baseName;
}

String convertNumber({
  required String value,
  required int convertFromBase,
  required int convertToBase,
}) {
  int result = int.parse(value, radix: convertFromBase); // Converte o valor de entrada para decimal
  return result.toRadixString(convertToBase).toUpperCase(); // Converte o resultado para letras maiúsculas
}

bool validateInput(String? value, int convertFromBase) { // Valida o valor de entrada
  if (value == null || value.trim().isEmpty) {
    return false;
  }

  try {
    int.parse(value.trim(), radix: convertFromBase); // Tenta converter o valor de entrada para o sistema numérico especificado
  } catch (e) { // Se ocorrer um erro, o valor não é válido
    return false;
  }

  return true;
}
