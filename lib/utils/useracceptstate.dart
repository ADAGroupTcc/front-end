import 'package:flutter/material.dart';

class UserAcceptState extends StatelessWidget {
  final String imagePath;
  final String name;
  final String username;
  final String status; // "pendente", "aceito" ou "recusado"

  const UserAcceptState({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.username,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Define a cor com base no status
    Color statusColor;
    String statusText;

    switch (status) {
      case 'aceito':
        statusColor = Colors.green;
        statusText = 'Aceito';
        break;
      case 'recusado':
        statusColor = Colors.red;
        statusText = 'Recusado';
        break;
      case 'pendente':
      default:
        statusColor = Colors.blue;
        statusText = 'Pendente';
        break;
    }

    return Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.067),
        child: Row(
          children: [
            // Imagem de perfil
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 30,
            ),
            const SizedBox(width: 12),
            // Informações do usuário
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '@$username',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                ),
                // Exibe o status do usuário
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
