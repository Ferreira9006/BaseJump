import 'package:flutter/material.dart';

class ConversionDropdown extends StatelessWidget {
  final int value;
  final void Function(int?) onChanged;

  const ConversionDropdown({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: value,
      items: const [
        DropdownMenuItem(value: 10, child: Text('Decimal')),
        DropdownMenuItem(value: 2, child: Text('Binary')),
        DropdownMenuItem(value: 8, child: Text('Octal')),
        DropdownMenuItem(value: 16, child: Text('Hexadecimal')),
      ],
      onChanged: onChanged,
    );
  }
}
