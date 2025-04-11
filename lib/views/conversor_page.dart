import 'package:flutter/material.dart';
import '../models/conversion.dart';
import '../utils/functions.dart';
import '../widgets/dropdown_button.dart';
class ConverterView extends StatefulWidget {
  const ConverterView({super.key});

  @override
  State<ConverterView> createState() => _ConverterView();
}

class _ConverterView extends State<ConverterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController valueController = TextEditingController();
  List<Conversion> pastConversions = [];
  int convertFromBase = 10; // Default values para evitar erros
  int convertToBase = 2; // Default values para evitar erros
  String conversionResult = "";
  String resultText = "";

  void handleConversion() {
    if (_formKey.currentState!.validate()) {
      String input = valueController.text.trim();

      conversionResult = convertNumber(
        value: valueController.text,
        convertFromBase: convertFromBase,
        convertToBase: convertToBase,
      );

      final conversion = Conversion(
        input: input,
        fromBase: convertFromBase,
        toBase: convertToBase,
        result: conversionResult,
      );

      setState(() {
        pastConversions.insert(0, conversion);
        resultText =
        '$input in ${convertBaseIdToName(convertFromBase)} is $conversionResult in ${convertBaseIdToName(convertToBase)}';
      });
    }
  }

  void clearInputs() {
    setState(() {
      conversionResult = "";
      resultText = "";
      convertFromBase = 10;
      convertToBase = 2;
      valueController.clear();
      pastConversions.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Converter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: clearInputs,
            tooltip: 'Clear',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/logo.png', height: 200),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter a number',
                    ),
                    controller: valueController,
                    validator: (value) {
                      if (!validateInput(value, convertFromBase)) {
                        resultText = "";
                        return 'Invalid number.';
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ConversionDropdown(
                        value: convertFromBase,
                        onChanged:
                            (val) => setState(() => convertFromBase = val!),
                      ),
                      ConversionDropdown(
                        value: convertToBase,
                        onChanged:
                            (val) => setState(() => convertToBase = val!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text("Convert"),
                      onPressed: handleConversion,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (conversionResult.isNotEmpty) ...[
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Result:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        resultText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            if (pastConversions.isNotEmpty) ...[
              const Divider(thickness: 1.5, color: Colors.white, height: 80),
              const Text(
                "Conversões anteriores",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: pastConversions.length,
                  itemBuilder:
                      (context, index) => Center(
                    child: Text(
                      pastConversions[index].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
