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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Aumenta o padding
      decoration: BoxDecoration(
        color: buttonColor, // Cor do botão fixa
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 28, // Tamanho da imagem
            height: 28,
          ),
          const SizedBox(width: 10), // Espaço entre imagem e texto
          Text(
            text,
            style: const TextStyle(
              fontSize: 19, // Tamanho do texto
              color: Colors.white, // Cor do texto
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
