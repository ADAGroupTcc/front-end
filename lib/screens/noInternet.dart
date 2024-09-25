import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'offline'),
    );
  }
}

class LoginPage extends StatelessWidget {
  final String title;

  const LoginPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'assets/registerbackground.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Center(
                child: Text(
                  "Ops, parece que você está sem internet...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Amaranth',
                    decoration: TextDecoration.none,
                    height: 1.1,
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.03),
              child: Center(
                child: Text(
                  "Conecte-se a internet para continuar!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.054,
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none,
                    height: 1.3,
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.032),
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/astronautinha.png',
                fit: BoxFit.fitWidth,
                width: screenWidth * 0.6,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
            child: ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.361,
                    vertical: screenHeight * 0.012),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: branco, width: 2),
                ),
              ),
              child: Text(
                "Okay",
                style: TextStyle(
                  color: branco,
                  fontFamily: "Amaranth",
                  fontSize: screenWidth * 0.06,
                ),
              ),
            ),
          )
        ],
      ),
    ]));
  }
}
