import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String username;
  final bool isAdmin;

  const UserProfileCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.username,
    this.isAdmin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
            // Exibe "adm" apenas se isAdmin for true
            if (isAdmin)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'adm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
