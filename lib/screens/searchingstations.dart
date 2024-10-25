import 'package:flutter/material.dart';

import '../utils/backgroundwidget.dart';
import '../utils/menuBar.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);

class SearchingStations extends StatefulWidget {
  const SearchingStations({super.key});

  @override
  SearchingPage createState() => SearchingPage();
}

class SearchingPage extends State<SearchingStations> {
  @override
  void initState() {
    super.initState();
    // Delay de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      // Verifica se o widget ainda está montado antes de navegar
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MenuBarGeneral(initialIndex: 2)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const BackgroundWidget(imagePath: 'assets/generalbackground.png'),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.084),
              child: Center(
                child: Text(
                  "Buscando estações que combinam com você!",
                  style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Amaranth',
                    decoration: TextDecoration.none,
                    height: 1.1,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.032),
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/torredesinal.png',
                  fit: BoxFit.fitWidth,
                  width: screenWidth * 0.6,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // também será necessário cancelar a chamada do serviço :0
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.361,
                      vertical: screenHeight * 0.012),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: branco, width: 2),
                  ),
                ),
                child: Text(
                  "Cancelar",
                  style: TextStyle(
                    color: branco,
                    fontFamily: "Amaranth",
                    fontSize: screenWidth * 0.06,
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
