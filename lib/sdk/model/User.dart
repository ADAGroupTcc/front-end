import 'Categoria.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  String? description;
  String? nickname;
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
    this.description,
    this.nickname,
    this.cpf = '',
    this.categories = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isDenunciated = false,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> user) {
    String parseString(String? value, [String defaultValue = '']) =>
        value ?? defaultValue;
    return User(
      id: parseString(user['id']),
      firstName: parseString(user['first_name']),
      lastName: parseString(user['last_name']),
      email: parseString(user['email']),
      description: parseString(user['description']),
      nickname: parseString(user['nickname']),
      cpf: parseString(user['cpf']),
      categories: (user['categories'] as List<dynamic>?)
              ?.map((categorieJson) =>
                  Categoria.fromJson(categorieJson as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: user['created_at'] != null
          ? DateTime.parse(user['created_at'])
          : DateTime.now(),
      updatedAt: user['updated_at'] != null
          ? DateTime.parse(user['updated_at'])
          : DateTime.now(),
      isDenunciated: user['is_denunciated'] as bool? ?? false,
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
      'categories': categories.map((category) => category.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_denunciated': isDenunciated,
    };
  }
}

class UserCreate {
  final String firstName;
  final String lastName;
  final String email;
  final String description;
  final String nickname;
  final String cpf;
  List<String> categories;
  List<double?> location = [];
  final String password;

  UserCreate(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.description = '',
      this.nickname = '',
      required this.cpf,
      required this.categories,
      this.password = ''});

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'description': description,
      'nickname': nickname,
      'cpf': cpf,
      'categories': categories,
      'location': location
    };
  }
}
