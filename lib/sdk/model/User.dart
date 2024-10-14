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
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.description,
    required this.nickname,
    required this.cpf,
    required this.categories,
    required this.createdAt,
    required this.updatedAt,
    required this.isDenunciated
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      nickname: json['nickname'] as String,
      cpf: json['cpf'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((categorieJson) => Categoria.fromJson(categorieJson as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as DateTime,
      updatedAt: json['updatedAt'] as DateTime,
      isDenunciated: json['isDenunciated'] as bool
    );
  }

  
}