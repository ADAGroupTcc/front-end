import 'package:flutter/material.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretor = Color(0x500D0D0D);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    return Stack(
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
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/logoadda.png',
                  fit: BoxFit.fitWidth,
                  width: 115,
                  height: 180,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Bem vindo(a) ao ADDA!",
                  style: TextStyle(
                    fontSize: 58,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Amaranth',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Aqui você encontra estações de tripulantes que combinam com você, de forma altamente personalizável!",
                  style: TextStyle(
                    fontSize: 27,
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none,
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
                  const Text(
                    "Primeiros passos",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Amaranth",
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SegundaRota()),
                      );
                    },
                    style: ButtonStyle(
                        minimumSize:
                            WidgetStateProperty.all(const Size(20, 10)),
                        backgroundColor: WidgetStateProperty.all<Color>(branco),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: branco, width: 2)))),
                    child: const Text(
                      "Crie uma conta",
                      style: TextStyle(
                        color: preto,
                        fontFamily: "Amaranth",
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SegundaRota extends StatelessWidget {
  const SegundaRota({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segunda Rota (tela)"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Retornar !'),
        ),
      ),
    );
  }
}
