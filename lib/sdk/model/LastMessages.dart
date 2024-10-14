import 'Channel.dart';
import 'Message.dart';
import 'User.dart';

class LastMessages {
  final List<Message> messages;
  final Channel channel;
  final User receiver;
  final DateTime createdAt;

  LastMessages({
    required this.messages,
    required this.channel,
    required this.receiver,
    required this.createdAt,
  });

  factory LastMessages.fromJson(Map<String, dynamic> json) {
    return LastMessages(
      messages: (json['messages'] as List<dynamic>)
          .map((msgJson) => Message.fromJson(msgJson as Map<String, dynamic>))
          .toList(),
      channel: Channel.fromJson(json['channel'] as Map<String, dynamic>),
      receiver: User.fromJson(json['receiver'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
