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
      title: 'OthersProfile page',
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
                  'assets/bglanita.png',
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
                                  'assets/lanita.png',
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
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // Mude para MainAxisSize.min para não ocupar todo o espaço
              children: [
                const SizedBox(height: 180),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.064,
                      vertical: screenHeight * 0.01,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "@lanita",
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
                        "Lana Del Rey",
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
                        "I’ve got my red dress on tonight, dancin’ in the dark, in the pale moonlight",
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
                // Ajuste o valor de top e bottom conforme necessário para controlar onde a rolagem começa.
                Positioned.fill(
                  top: screenHeight * 0.1, // Ajuste esse valor para mover o início da rolagem para cima ou para baixo
                  bottom: screenHeight * 0.2, // Este valor pode ser mantido para deixar espaço embaixo
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 20.0, // Espaço horizontal entre os itens
                        runSpacing: 15.0, // Espaço vertical entre as linhas
                        children: List.generate(
                          18,
                              (index) {
                            return CustomToggleButton(
                              text: "Interesse $index",
                              imagePath: 'assets/transparenttarget.png',
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
