import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color branco = Color(0xFFFFFAFE);
const Color brancor = Color(0x45FFFAFE);
const Color preto = Color(0xFF0D0D0D);

class SearchBarWithNotification extends StatelessWidget {
  const SearchBarWithNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: brancor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: 'Buscar em Minhas estações',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              print('Notificação pressionada');
            },
          ),
        ],
      ),
    );
  }
}
