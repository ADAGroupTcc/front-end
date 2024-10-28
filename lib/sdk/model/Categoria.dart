class Categoria {
  final String id;
  final String name;

  Categoria({
    required this.id,
    required this.name,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  // Método toJson para converter a instância em um mapa
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class SelectedCategories {
  static List<String> selectedCategories = [];
  static List<Categoria> allCategories = [];
}