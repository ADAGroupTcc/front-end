import 'package:flutter/material.dart';
import '../utils/customtogglebutton.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretobg = Color(0xFF171717);

class OthersProfile extends StatelessWidget {
  const OthersProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Others profile page',
      home: OthersProfilePage(),
    );
  }
}

class OthersProfilePage extends StatelessWidget {
  const OthersProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: pretobg,
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/bgbillie.png',
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
                                  'assets/billie.png',
                                  fit: BoxFit.cover,
                                  width: screenWidth * 0.26,
                                  height: screenWidth * 0.26,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 260),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "@billie_eilish",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: Colors.white,
                        height: 1.1,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.064,
                    top: screenHeight * 0.015,
                    bottom: screenHeight * 0.01,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Billie Eilish",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Inter',
                        color: branco,
                        fontStyle: FontStyle.italic,
                        height: 1.1,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What do you want from me?",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: screenWidth * 0.047,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Inter',
                        color: branco,
                        fontStyle: FontStyle.italic,
                        height: 1.1,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.2,
                              vertical: screenHeight * 0.012),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: branco, width: 2),
                          ),
                        ),
                        child: Text(
                          "Personalizar perfil",
                          style: TextStyle(
                            color: branco,
                            fontFamily: "Amaranth",
                            fontSize: screenWidth * 0.06,
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.064,
                  vertical: screenHeight * 0.02,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Interesses",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Colors.white,
                      height: 1.1,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            top: screenHeight * 0.45, // Ajuste conforme necessário para sua UI
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: SizedBox(
                height: 100, // Altura definida para o container dos botões
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Habilita rolagem horizontal
                  child: Row(
                    children: List.generate(
                      18,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0), // Espaço entre os botões
                          child: CustomToggleButton(
                            // text: "Interesse $index",
                            imagePath: 'assets/transparenttarget.png',
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            // Ajuste esse valor conforme necessário para posicionar mais perto do topo
            right: screenWidth * 0.064,
            child: ClipOval(
              child: Image.asset(
                'assets/iconcompartilharlink.png',
                fit: BoxFit.cover,
                width: screenWidth * 0.12,
                height: screenWidth * 0.12,
              ),
            ),
          )
        ]));
  }
}
