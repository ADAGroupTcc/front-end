class Categoria {
  final String id;
  final String name;
  final String description;
  final int classification;
  final DateTime createdAt;
  final DateTime updatedAt;

  Categoria({
    required this.id,
    required this.name,
    required this.description,
    required this.classification,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      classification: json['classification'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Método toJson para converter a instância em um mapa
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'classification': classification,
      'createdAt': createdAt.toIso8601String(), // Formata a data como string
      'updatedAt': updatedAt.toIso8601String(), // Formata a data como string
    };
  }
}
