import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String image;
  final bool enable;

  ProductEntity({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.enable,
  });

  @override
  List<Object> get props {
    return [
      name,
      description,
      price,
      image,
      enable,
    ];
  }
}
