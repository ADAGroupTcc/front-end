import 'package:addaproject/screens/profilepersonalization.dart';
import 'package:addaproject/screens/welcomescreen.dart';
import '../utils/customtextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'login.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Register page',
      home: RegisterPage(title: 'Register'),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final String title;

  const RegisterPage({super.key, required this.title});

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
                "Crie sua conta!",
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
            const CustomTextField(label: 'Nome', inputType: TextInputType.text),
            const CustomTextField(
                label: 'Sobrenome', inputType: TextInputType.text),
            const CustomTextField(
                label: 'E-mail', inputType: TextInputType.emailAddress),
            const CustomTextField(label: 'CPF', inputType: TextInputType.text),
            const CustomTextField(
                label: 'Crie uma senha',
                inputType: TextInputType.visiblePassword),
            const CustomTextField(
                label: 'Confirme sua senha',
                inputType: TextInputType.visiblePassword),
            const SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.05, bottom: screenHeight * 0.01),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.313,
                      vertical: screenHeight * 0.012),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: branco, width: 2),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                      text: "Continuar",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfilePersonalizationPage(
                                        title: 'Profile personalization')),
                          );
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
                  const TextSpan(text: 'Já tem conta? '),
                  TextSpan(
                      text: 'Faça login aqui!',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: screenWidth * 0.046,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LoginPage(title: 'Login')),
                          );
                        })
                ])),
          ],
        ),
        Positioned(
            bottom: screenHeight * 0.023,
            left: screenWidth * 0.04,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const WelcomePage(title: 'Welcome!')),
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
            )),
      ]),
    );
  }
}
