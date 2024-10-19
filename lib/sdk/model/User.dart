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

  // Definindo parâmetros opcionais
  User({
    this.id = '', // O ID será gerado pelo backend
    required this.firstName,
    required this.lastName,
    required this.email,
    this.description = '', // Campos opcionais com valores padrão
    this.nickname = '',
    required this.cpf,
    this.categories = const [], // Lista vazia como padrão
    DateTime?
        createdAt, // Atribuindo null inicialmente para permitir ser preenchido pelo backend
    DateTime? updatedAt,
    this.isDenunciated = false, // False por padrão na criação
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String? ?? '', // Garante que id nunca seja null
      firstName: json['first_name'] as String? ??
          '', // Garante que firstName nunca seja null
      lastName: json['last_name'] as String? ??
          '', // Garante que lastName nunca seja null
      email:
          json['email'] as String? ?? '', // Garante que email nunca seja null
      description:
          json['description'] as String? ?? '', // Trato com possíveis null
      nickname: json['nickname'] as String? ?? '', // Trato com possíveis null
      cpf: json['cpf'] as String? ?? '', // Garante que cpf nunca seja null
      categories: (json['categories'] as List<dynamic>?)
              ?.map((categorieJson) =>
                  Categoria.fromJson(categorieJson as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(), // Caso created_at não esteja presente
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(), // Caso updated_at não esteja presente
      isDenunciated: json['is_denunciated'] as bool? ??
          false, // Garante que isDenunciated nunca seja null
    );
  }
}
