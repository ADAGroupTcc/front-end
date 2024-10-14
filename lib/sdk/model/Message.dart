import 'Channel.dart';
import 'User.dart';

class Message {
  final String id;
  final Channel channel;
  final String type;
  final User sender;
  final String content;
  final bool isEdited;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.channel,
    required this.type,
    required this.sender,
    required this.content,
    required this.isEdited,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      channel: Channel.fromJson(json['channel'] as Map<String, dynamic>),
      type: json['type'] as String,
      sender: User.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String,
      isEdited: json['isEdited'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
