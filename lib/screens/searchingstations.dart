import 'dart:convert';

import 'package:addaproject/screens/acceptstation.dart';
import 'package:addaproject/sdk/model/ChannelFound.dart';
import 'package:flutter/material.dart';

import '../sdk/WebSocket.dart';
import '../sdk/model/User.dart';
import '../utils/backgroundwidget.dart';
import '../utils/menuBar.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);

class SearchingStations extends StatefulWidget {
  final User user;
  SearchingStations({super.key, required this.user});

  @override
  SearchingPage createState() => SearchingPage(user: user);
}

class SearchingPage extends State<SearchingStations> {
  User user;
  late WebSocketService _webSocketService;

  SearchingPage({required this.user});

  void _onConnected() {
    final search = {
      "event": "SEARCH_REQUESTED",
      "user_id": user.id,
      "data": {}
    };
    _webSocketService.send(JsonEncoder().convert(search));
    print("Connected!!");
  }

  void _onMessageReceived(message) {
    final data = JsonDecoder().convert(message);

    if (data['event'] == 'CHANNEL_FOUND') {
      final channelFound = ChannelFound.fromJson(data["data"]);
      final status = { for (var user in channelFound.users) user.id : "pendente" };

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AcceptStation(
        user: user,
        channelFound: channelFound,
        status: status,
        webSocketService: _webSocketService,
      )
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _webSocketService = WebSocketService(
      userId: user.id,
      onConnected: _onConnected,
      onMessageReceived: _onMessageReceived,
      // onDisconnected: _onDisconnect,
    );
    _webSocketService.connect();
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
                  _webSocketService.disconnect();
                  print("disconnected!");
                  Navigator.pop(context);
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
