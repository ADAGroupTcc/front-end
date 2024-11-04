class Categoria {
  final String id;
  final String name;

  Categoria({
    required this.id,
    this.name = ''
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

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

class CategoriesResponse {
  final List<Categoria> categories;
  final int next;
  CategoriesResponse({required this.categories, required this.next});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    final categoriesRaw = json["categories"] as List<dynamic>;
    final next = json["next_page"] as int? ?? 1;
    List<Categoria> categories = [];
    for (var elem in categoriesRaw) {
      categories.add(Categoria.fromJson(elem));
    }

    return CategoriesResponse(categories: categories, next: next);
  }
}