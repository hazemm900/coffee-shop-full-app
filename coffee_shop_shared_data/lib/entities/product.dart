import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double offerPrice;
  final List<String> ingredients;
  final bool isAvailable;
  final bool isFeatured;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.offerPrice,
    required this.ingredients,
    required this.isAvailable,
    required this.isFeatured,
  });

  bool get isOnOffer => offerPrice > 0;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    imageUrl,
    category,
    offerPrice,
    ingredients,
    isAvailable,
    isFeatured,
  ];
}
