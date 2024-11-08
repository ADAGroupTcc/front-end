import 'package:flutter/material.dart';
import '../utils/interestshow.dart';
import '../sdk/model/User.dart';
import '../utils/userprofilecard.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretobg = Color(0xFF242424);

class GroupInfo extends StatelessWidget {
  final User? user;

  const GroupInfo({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Others profile page',
      home: GroupInfoPage(user: user),
    );
  }
}

class GroupInfoPage extends StatelessWidget {
  final User? user;

  // Definimos uma variável local para simular se o usuário é administrador
  final bool isAdmin = true; // Altere para false para esconder o botão

  const GroupInfoPage({super.key, this.user});

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
                      'assets/fullblackwave.png',
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 110),
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
                // Informações do perfil
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estação 01",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.075,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (isAdmin)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.165,
                                  vertical: screenHeight * 0.012,
                                ),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: branco, width: 2),
                                ),
                              ),
                              child: Text(
                                "Personalizar estação",
                                style: TextStyle(
                                  color: branco,
                                  fontFamily: "Amaranth",
                                  fontSize: screenWidth * 0.055,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Seção de interesses
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.02,
                  ),
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
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Integrantes",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: List.generate(
                          18,
                              (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: UserProfileCard(
                              imagePath: 'assets/billie.png', // Caminho da imagem
                              name: 'Billie Eilish',
                              username: 'billie_eilish',
                              isAdmin: index % 2 == 0,
                            ),
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
