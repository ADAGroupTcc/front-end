

import 'User.dart';

class Channel {
  final String id;
  final String name;
  final String description;
  final List<UserChannel> members;
  final List<UserChannel> admins;
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
      description: json['description'] as String? ?? '',
      members: (json['members'] as List<dynamic>)
          .map((msgJson) => UserChannel.fromJson(msgJson as Map<String, dynamic>))
          .toList(),
      admins: (json['admins'] as List<dynamic>)
          .map((msgJson) => UserChannel.fromJson(msgJson as Map<String, dynamic>))
          .toList(),
      imageUrl: json["image_url"] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'members': members,
      'admins': admins,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class UserChannel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String description;
  final String nickname;
  final String cpf;
  final List<String> categories;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDenunciated;

  UserChannel({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.description = '',
    this.nickname = '',
    this.cpf = '',
    this.categories = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isDenunciated = false,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory UserChannel.fromJson(Map<String, dynamic> json) {
    return UserChannel(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      description: json['description'] as String? ?? '',
      nickname: json['nickname'] as String,
      cpf: json['cpf'] as String,
      categories: (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isDenunciated: json['is_denunciated'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'description': description,
      'nickname': nickname,
      'cpf': cpf,
      'categories': categories,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_denunciated': isDenunciated,
    };
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

class ChannelCreated {
  final String name;
  final List<String> members;
  final List<String> admins;

  ChannelCreated({
    required this.name,
    required this.members,
    required this.admins,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'members': members,
      'admins': admins,
    };
  }
}