import 'User.dart';


class Channel {
  final String id;
  final String name;
  final String description;
  final List<String> members;
  final List<String> admins;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Channel({
    required this.id,
    required this.name,
    required this.description,
    required this.members,
    required this.admins,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      members: List<String>.from(json['members'] ?? []), // Alterar para retornar já com os usuários
      admins: List<String>.from(json['admins'] ?? []), // Alterar para retornar já com os usuários
      imageUrl: json["image_url"] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class ChannelResponse {
  final List<Channel> channels;
  final int next;

  ChannelResponse({
    required this.channels,
    required this.next,
  });

  factory ChannelResponse.fromJson(Map<String, dynamic> json) {
    List<Channel> channels = [];
    for (var values in json["channels"]) {
      channels.add(Channel.fromJson(values));
    }
    return ChannelResponse(channels: channels, next: json["next_page"] ?? 1);
  }
}
