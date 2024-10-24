import 'Categoria.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String description;
  final String nickname;
  final String cpf;
  final List<Categoria> categories;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDenunciated;

  User({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.email,
    this.description = '',
    this.nickname = '',
    required this.cpf,
    this.categories = const [],
    DateTime?
        createdAt,
    DateTime? updatedAt,
    this.isDenunciated = false,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    String _parseString(String? value, [String defaultValue = '']) => value ?? defaultValue;
    return User(
      id: _parseString(json['id']),
      firstName: _parseString(json['first_name']),
      lastName: _parseString(json['last_name']),
      email: _parseString(json['email']),
      description: _parseString(json['description']),
      nickname: _parseString(json['nickname']),
      cpf: _parseString(json['cpf']),
      // categories: (json['categories'] as List<dynamic>?)
      //     ?.map((categorieJson) => Categoria.fromJson(categorieJson as Map<String, dynamic>))
      //     .toList() ?? [],
      categories: [],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
      isDenunciated: json['is_denunciated'] as bool? ?? false,
    );
  }
}

class UserCreate {
  final String firstName;
  final String lastName;
  final String email;
  final String description;
  final String nickname;
  final String cpf;
  final List<String> categories;

  UserCreate({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.description = '',
    this.nickname = '',
    required this.cpf,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': this.firstName,
      'last_name': this.lastName,
      'email': this.email,
      'description': this.description,
      'nickname': this.nickname,
      'cpf': this.cpf,
      'categories': this.categories
    };
  }
}