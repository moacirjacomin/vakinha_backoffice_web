import 'dart:convert';

import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    int? id,
    required String name,
    required String description,
    required double price,
    required String image,
    required bool enable,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          image: image,
          enable: enable,
        );

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price=$price enable: $enable)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': name,
      'description': name,
      'price': price,
      'image': image,
      'enable': enable,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      image: map['image'] ?? '',
      enable: map['enable'] ?? false,
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> json) {
    var list = <ProductModel>[];

    if (json.isNotEmpty) {
      list = json.map((jsomItem) => ProductModel.fromMap(jsomItem)).toList();
    }

    return list;
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}
