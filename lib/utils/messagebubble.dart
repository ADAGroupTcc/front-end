import 'package:flutter/material.dart';

const Color bgreceived = Color(0xff404040);
const Color bgsent = Color(0xff8D5BCA);
const Color white = Color(0xffFFFAFE);

class MessageBubble extends StatelessWidget {
  final String nickname;
  final String message;
  final bool isSender;

  const MessageBubble({
    Key? key,
    required this.nickname,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return isSender ? _getSenderMessageBubble(screenWidth) : _getReceiverMessageBubble(screenWidth);
  }

  Widget _getReceiverMessageBubble(double screenWidth) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nickname, style: TextStyle(color: bgreceived),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: bgreceived,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth - (screenWidth * 0.25),
                      ),
                      child: Text(message, style: TextStyle(color: white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

  Widget _getSenderMessageBubble(double screenWidth) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: bgsent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth - (screenWidth * 0.25),
                      ),
                      child: Text(message, style: TextStyle(color: white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
}
