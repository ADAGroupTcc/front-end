import 'package:flutter/material.dart';
import '../utils/backgroundwidget.dart';
import '../utils/customtextfield.dart';
import '../utils/menuBar.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

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
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _bioController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          const BackgroundWidget(imagePath: 'assets/profilebackground.png'),
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/blackwavetwo.png',
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 120),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.064),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                'assets/personalizeprofile.png',
                                fit: BoxFit.fitWidth,
                                width: screenWidth * 0.26,
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
                                width: screenWidth * 0.12,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 180),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.064,
                      vertical: screenHeight * 0.02),
                  child: Text(
                    "Personalize seu perfil!",
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
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _nameController,
                  label: 'Email',
                  inputType: TextInputType.emailAddress,
                  isobscure: false,
                ),
                CustomTextField(
                  controller: _bioController,
                  label: 'Senha',
                  inputType: TextInputType.visiblePassword,
                  isobscure: true,
                ),
                const SizedBox(height: 45),
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.17, bottom: screenHeight * 0.01),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MenuBarGeneral()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.303,
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
                ),
              ],
            ),
          ),
          Positioned(
              bottom: screenHeight * 0.023,
              left: screenWidth * 0.04,
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
              )),
        ]));
  }
}
