import 'package:flutter/material.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);

class SearchingStations extends StatelessWidget {
  const SearchingStations({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Looking for stations page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const searchingPage(title: 'searching stations'),
    );
  }
}

class searchingPage extends StatelessWidget {
  final String title;

  const searchingPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'assets/registerbackground.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
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
              )),
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
              //   também será necessário cancelar a chamada do serviço :0
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
    ]));
  }
}
