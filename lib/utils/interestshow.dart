import 'package:flutter/material.dart';

const Color transparent = Color(0x59FFFAFE);
const Color purple = Color(0xFF8D5BCA);
const Color buttonColor = Color(0xFF3D3D3D); // Cor do botão entre o preto e o roxo

class ShowInterest extends StatelessWidget {
  final String text; // Texto dentro do botão
  final String imagePath; // Caminho da imagem dentro do botão

  const ShowInterest({required this.text, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.021),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo
          children: [
            Image.asset(
              imagePath,
              height: screenHeight * 0.03,
            ),
            const SizedBox(width: 10), // Espaço entre imagem e texto
            Text(
              text,
              style: TextStyle(
                fontSize: screenHeight * 0.023,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
