import 'package:flutter/material.dart';

class BackgroundWidget extends StatefulWidget {
  final String imagePath;

  const BackgroundWidget({super.key, required this.imagePath});

  @override
  _BackgroundWidgetState createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Garantindo que a imagem seja dimensionada corretamente dentro dos limites da tela
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            children: [
              Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              ),
            ],
          ),
        );
      },
    );
  }
}
