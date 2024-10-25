import 'package:flutter/material.dart';

const Color cinzar = Color(0xb32d2d2d);
const Color branco = Color(0xFFFFFAFE);

class StationButton extends StatelessWidget {
  final String stationName; // Nome da estação que será exibido
  final VoidCallback onPressed; // Ação ao pressionar o botão

  const StationButton(
      {super.key, required this.stationName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: cinzar, // Cor do fundo do botão
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Borda arredondada
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/target.png',
                  fit: BoxFit.fitWidth,
                  width: screenWidth * 0.1,
                ),
              ),
            ),
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
