import 'package:addaproject/utils/customtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Adiciona o prefixo
// Importa o Firebase Realtime Database
// Importe sua SDK
import '../sdk/model/User.dart';
// Importa o http para interações com o Firebase
import 'interests.dart';

import '../utils/backgroundwidget.dart'; // Importa para usar jsonEncode

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> _registerUser() async {
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String email = _emailController.text.trim();
    final String cpf = _cpfController.text.trim();
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    final RegExp emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    final RegExp cpfRegExp = RegExp(r'^\d{11}$');
    final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$');

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        cpf.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showPopup('Por favor, preencha todos os campos.');
      return;
    }

    if (!emailRegExp.hasMatch(email)) {
      _showPopup('Insira um e-mail válido.');
      return;
    }

    if (!cpfRegExp.hasMatch(cpf)) {
      _showPopup('CPF deve conter 11 dígitos numéricos.');
      return;
    }

    if (password != confirmPassword) {
      _showPopup('As senhas não coincidem.');
      return;
    }

    if (!passwordRegExp.hasMatch(password)) {
      _showPopup("A senha deve ter pelo menos 6 caracteres, incluir letras, números e uma letra maiúscula.");
      return;
    }
    try {
      final res = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (res.user != null) {
        throw FirebaseAuthException(code: "wrong-password");
      }
    }catch(e) {
      e as FirebaseAuthException;
      switch(e.code) {
        case "user-not-found":
        case "invalid-credential":
        break;
        case "invalid-email":
        _showPopup("Email inválido");
        return;
        case "wrong-password":
          _showPopup("Conta já existente, faça login");
          return;
        default:
          _showPopup("Failure ${e.message}");
          return;
      }
    }
    final newUser = UserCreate(
      firstName: firstName,
      lastName: lastName,
      email: email,
      cpf: cpf,
      password: password,
      categories: [],
    );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Interests(user: newUser)),
      );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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
                  "Crie sua conta!",
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
              CustomTextField(
                label: 'Nome',
                inputType: TextInputType.text,
                controller: _firstNameController,
                isobscure: false,
              ),
              CustomTextField(
                label: 'Sobrenome',
                inputType: TextInputType.text,
                controller: _lastNameController,
                isobscure: false,
              ),
              CustomTextField(
                label: 'E-mail',
                inputType: TextInputType.emailAddress,
                controller: _emailController,
                isobscure: false,
              ),
              CustomTextField(
                label: 'CPF',
                inputType: TextInputType.text,
                controller: _cpfController,
                isobscure: false,
              ),
              CustomTextField(
                label: 'Crie uma senha',
                inputType: TextInputType.visiblePassword,
                controller: _passwordController,
                isobscure: true,
              ),
              CustomTextField(
                label: 'Confirme sua senha',
                inputType: TextInputType.visiblePassword,
                controller: _confirmPasswordController,
                isobscure: true,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.05, bottom: screenHeight * 0.01),
                child: ElevatedButton(
                  onPressed: _registerUser, // Chama a função de registro
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
                  child: Text(
                    "Continuar",
                    style: TextStyle(
                      color: branco,
                      fontFamily: "Amaranth",
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
