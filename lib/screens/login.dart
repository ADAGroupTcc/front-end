import '../utils/CustomTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'register.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login page',
      home: LoginPage(title: 'Login', contexto: context),
    );
  }
}

class LoginPage extends StatelessWidget {
  final String title;
  final BuildContext contexto;

  const LoginPage({super.key, required this.title, required this.contexto});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/logoadda.png',
                fit: BoxFit.fitWidth,
                width: screenWidth * 0.26,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.064,
                  vertical: screenHeight * 0.02),
              child: Text(
                "Bem vindo(a) de volta!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.107,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Amaranth',
                  decoration: TextDecoration.none,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const CustomTextField(
                label: 'Email', inputType: TextInputType.emailAddress),
            const CustomTextField(
                label: 'Senha', inputType: TextInputType.visiblePassword),
            const SizedBox(height: 4),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.064),
                  child: Text(
                    "Esqueceu a senha?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: screenWidth * 0.046,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.07, bottom: screenHeight * 0.01),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
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
                child: RichText(
                  text: TextSpan(
                      text: "Login",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // enviar um email com a senha
                        },
                      style: TextStyle(
                        color: branco,
                        fontFamily: "Amaranth",
                        fontSize: screenWidth * 0.06,
                      )),
                ),
              ),
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: screenWidth * 0.046,
                      decoration: TextDecoration.none,
                    ),
                    children: [
                  const TextSpan(text: 'ainda não tem conta? '),
                  TextSpan(
                      text: 'Cadastre-se!',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: screenWidth * 0.046,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage(title: 'Register', contexto: context)),
                          );
                        })
                ])),
            SizedBox(height: screenHeight * 0.177),
          ],
        ),
        Positioned(
            bottom: screenHeight * 0.023,
            left: screenWidth * 0.04,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(contexto);
              },
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/voltarbtn.png',
                  fit: BoxFit.fitWidth,
                  width: screenWidth * 0.1,
                ),
              ),
            )),
      ]),
    );
  }
}
