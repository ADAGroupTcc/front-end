import 'package:flutter/material.dart';

class SegundaRota extends StatelessWidget {
  const SegundaRota({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Segunda Rota (tela)"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Retornar !'),
        ),
      ),
    );
  }
}