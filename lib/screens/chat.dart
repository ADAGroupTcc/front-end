import 'dart:convert';

import 'package:addaproject/sdk/AddaSDK.dart';
import 'package:addaproject/sdk/LocalCache.dart';
import 'package:addaproject/sdk/WebSocket.dart';
import 'package:addaproject/sdk/model/Message.dart';
import 'package:addaproject/utils/circularlist.dart';
import 'package:flutter/material.dart';

import '../sdk/model/Channel.dart';
import '../sdk/model/User.dart';
import '../utils/MensagemInput.dart';
import '../utils/messagebubble.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretobg = Color(0xFF171717);

class Chat extends StatefulWidget {
  final User user;
  final Channel channel;

  Chat({super.key, required this.user, required this.channel});

  @override
  State<StatefulWidget> createState() => ChatPage(user: user, channel: channel);
}

class ChatPage extends State<Chat> {
  final User user;
  final Channel channel;
  final AddaSDK sdk = AddaSDK();
  final ScrollController _scrollController = ScrollController();
  CircularList<Message> _history = CircularList(50);
  late WebSocketService _webSocketService;

  ChatPage({required this.user, required this.channel});

  @override
  void initState() {
    super.initState();

    _loadInitialMessages();

    _webSocketService = WebSocketService(
      userId: user.id,
      onConnected: _onConnected,
      onMessageReceived: _onMessageReceived,
      onDisconnected: _onDisconnect,
    );
    _webSocketService.connect();
  }

  Future<void> _loadInitialMessages() async {
    try {
      final res = await sdk.listMessagesByChannelId(channel.id);
      if (res != null) {
        setState(() {
          _history.addAll(res.reversed.toList());
        });
      }
    } catch (e) {
      print("Erro ao carregar mensagens: $e");
    }
  }

  ImageProvider<Object>? _getChannelImage() {
    if (channel.imageUrl != "") {
      return NetworkImage(channel.imageUrl);
    }
    return AssetImage("assets/target.png");
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _onConnected() {
    print("Usuario ${user.id} conectado ao canal ${channel.id}");
  }

  void _onMessageReceived(String message) {
    final event = JsonDecoder().convert(message);
    if (event["event"] == "MESSAGE_CREATED" || event["event"] == "MESSAGE_RECEIVED") {
      final msg = Message.fromJson(event["data"]);
      setState(() {
        _history.add(msg);
      });
      _scrollToBottom();
    }
  }

  void _onDisconnect() {
    _history.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: pretobg,
      body: Column(
        children: [
          Expanded(
            child: _buildMessages(context), // Exibe as mensagens diretamente
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/appbarchat.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: _getChannelImage(),
                ),
                const SizedBox(width: 20),
                Text(
                  channel.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return MensagemInput(
      onSend: (mensagem) {
        final members = channel.members.map((e) => e.id).toList();
        final messageCreated = MessageCreated(
          channelId: channel.id,
          members: members,
          sender: user.id,
          content: mensagem,
        );

        final messageSent = {
          "event": "MESSAGE_SENT",
          "data": messageCreated.toJson(),
        };
        _webSocketService.send(JsonEncoder().convert(messageSent));

        _scrollToBottom();
      },
    );
  }

  Widget _buildMessages(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _history.length,
      itemBuilder: (context, index) {
        return MessageBubble(
          nickname: channel.members.reduce((value, element) => value.id == _history[index].sender ? value : element).nickname,
          message: _history[index].content,
          isSender: _history[index].sender == user.id,
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _webSocketService.dispose();
    super.dispose();
  }
}