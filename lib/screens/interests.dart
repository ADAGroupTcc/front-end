import 'package:addaproject/screens/profilepersonalization.dart';
import 'package:addaproject/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import '../utils/backgroundwidget.dart';
import '../utils/customtogglebutton.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class Interests extends StatelessWidget {
  const Interests({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Interests page',
      home: InterestsPage(),
    );
  }
}

class InterestsPage extends StatelessWidget {
  const InterestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const BackgroundWidget(imagePath: 'assets/profilebackground.png'),

        // Título fixo no topo
        Positioned(
          top: screenHeight * 0.12, // Ajuste conforme necessário
          left: screenWidth * 0.064,
          right: screenWidth * 0.064,
          child: Text(
            "Selecione seus interesses",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.107,
              fontWeight: FontWeight.w600,
              color: branco,
              fontFamily: 'Amaranth',
              decoration: TextDecoration.none,
              height: 1,
            ),
          ),
        ),

        // Conteúdo central com rolagem se necessário
        Positioned.fill(
          top: screenHeight * 0.25, // Para evitar sobreposição com o título
          bottom: screenHeight * 0.2, // Para evitar sobreposição com o botão
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 20.0, // Espaço horizontal entre os itens
                runSpacing: 15.0, // Espaço vertical entre as linhas
                children: List.generate(
                  18,
                      (index) {
                    return CustomToggleButton(
                      text: "Interesse $index",
                      imagePath: 'assets/transparenttarget.png',
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        // Botão "Criar Conta!" fixo na parte inferior
        Positioned(
          bottom: screenHeight * 0.1, // Ajuste conforme necessário
          left: screenWidth * 0.064,
          right: screenWidth * 0.064,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const ProfilePersonalization()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.276,
                  vertical: screenHeight * 0.012),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: branco, width: 2),
              ),
            ),
            child: IgnorePointer(
                child: RichText(
                  text: TextSpan(
                      text: "Criar Conta!",
                      style: TextStyle(
                        color: branco,
                        fontFamily: "Amaranth",
                        fontSize: screenWidth * 0.06,
                      )),
                )),
          ),
        ),

        // Botão de "Voltar" fixo
        Positioned(
          bottom: screenHeight * 0.023,
          left: screenWidth * 0.04,
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const WelcomePage()),
              );
            },
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/voltarbtn.png',
                fit: BoxFit.fitWidth,
                width: screenWidth * 0.1,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
