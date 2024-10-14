import '../utils/CustomTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../sdk/model/User.dart';
import '../sdk/AddaSDK.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register page',
      home: RegisterPage(title: 'Register', contexto: context),
    );
  }
}

class RegisterPage extends StatefulWidget {
  final String title;
  final BuildContext contexto;

  const RegisterPage({super.key, required this.title, required this.contexto});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AddaSDK _sdk = AddaSDK(); // Instância do seu SDK

  // Controladores de texto
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmacaoSenhaController = TextEditingController();

  // Função para exibir mensagens de erro
  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Função para criar usuário
  Future<void> _createUser() async {
    final String nome = nomeController.text.trim();
    final String sobrenome = sobrenomeController.text.trim();
    final String email = emailController.text.trim();
    final String cpf = cpfController.text.trim();
    final String senha = senhaController.text.trim();
    final String confirmacaoSenha = confirmacaoSenhaController.text.trim();

    // Verifica se algum campo está vazio
    if (nome.isEmpty || sobrenome.isEmpty || email.isEmpty || cpf.isEmpty || senha.isEmpty || confirmacaoSenha.isEmpty) {
      _showError("Por favor, preencha todos os campos.");

      // Debug: Imprimir qual campo está vazio
      if (nome.isEmpty) _showError("Campo Nome está vazio.");
      if (sobrenome.isEmpty) _showError("Campo Sobrenome está vazio.");
      if (email.isEmpty) _showError("Campo Email está vazio.");
      if (cpf.isEmpty) _showError("Campo CPF está vazio.");
      if (senha.isEmpty) _showError("Campo Senha está vazio.");
      if (confirmacaoSenha.isEmpty) _showError("Campo Confirmar Senha está vazio.");

      return;
    }

    // Verifica se as senhas coincidem
    if (senha != confirmacaoSenha) {
      _showError("As senhas não coincidem.");
      return;
    }

    // Tenta criar o usuário
    try {
      User? newUser = await _sdk.createUser(User(
        id: "", // O id será gerado pelo backend
        firstName: nome,
        lastName: sobrenome,
        email: email,
        description: "", // Campo nulo no momento da criação
        nickname: "", // Campo nulo no momento da criação
        cpf: cpf,
        categories: [], // Campo nulo ou vazio no momento da criação
        createdAt: DateTime.now(), // Data e hora atual
        updatedAt: DateTime.now(), // Mesmo da criação
        isDenunciated: false, // False na criação
      ));

      // Caso o usuário seja criado com sucesso, redireciona para a tela de login
      if (newUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        _showError("Falha ao criar o usuário. Tente novamente.");
      }
    } catch (error) {
      // Se ocorrer algum erro na criação, exibe um pop-up com o erro
      _showError("Erro ao criar usuário: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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
              CustomTextField(
                controller: nomeController,
                label: 'Nome',
                inputType: TextInputType.text,
              ),
              CustomTextField(
                controller: sobrenomeController,
                label: 'Sobrenome',
                inputType: TextInputType.text,
              ),
              CustomTextField(
                controller: emailController,
                label: 'E-mail',
                inputType: TextInputType.emailAddress,
              ),
              CustomTextField(
                controller: cpfController,
                label: 'CPF',
                inputType: TextInputType.text,
              ),
              CustomTextField(
                controller: senhaController,
                label: 'Crie uma senha',
                inputType: TextInputType.visiblePassword,
              ),
              CustomTextField(
                controller: confirmacaoSenhaController,
                label: 'Confirme sua senha',
                inputType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.05, bottom: screenHeight * 0.01),
                child: ElevatedButton(
                  onPressed: _createUser, // Chama a função de criar usuário
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
                      style: TextStyle(
                        color: branco,
                        fontFamily: "Amaranth",
                        fontSize: screenWidth * 0.06,
                      ),
                    ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: screenHeight * 0.023,
            left: screenWidth * 0.04,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(widget.contexto);
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
        ],
      ),
    );
  }
}
