import 'package:flutter/material.dart';
import '../utils/backgroundwidget.dart';
import '../utils/customtextfield.dart';
import '../utils/menuBar.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);
const Color pretobg = Color(0xFF242424);

class ProfilePersonalization extends StatelessWidget {
  const ProfilePersonalization({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profile personalization page',
      home: ProfilePersonalizationPage(),
    );
  }
}

class ProfilePersonalizationPage extends StatelessWidget {
  const ProfilePersonalizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final TextEditingController nameController = TextEditingController();
    final TextEditingController bioController = TextEditingController();

    return Scaffold(
      backgroundColor: pretobg,
      body: Stack(
        children: [
          // Conteúdo rolável
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/fullblackwave.png',
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: screenHeight * 0.134),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.064),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: screenWidth * 0.27,
                                    height: screenWidth * 0.27,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: pretobg,
                                        width: 5.0,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/personalizeprofile.png',
                                        fit: BoxFit.cover,
                                        width: screenWidth * 0.26,
                                        height: screenWidth * 0.26,
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding:
                                    EdgeInsets.only(right: screenWidth * 0.064),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    'assets/personalizeprofile.png',
                                    fit: BoxFit.fitWidth,
                                    width: screenWidth * 0.101,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Informações do perfil
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                  child: Text(
                    "Personalize seu perfil!",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                      fontWeight: FontWeight.w600,
                      color: branco,
                      fontFamily: 'Amaranth',
                      decoration: TextDecoration.none,
                      height: 1,
                    ),
                  ),
                ),
                // Seção de interesses
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                  ),
                  child: CustomTextField(
                    controller: bioController,
                    label: 'Nome de usuário',
                    inputType: TextInputType.visiblePassword,
                    isobscure: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                  ),
                  child: CustomTextField(
                    controller: bioController,
                    label: 'Bio',
                    inputType: TextInputType.visiblePassword,
                    isobscure: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.2,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.31,
                            vertical: screenHeight * 0.012),
                        backgroundColor: branco,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: branco, width: 4),
                        ),
                      ),
                      child: Text(
                        "Continuar",
                        style: TextStyle(
                          color: preto,
                          fontFamily: "Amaranth",
                          fontSize: screenWidth * 0.06,
                        ),
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
          Positioned(
              top: screenHeight * 0.06,
              left: screenWidth * 0.04,
              child: GestureDetector(
                onTap: () {

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
        ],
      ),
    );
  }
}
