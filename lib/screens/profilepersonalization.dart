import 'package:flutter/material.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class ProfilePersonalization extends StatelessWidget {
  const ProfilePersonalization({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profile personalization page',
      home: ProfilePersonalizationPage(title: 'Profile personalization'),
    );
  }
}

class ProfilePersonalizationPage extends StatelessWidget {
  final String title;

  const ProfilePersonalizationPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return const Scaffold();
  }
}
