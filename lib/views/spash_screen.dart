import 'package:flutter/material.dart';
import 'conversor_page.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Constructor

  @override
  State<SplashScreen> createState() => _SplashScreenState(); // State class for SplashScreen
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() { // inicializa o estado do widget
    super.initState(); // chama o método initState da superclasse
    Future.delayed(const Duration(seconds: 5), () { // delay de 5 segundos
      Navigator.pushReplacement( // navega para a próxima tela 
        context, // BuildContext
        MaterialPageRoute(builder: (context) => const ConverterView()), // tela de conversão
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF003945),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 200),
            const SizedBox(height: 24),
            const Text(
              'Between zeros and ones',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}