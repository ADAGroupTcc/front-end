import 'package:flutter/material.dart';
import '../utils/interestshow.dart';
import '../sdk/model/User.dart';
import '../utils/useracceptstate.dart';
import '../utils/userprofilecard.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretobg = Color(0xFF242424);

class AcceptStation extends StatelessWidget {
  final User? user;

  const AcceptStation({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Others profile page',
      home: AcceptStationPage(user: user),
    );
  }
}

class AcceptStationPage extends StatelessWidget {
  final User? user;

  const AcceptStationPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: pretobg,
      body: Stack(
        children: [
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
                        const SizedBox(height: 120),
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
                                  'assets/target.png',
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
                const SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                  child: Text(
                    "Estação 01",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: screenWidth * 0.075,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Colors.white,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Text(
                    "Integrantes",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Colors.white,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                // Scrollable area for the list of members with scrollbar
                Container(
                  height: screenHeight * 0.255,
                  child: RawScrollbar(
                    thumbColor: Colors.white, // Cor da "thumb" branca
                    thickness: 6.0, // Espessura da barra
                    radius: Radius.circular(10), // Borda arredondada
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          18,
                              (index) {
                            String status;
                            switch (index % 3) {
                              case 0:
                                status = 'pendente';
                                break;
                              case 1:
                                status = 'aceito';
                                break;
                              case 2:
                              default:
                                status = 'recusado';
                                break;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: UserAcceptState(
                                imagePath: 'assets/billie.png',
                                name: 'Billie Eilish',
                                username: 'billie_eilish',
                                status: status,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.333,
                              vertical: screenHeight * 0.012),
                          backgroundColor: branco,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: branco, width: 4),
                          ),
                        ),
                        child: Text(
                          "Aceitar",
                          style: TextStyle(
                            color: preto,
                            fontFamily: "Amaranth",
                            fontSize: screenWidth * 0.055,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.325,
                                vertical: screenHeight * 0.012),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: branco, width: 2),
                            ),
                          ),
                          child: Text(
                            "Recusar",
                            style: TextStyle(
                              color: branco,
                              fontFamily: "Amaranth",
                              fontSize: screenWidth * 0.055,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
