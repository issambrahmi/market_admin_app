class CategorieModel {
  final String name;
  final int id;

  CategorieModel({required this.name, required this.id});

  factory CategorieModel.fromMap(Map<String, dynamic> data) {
    return CategorieModel(name: data['name'], id: data['id']);
  }
}
