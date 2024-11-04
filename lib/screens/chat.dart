import 'package:addaproject/sdk/AddaSDK.dart';
import 'package:addaproject/sdk/model/Message.dart';
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
  var history = <Message>[];

  ChatPage({required this.user, required this.channel});

  ImageProvider<Object>? _getChannelImage() {
    if (channel.imageUrl != "") {
      return NetworkImage(channel.imageUrl);
    }
    return AssetImage("assets/target.png");
  }

  Future<List<Message>?> _fetchMessages() async {
    try {
      final res = await sdk.listMessagesByChannelId(channel.id);
      history = res!;
      return res;
    } catch (e) {
      print(e);
    }
    return [];
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: pretobg,
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: pretobg,
              child: FutureBuilder<List<Message>?>(
                future: _fetchMessages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Erro ao carregar estações"));
                  } else if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                    return _buildMessages(snapshot.data!, context);
                  }
                  return _buildMessages([], context);
                },
              ),
            ),
          ),
          MensagemInput(
            onSend: (mensagem) {
              print("Mensagem enviada: $mensagem");
              // Add message handling logic here and call _scrollToBottom after a new message
              // setState(() {
                // history.add(Message(sender: user.id, content: mensagem)); // Example message structure
              // });
              _scrollToBottom();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessages(List<Message> history, BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: history.length,
      itemBuilder: (context, index) {
        return MessageBubble(
          nickname: history[index].sender,
          message: history[index].content,
          isSender: history[index].sender == user.id,
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
