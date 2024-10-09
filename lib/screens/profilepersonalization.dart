import 'package:flutter/material.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile personalization page',
      home: ProfilePersonalizationPage(title: 'Profile personalization', contexto: context),
    );
  }
}

class ProfilePersonalizationPage extends StatelessWidget {
  final String title;
  final BuildContext contexto;

  const ProfilePersonalizationPage({super.key, required this.title, required this.contexto});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold();
  }
}
