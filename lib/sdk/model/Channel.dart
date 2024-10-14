import 'User.dart';


class Channel {
  final String id;
  final String name;
  final String description;
  final List<User> members;
  final List<User> admins;
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
      members: (json['members'] as List<dynamic>)
          .map(
              (memberJson) => User.fromJson(memberJson as Map<String, dynamic>))
          .toList(),
      admins: (json['admins'] as List<dynamic>)
          .map((adminJson) => User.fromJson(adminJson as Map<String, dynamic>))
          .toList(),
      imageUrl: json["imageUrl"] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
