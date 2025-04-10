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
  int result = int.parse(value, radix: convertFromBase);
  return result.toRadixString(convertToBase).toUpperCase();
}

bool validateInput(String? value, int convertFromBase) {
  if (value == null || value.trim().isEmpty) {
    return false;
  }

  try {
    int.parse(value.trim(), radix: convertFromBase);
  } catch (e) {
    return false;
  }

  return true;
}
