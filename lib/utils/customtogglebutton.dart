import 'package:flutter/material.dart';

import '../sdk/model/Categoria.dart';

const Color transparent = Color(0x59FFFAFE);
const Color purple = Color(0xFF8D5BCA);

class CustomToggleButton extends StatefulWidget {
  final int index; // Texto dentro do botão
  final String imagePath; // Caminho da imagem dentro do botão

  const CustomToggleButton(
      {this.index = 0, required this.imagePath, super.key});

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool isSelected = false;
  int index = 0;
  final List<Categoria> categorias = SelectedCategories.allCategories;

  void toggleButton() {
    setState(() {
      isSelected = !isSelected;
    });
    if (isSelected) {
      SelectedCategories.selectedCategories.add(categorias[index].id);
      return;
    }
    SelectedCategories.selectedCategories.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    index = widget.index;
    return GestureDetector(
      onTap: toggleButton,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 12), // Aumenta o padding
        decoration: BoxDecoration(
          color: isSelected ? purple : transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              widget.imagePath,
              width: 28, // Aumenta o tamanho da imagem
              height: 28,
            ),
            const SizedBox(width: 10), // Aumenta o espaço entre imagem e texto
            Text(
              categorias[index].name,
              style: TextStyle(
                  fontSize: 19, // Aumenta o tamanho do texto
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
