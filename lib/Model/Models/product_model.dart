class ProductModel {
  final int? id;
  final String name;
  final String? categorirName;
  final String? image;
  final double priceD;
  final double priceG;
  final double priceSG;
  final int minQntG;
  final int minQntSG;

  ProductModel({
    this.id,
    required this.name,
    this.categorirName,
    this.image,
    required this.priceD,
    required this.priceG,
    required this.priceSG,
    required this.minQntG,
    required this.minQntSG,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
        id: data['id'],
        name: data['name'],
        categorirName: data['categorie_name'],
        image: data['image'],
        priceD: data['price_d'] is double
            ? data['price_d']
            : double.parse(data['price_d'].toString()),
        priceG: data['price_g'] is double
            ? data['price_g']
            : double.parse(data['price_g'].toString()),
        priceSG: data['price_sg'] is double
            ? data['price_sg']
            : double.parse(data['price_sg'].toString()),
        minQntG: data['min_qnt_g'] is int
            ? data['min_qnt_g']
            : int.parse(data['min_qnt_g']),
        minQntSG: data['min_qnt_sg'] is int
            ? data['min_qnt_sg']
            : int.parse(data['min_qnt_sg']));
  }
}
