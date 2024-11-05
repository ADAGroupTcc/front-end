import 'package:flutter/material.dart';
import '../sdk/model/User.dart';
import '../utils/customtogglebutton.dart';
import '../utils/interestshow.dart';
import '../utils/station.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretobg = Color(0xFF171717);

class OthersProfile extends StatelessWidget {
  final User? user;

  OthersProfile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Others profile page',
      home: OthersProfilePage(user: user),
    );
  }
}

class OthersProfilePage extends StatelessWidget {
  final User? user;

  const OthersProfilePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                      'assets/bgbillie.png',
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
                const SizedBox(height: 40),
                // Informações do perfil
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "@billie_eilish",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.023),
                      Text(
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
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
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
                      ),
                    ],
                  ),
                ),
                // Seção de interesses
                const SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064, vertical: screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Interesses",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.023),
                      SizedBox(
                        height: screenHeight * 0.06,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            18,
                                (index) => Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ShowInterest(
                                text: "Interesse $index",
                                imagePath: 'assets/transparenttarget.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Seção de estações
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064, vertical: screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estações",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.023),
                      Wrap(
                        spacing: 10,
                        children: List.generate(
                          18,
                              (index) => Station(
                            stationName: 'Estação $index',
                          ),
                        ),
                      ),
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
