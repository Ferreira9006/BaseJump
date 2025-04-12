import 'package:flutter/material.dart';

class ConversionDropdown extends StatelessWidget {
  final int value;
  final void Function(int?) onChanged;

  const ConversionDropdown({ /// Constructor
    required this.value, 
    required this.onChanged, // Callback function to handle changes
    super.key, /// Key for the widget
  }); 

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>( /// DropdownButton widget to select conversion type
      value: value,
     items: const [
  DropdownMenuItem(
    value: 10,
    child: Row(children: [Icon(Icons.pin), SizedBox(width: 8), Text('Decimal')]),
  ),  
  DropdownMenuItem(
    value: 2,
    child: Row(children: [Icon(Icons.code), SizedBox(width: 8), Text('Binary')]),
  ),
  DropdownMenuItem(
    value: 8,
    child: Row(children: [Icon(Icons.blur_on), SizedBox(width: 8), Text('Octal')]),
  ),
  DropdownMenuItem(
    value: 16,
    child: Row(children: [Icon(Icons.grid_view), SizedBox(width: 8), Text('Hexadecimal')]),
  ),
],
      onChanged: onChanged,
    );
  }
}
