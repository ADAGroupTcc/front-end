import 'package:flutter/material.dart';

const Color cinzar = Color(0xb32d2d2d);
const Color branco = Color(0xFFFFFAFE);

class Station extends StatelessWidget {
  final String stationName; // Nome da estação que será exibido

  const Station({super.key, required this.stationName});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: cinzar, // Cor do fundo
          borderRadius: BorderRadius.circular(20), // Borda arredondada
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/target.png',
                fit: BoxFit.fitWidth,
                width: screenWidth * 0.1,
              ),
            ),
            const SizedBox(width: 10), // Espaço entre imagem e texto
            Text(
              stationName,
              style: TextStyle(
                fontFamily: 'Inter',
                color: branco,
                fontWeight: FontWeight.w300,
                fontSize: screenWidth * 0.057,
                decoration: TextDecoration.none,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
