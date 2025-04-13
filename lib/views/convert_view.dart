import 'package:flutter/material.dart';
import 'package:number_converter_app/constants/constants.dart';
import 'package:number_converter_app/widgets/conversion_result.dart';
import 'package:number_converter_app/models/conversion.dart';
import 'package:number_converter_app/utils/functions.dart';
import 'package:number_converter_app/widgets/dropdown_button.dart';

/// Lista que guarda todas as conversões feitas (histórico).
List<Conversion> pastConversions = [];

/// Bases padrão selecionadas por defeito (decimal → binário).
int convertFromBase = baseDecimal;
int convertToBase = baseBinary;

/// Texto do resultado da conversão atual.
String conversionResult = "";

/// Texto formatado a ser exibido no Card de resultado.
String resultText = "";

/// Guarda a última conversão eliminada (para permitir desfazer).
Conversion? lastDeleted;
int? lastDeletedIndex;

/// Ecrã principal da aplicação que permite converter entre diferentes bases.
class ConverterView extends StatefulWidget {
  const ConverterView({super.key});

  @override
  State<ConverterView> createState() => _ConverterView();
}

class _ConverterView extends State<ConverterView> {
  /// Chave usada para validar o formulário.
  final _formKey = GlobalKey<FormState>();

  /// Controlador do campo de texto.
  final TextEditingController valueController = TextEditingController();

  /// Executa a conversão e atualiza o estado.
  void handleConversion() {
    if (_formKey.currentState!.validate()) {
      String input = valueController.text.trim();

      conversionResult = convertNumber(
        value: input,
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

  /// Limpa os campos e reinicia as bases para os valores padrão.
  void clearInputs() {
    setState(() {
      conversionResult = "";
      resultText = "";
      convertFromBase = baseDecimal;
      convertToBase = baseBinary;
      valueController.clear();
    });
  }

  /// Limpa todo o histórico de conversões.
  void clearHistory() {
    setState(() {
      pastConversions.clear();
      lastDeleted = null;
      lastDeletedIndex = null;
    });
  }

  /// Remove uma conversão específica e permite desfazer a ação.
  void deleteConversion(int index) {
    setState(() {
      lastDeleted = pastConversions[index];
      lastDeletedIndex = index;
      pastConversions.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Conversão removida.'),
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

  /// Interface visual do ecrã de conversão.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Converter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: clearInputs,
            tooltip: 'Limpar campos',
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

            // Formulário de entrada e seleção de bases
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Campo de entrada
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insere um número',
                    ),
                    controller: valueController,
                    validator: (value) {
                      if (!validateInput(value, convertFromBase)) {
                        return 'Número inválido para esta base.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Dropdowns de seleção de bases
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

                  // Botão de conversão
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: handleConversion,
                      child: const Text("Converter"),
                    ),
                  ),
                ],
              ),
            ),

            // Card com o resultado
            if (conversionResult.isNotEmpty) ...[
              const SizedBox(height: 20),
              ConversionResultCard(resultText: resultText),
            ],

            // Histórico de conversões
            if (pastConversions.isNotEmpty) ...[
              const Divider(thickness: 1.5, color: Colors.white, height: 80),
              const Text(
                "Conversões anteriores",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Botão para limpar o histórico
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

              // Lista de conversões
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
