/// Converte um ID de base numérica para o respetivo nome legível.
String convertBaseIdToName(int base) => switch (base) {
  10 => "Decimal",
  2 => "Binary",
  8 => "Octal",
  16 => "Hexadecimal",
  _ => "Desconhecida",
};

/// Converte um número de uma base para outra.
///
/// [value] é o número a converter (em formato de texto).
/// [convertFromBase] é a base numérica original.
/// [convertToBase] é a base numérica de destino.
///
/// Retorna o número convertido como string em letras maiúsculas.
String convertNumber({
  required String value,
  required int convertFromBase,
  required int convertToBase,
}) {
  int result = int.parse(value, radix: convertFromBase);
  return result.toRadixString(convertToBase).toUpperCase();
}

/// Valida se o valor fornecido é válido para a base de origem.
///
/// [value] é o input do utilizador (pode ser null ou vazio).
/// [convertFromBase] é a base numérica a validar.
///
/// Retorna `true` se o valor for válido para essa base.
bool validateInput(String? value, int convertFromBase) {
  if (value == null || value.trim().isEmpty) {
    return false;
  }

  try {
    int.parse(value.trim(), radix: convertFromBase);
  } catch (_) {
    return false;
  }

  return true;
}
