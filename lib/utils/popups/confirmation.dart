import 'package:addaproject/utils/messagebubble.dart';
import 'package:flutter/material.dart';

class ConfirmationPopup extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationPopup({
    Key? key,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: const Color(0xFF242424),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.2,
                            vertical: screenHeight * 0.012),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: white, width: 2),
                        ),
                      ),
                      child: const Text('Sim', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.2,
                            vertical: screenHeight * 0.012),
                        backgroundColor: white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: white, width: 2),
                        ),
                      ),
                      child: const Text('Não', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
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
//   builder: (BuildContext context) => ConfirmationPopup(
//     message: 'Tem certeza que deseja cancelar?',
//     onConfirm: () {
//       // Ação ao confirmar
//       Navigator.of(context).pop();
//     },
//     onCancel: () {
//       // Ação ao cancelar
//       Navigator.of(context).pop();
//     },
//   ),
// );
