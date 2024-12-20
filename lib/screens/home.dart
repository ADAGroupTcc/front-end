import 'package:addaproject/sdk/model/User.dart';
import '../sdk/AddaSDK.dart';
import '../sdk/LocalCache.dart';
import '../sdk/model/Channel.dart';
import '../utils/backgroundwidget.dart';
import 'package:flutter/material.dart';

import '../utils/stationbutton.dart';
import 'chat.dart';

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
  final User? user;
  final AddaSDK sdk = AddaSDK();
  final _cache = LocalCache();

  HomePage({super.key, this.user});

  Future<List<Channel>> _fetchChannels() async {
    if (user != null) {
      try {
        final res = await _cache.listChannelCached();
        if (res != null && res.isNotEmpty) {
          return res;
        }

        final channelResponse = await sdk.listChannelsByUserId(user!.id);
        await _cache.saveChannels(channelResponse.channels);
        return channelResponse.channels;
      } catch (e) {
        print("Erro ao listar canais: $e");
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(

      body: Stack(
        children: [
          // Background
          const BackgroundWidget(imagePath: 'assets/generalbackground.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const SizedBox(height: 20),
              Flexible(
                child: FutureBuilder<List<Channel>>(
                  future: _fetchChannels(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Erro ao carregar estações"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return _buildNoStations(screenWidth, screenHeight);
                    } else {
                      return _buildStationsList(
                          snapshot.data!, context);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoStations(double screenWidth, double screenHeight) {
    return Flexible(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.078),
                child: Center(
                  child: SizedBox(
                    // Adicionar um Container ao redor do texto
                    width: screenWidth,
                    // Define uma largura máxima para o texto
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
                      textAlign: TextAlign.center, // Centraliza o texto
                      softWrap:
                          true, // Garante que o texto se quebre automaticamente
                      overflow: TextOverflow
                          .visible, // Impede que o texto seja cortado
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
              SizedBox(
                height: screenHeight * 0.15,
              )
            ],
          ),
          Positioned(
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Garante que a seta e o texto fiquem alinhados à esquerda
              children: [
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
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.18, top: screenHeight * 0.012),
                  // Move apenas a seta levemente para a esquerda
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
    );
  }

  Widget _buildStationsList(List<Channel> channels, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: screenHeight * 0.03),
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
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.03, right: screenWidth * 0.03),
            child: ListView.builder(
              itemCount: channels.length,
              itemBuilder: (context, index) {
                return StationButton(
                  stationName: channels[index].name,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return PopScope(
                          onPopInvokedWithResult: (match, dynamic) async => true,
                          child: Dialog(
                            insetPadding: EdgeInsets.zero,
                            child: Chat(user: user!, channel: channels[index]),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoText(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          padding: EdgeInsets.only(left: screenWidth * 0.18),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/setinha.png',
              fit: BoxFit.contain,
              height: screenWidth * 0.05,
            ),
          ),
        ),
      ],
    );
  }
}
