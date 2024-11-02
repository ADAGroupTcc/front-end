import 'package:flutter/material.dart';

class TemporaryPopup extends StatelessWidget {
  final String message;
  final bool isAffirmative; // Define se o ícone é afirmativo ou de cancelamento

  const TemporaryPopup({
    Key? key,
    required this.message,
    this.isAffirmative = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Programar para o popup desaparecer após 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });

    return Dialog(
      backgroundColor: const Color(0xFF242424),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Ícone personalizável como imagem
            Image.asset(
              isAffirmative ? 'assets/iconcheck.png' : 'assets/iconcancel.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Como usar:
// showDialog(
//   context: context,
//   builder: (BuildContext context) => TemporaryPopup(
//     message: 'Ação cancelada',
//     isAffirmative: false,
//   ),
// );
