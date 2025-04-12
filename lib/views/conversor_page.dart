import 'package:flutter/material.dart';
import 'package:number_converter_app/widgets/conversion_result.dart';
import '../models/conversion.dart';
import '../utils/functions.dart';
import '../widgets/dropdown_button.dart';

class ConverterView extends StatefulWidget {
  const ConverterView({super.key});

  @override
  State<ConverterView> createState() => _ConverterView();
}

class _ConverterView extends State<ConverterView> {
  final _formKey = GlobalKey<FormState>(); // Key para validar o formulário
  final TextEditingController valueController =
      TextEditingController(); // Controller do Input
  List<Conversion> pastConversions =
      []; // Lista onde guarda todas as conversões feitas
  int convertFromBase = 10; // Default values para evitar erros
  int convertToBase = 2; // Default values para evitar erros
  String conversionResult = ""; // Resultado da conversão
  String resultText = ""; // Texto a ser exibido na tela

  Conversion? lastDeleted;
  int? lastDeletedIndex;

  void handleConversion() {
    if (_formKey.currentState!.validate()) {
      // Verifica se o formulário é válido
      String input = valueController.text.trim(); // Remove espaços em branco

      conversionResult = convertNumber(
        value: valueController.text, // Valor a ser convertido
        convertFromBase: convertFromBase, // Base de origem
        convertToBase: convertToBase,
      ); // Realiza a conversão

      final conversion = Conversion(
        input: input,
        fromBase: convertFromBase,
        toBase: convertToBase,
        result: conversionResult,
      ); // Cria um objeto de conversão

      setState(() {
        pastConversions.insert(0, conversion);
        resultText =
            '$input in ${convertBaseIdToName(convertFromBase)} is $conversionResult in ${convertBaseIdToName(convertToBase)}';
      }); // Atualiza o estado da tela com o resultado da conversão
    }
  }

  void clearInputs() {
    setState(() {
      conversionResult = "";
      resultText = "";
      convertFromBase = 10;
      convertToBase = 2;
      valueController.clear();
    });
  }

  void deleteConversion(int index) {
    setState(() {
      lastDeleted = pastConversions[index];
      lastDeletedIndex = index;
      pastConversions.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Conversão removida.'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            if (lastDeleted != null && lastDeletedIndex != null) {
              setState(() {
                pastConversions.insert(lastDeletedIndex!, lastDeleted!);
              });
            }
          },
        ),
      ),
    );
  }

  void clearHistory() {
    setState(() {
      pastConversions.clear();
      lastDeleted = null;
      lastDeletedIndex = null;
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
            tooltip: 'Clear', // Tooltip para o botão de limpar
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
                        return 'Invalid number.'; // Mensagem de erro para número inválido
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
                      onPressed:
                          handleConversion, // Chama a função de conversão
                    ),
                  ),
                ],
              ),
            ),

            if (conversionResult.isNotEmpty) ...[
              const SizedBox(height: 20),
              ConversionResultCard(resultText: resultText),
            ],

            if (pastConversions.isNotEmpty) ...[
              const Divider(thickness: 1.5, color: Colors.white, height: 80),
              const Text(
                "Conversões anteriores",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: clearHistory,
                  icon: const Icon(Icons.delete_sweep, color: Colors.white),
                  label: const Text(
                    "Limpar tudo",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: pastConversions.length,
                  itemBuilder:
                      (context, index) => Center(
                        child: ListTile(
                          title: Text(
                            pastConversions[index].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => deleteConversion(index),
                          ),
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
