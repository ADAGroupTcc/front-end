import 'package:flutter/material.dart';
import '../utils/backgroundwidget.dart';
import '../utils/popups/confirmation.dart';
import '../utils/popups/temporary.dart';
import 'register.dart';
import 'login.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login page',
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    // Exibe o popup temporário assim que a tela carrega
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => ConfirmationPopup(
          message: 'Tem certeza que deseja cancelar?',
          // Texto do segundo popup
          onConfirm: () {
            // Ação ao confirmar
            Navigator.of(context).pop();
          },
          onCancel: () {
            // Ação ao cancelar
            Navigator.of(context).pop();
          },
        ),
      );

      // Atraso para exibir o segundo popup após o primeiro desaparecer
      Future.delayed(const Duration(seconds: 3), () {
        showDialog(
          context: context,
          builder: (BuildContext context) => TemporaryPopup(
            message: 'Ação cancelada', // Texto do primeiro popup
            isAffirmative: false, // Define o ícone como "cancelar"
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundWidget(imagePath: 'assets/welcomebackground.png'),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.083),
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/logoadda.png',
                      fit: BoxFit.fitWidth,
                      width: screenWidth * 0.26,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.064),
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
                        )),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
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
                              builder: (context) => const Login()),
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
                    ),
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
