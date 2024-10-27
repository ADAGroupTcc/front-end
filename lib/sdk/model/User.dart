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
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.description = '',
    this.nickname = '',
    this.cpf = '',
    this.categories = const [],
    DateTime?
        createdAt,
    DateTime? updatedAt,
    this.isDenunciated = false,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> user) {
    String _parseString(String? value, [String defaultValue = '']) => value ?? defaultValue;
    return User(
      id: _parseString(user['id']),
      firstName: _parseString(user['first_name']),
      lastName: _parseString(user['last_name']),
      email: _parseString(user['email']),
      description: _parseString(user['description']),
      nickname: _parseString(user['nickname']),
      cpf: _parseString(user['cpf']),
      categories: (user['categories'] as List<dynamic>?)
          ?.map((categorieJson) => Categoria.fromJson(categorieJson as Map<String, dynamic>))
          .toList() ?? [],
      createdAt: user['created_at'] != null ? DateTime.parse(user['created_at']) : DateTime.now(),
      updatedAt: user['updated_at'] != null ? DateTime.parse(user['updated_at']) : DateTime.now(),
      isDenunciated: user['is_denunciated'] as bool? ?? false,
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