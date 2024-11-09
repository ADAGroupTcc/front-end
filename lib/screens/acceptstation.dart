import 'dart:convert';
import 'dart:math';

import 'package:addaproject/sdk/AddaSDK.dart';
import 'package:addaproject/sdk/model/ChannelFound.dart';
import 'package:flutter/material.dart';
import '../sdk/LocalCache.dart';
import '../sdk/WebSocket.dart';
import '../sdk/model/Channel.dart';
import '../utils/interestshow.dart';
import '../sdk/model/User.dart';
import '../utils/useracceptstate.dart';
import '../utils/userprofilecard.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretobg = Color(0xFF242424);

class AcceptStation extends StatefulWidget {
  final User? user;
  final ChannelFound? channelFound;
  final Map<String, String> status;
  final WebSocketService webSocketService;


  const AcceptStation({super.key, this.user, this.channelFound, required this.status, required this.webSocketService});

  @override
  _AcceptStationState createState() => _AcceptStationState();
}

class _AcceptStationState extends State<AcceptStation> {
  User? user;
  ChannelFound? channelFound;
  late Map<String, String> status;
  late WebSocketService webSocketService;
  List<String> acceptedUsers = [];
  AddaSDK sdk = AddaSDK();
  final _cache = LocalCache();

  @override
  initState() {
    super.initState();
    user = widget.user;
    channelFound = widget.channelFound;
    status = widget.status;
    webSocketService = widget.webSocketService;
  }


  void _onMessageReceived(message) {
    final data = JsonDecoder().convert(message);

    if (data['event'] == 'CHANNEL_ACCEPTED') {
      _acceptedUsers(data["user_id"]);
      _updateUserStatus(data["user_id"], "aceito");
      return;
    }
    if (data["event"] == 'CHANNEL_REJECTED') {
      _updateUserStatus(data["user_id"], "recusado");
      Navigator.pop(context);
      return;
    }
  }

  void _acceptedUsers(String userId) {
    setState(() {
      acceptedUsers.add(userId);
    });
  }

  void checkIfCompleted() async {
    if (acceptedUsers.length == channelFound!.users.length) {
      final newChannel = ChannelCreated(
        name: "Estação ${Random().nextInt(100)}",
        members: acceptedUsers,
          admins: [user!.id, channelFound!.users[Random().nextInt(channelFound!.users.length)].id],
      );
      final channel = await sdk.createChannel(newChannel);
      var channels = await _cache.listChannelCached();
      if (channels != null) {
        channels.add(channel!);
      }
    }
  }

  void _updateUserStatus(String userId, String newStatus) {
    setState(() {
      status[userId] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    webSocketService.onMessageReceived = _onMessageReceived;

    // Create a new list with the filtered users
    final filteredUsers = channelFound!.users.where((user) => user.id != this.user!.id).toList();

    return Scaffold(
      backgroundColor: pretobg,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: screenHeight * 0.25,
                        width: double.infinity,
                        child: FittedBox(
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.fitWidth,
                          child: Image.asset(
                            'assets/fullblackwave.png',
                          ),
                        ),
                      ),
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
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
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: UserAcceptState(
                          imagePath: 'assets/default_pfp.png',
                          name: filteredUsers[index].firstName + filteredUsers[index].lastName,
                          username: filteredUsers[index].nickname,
                          status: status[filteredUsers[index].id]!,
                        ),
                      );
                    },
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
                        onPressed: () {
                          final event = {
                            'event': 'CHANNEL_ACCEPTED',
                            'data': {}
                          };
                          webSocketService.send(JsonEncoder().convert(event));
                          _updateUserStatus(user!.id, "aceito");
                        },
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
                          onPressed: () {
                            final event = {
                              'event': 'CHANNEL_REJECTED',
                              'data': {}
                            };
                            _updateUserStatus(user!.id, "recusado");
                            webSocketService.send(JsonEncoder().convert(event));
                            Navigator.pop(context);
                          },
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
  @override
  void dispose() {
    super.dispose();
    webSocketService.dispose();
  }
}
