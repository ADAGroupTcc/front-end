import 'package:flutter/material.dart';
import '../utils/customtextfield.dart';

const Color preto = Color(0xFF0D0D0D);
const Color branco = Color(0xFFFFFAFE);
const Color cinzar = Color(0x4dfffafe);
const Color pretobg = Color(0xFF242424);

class EditStationAdm extends StatelessWidget {
  const EditStationAdm({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Edit profile page',
      home: EditStationAdmPage(),
    );
  }
}

class EditStationAdmPage extends StatelessWidget {
  const EditStationAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController _groupNameController = TextEditingController();

    return Scaffold(
      backgroundColor: pretobg,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Parte superior com a imagem de background e ícones
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background de onda (wave)
                  Image.asset(
                    'assets/fullblackwave.png',
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                  // Conteúdo acima dos campos de texto
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.138),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.064),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10000),
                              image: const DecorationImage(
                                image: AssetImage('assets/target.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Image.asset(
                              'assets/personalizeprofile.png',
                              fit: BoxFit.fitWidth,
                              width: screenWidth * 0.26,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.064),
                          child: Image.asset(
                            'assets/personalizeprofile.png',
                            fit: BoxFit.fitWidth,
                            width: screenWidth * 0.101,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Campo de Nome e Bio, fixos abaixo do conteúdo acima
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _groupNameController,
                      label: 'Nome do grupo',
                      inputType: TextInputType.text,
                      isobscure: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Botão Voltar no canto superior esquerdo
          Positioned(
            top: screenHeight * 0.0465,
            left: screenWidth * 0.0465,
            child: GestureDetector(
              onTap: () {},
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
          // Botão "Salvar alterações" fixo na parte inferior
          Positioned(
            bottom: screenHeight * 0.07,
            left: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.064,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.217,
                      vertical: screenHeight * 0.012,
                    ),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: branco, width: 2),
                    ),
                  ),
                  child: Text(
                    "Salvar alterações",
                    style: TextStyle(
                      color: branco,
                      fontFamily: "Amaranth",
                      fontSize: screenWidth * 0.06,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
