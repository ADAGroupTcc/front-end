import 'package:flutter/material.dart';
import 'segundaTela.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretor = Color(0x500D0D0D);

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'Login'),
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
      body: Stack(
        children: [
          Image.asset(
            'assets/registerbackground.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.075),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logoadda.png',
                    fit: BoxFit.fitWidth,
                    width: screenWidth * 0.26,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                  child: Text(
                    "Bem vindo(a) ao ADDA!",
                    style: TextStyle(
                      fontSize: screenWidth * 0.132,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Amaranth',
                      decoration: TextDecoration.none,
                      height: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                  child: Text(
                    "Aqui você encontra estações de tripulantes que combinam com você, de forma altamente personalizável!",
                    style: TextStyle(
                      fontSize: screenWidth * 0.0572,
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.none,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/blackwave.png',
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Primeiros passos",
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              color: Colors.white,
                              fontFamily: "Amaranth",
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SegundaRota()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.24,
                            vertical: screenHeight * 0.012),
                        backgroundColor: branco,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: branco, width: 4),
                        ),
                      ),
                      child: Text(
                        "Crie uma conta",
                        style: TextStyle(
                          color: preto,
                          fontFamily: "Amaranth",
                          fontSize: screenWidth * 0.06,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SegundaRota()),
                        );
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
                        "Login",
                        style: TextStyle(
                          color: branco,
                          fontFamily: "Amaranth",
                          fontSize: screenWidth * 0.06,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}