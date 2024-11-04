import 'Channel.dart';
import 'User.dart';

class Message {
  final String id;
  final String channelId;
  final String sender;
  final String content;
  final bool isEdited;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.channelId,
    required this.sender,
    required this.content,
    required this.isEdited,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      channelId: json['channel_id'] as String,
      sender: json['sender_id'] as String,
      content: json['message'] as String,
      isEdited: json['is_edited'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'channel_id': channelId,
      'sender_id': sender,
      'message': content,
      'is_edited': isEdited,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class MessagesResponse {
  final List<Message> messages;
  final int nextPage;

  MessagesResponse({required this.messages, this.nextPage = 0});

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    List<Message> messages = [];
    for (var values in json["messages"]) {
      messages.add(Message.fromJson(values));
    }
    return MessagesResponse(messages: messages, nextPage: json["next_page"] ?? 1);
  }
}