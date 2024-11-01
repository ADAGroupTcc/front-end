import 'package:addaproject/screens/welcomescreen.dart';
import '../sdk/LocalCache.dart';
import '../utils/backgroundwidget.dart';
import 'package:addaproject/sdk/AddaSDK.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../utils/customtextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/menuBar.dart';
import 'register.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final AddaSDK _sdk = AddaSDK();
  final _cache = LocalCache();

  void _showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informação'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _signInUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    try {
      final authResponse = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final authUid = authResponse.user!.uid;
      final userInfoSnapshot = await _firebaseDatabase.ref().child('users').child(authUid).get();
      if(!userInfoSnapshot.exists) {
        throw Exception("User not found. You need to sing up first");
      }
      final values = userInfoSnapshot.value as dynamic;
      final userId = values["user_id"];

      final user = await _sdk.getUserByID(userId);
      if (user == null) {
        throw Exception("get user by id returned null");
      }

      await _cache.saveUserSession(user);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuBarGeneral(user: user),
          )
      );
    } catch (e) {
      _showPopup("User not found: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const BackgroundWidget(imagePath: 'assets/generalbackground.png'),
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
                  color: branco,
                  fontFamily: 'Amaranth',
                  decoration: TextDecoration.none,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomTextField(
              controller: _emailController, // Agora é uma variável
              label: 'Email',
              inputType: TextInputType.emailAddress,
              isobscure: false,
            ),
            CustomTextField(
              controller: _passwordController, // Agora é uma variável
              label: 'Senha',
              inputType: TextInputType.visiblePassword,
              isobscure: true,
            ),
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
                      color: branco,
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
                onPressed: _signInUser,
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
                child: IgnorePointer(
                    child: RichText(
                  text: TextSpan(
                      text: "Login",
                      style: TextStyle(
                        color: branco,
                        fontFamily: "Amaranth",
                        fontSize: screenWidth * 0.06,
                      )),
                )),
              ),
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: branco,
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
                        color: branco,
                        fontSize: screenWidth * 0.046,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
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
