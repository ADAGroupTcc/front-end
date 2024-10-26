import 'package:addaproject/sdk/model/User.dart';

import '../utils/backgroundwidget.dart';
import '../utils/searchbarwithnotify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/stationbutton.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);

class Home extends StatelessWidget {
  User? user;

  Home({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(user: user),
    );
  }
}

class HomePage extends StatelessWidget {
  User? user;

  HomePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const int numberOfStations = 0;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          const BackgroundWidget(imagePath: 'assets/generalbackground.png'),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // Barra de pesquisa e notificação
              const SearchBarWithNotification(),

              const SizedBox(height: 20),

              if (numberOfStations > 0) ...[
                // Exibe "Minhas estações" e a lista de estações se houver estações
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Minhas estações',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: branco,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.06,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),

                // Lista de Botões de Estação
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: ListView.builder(
                      itemCount: numberOfStations,
                      itemBuilder: (context, index) {
                        return StationButton(
                          stationName: 'Estação $index',
                          onPressed: () {
                            print('Estação $index pressionada');
                          },
                        );
                      },
                    ),
                  ),
                ),
              ] else ...[
                Flexible(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.084),
                            child: Center(
                              child: Container( // Adicionar um Container ao redor do texto
                                width: screenWidth * 0.8, // Define uma largura máxima para o texto
                                child: Text(
                                  "Você não está em nenhuma estação por enquanto...",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.1,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: 'Amaranth',
                                    decoration: TextDecoration.none,
                                    height: 1.1,
                                  ),
                                  textAlign: TextAlign.center,  // Centraliza o texto
                                  softWrap: true,               // Garante que o texto se quebre automaticamente
                                  overflow: TextOverflow.visible, // Impede que o texto seja cortado
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.032),
                            child: Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/astronautinha.png',
                                fit: BoxFit.fitWidth,
                                width: screenWidth * 0.6,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.15,)
                        ],
                      ),
                      Positioned(
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Garante que a seta e o texto fiquem alinhados à esquerda
                          children: [
                            // Texto que não será movido
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                              child: Center(
                                child: SizedBox(
                                  width: screenWidth * 0.9,
                                  child: Text(
                                    "Encontre grupos que são a sua cara clicando aqui!",
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: screenWidth * 0.06,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.18, top: screenHeight * 0.012), // Move apenas a seta levemente para a esquerda
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  'assets/setinha.png',
                                  fit: BoxFit.contain,
                                  height: screenHeight * 0.05,
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
            ],
          ),
        ],
      ),
    );
  }
}
