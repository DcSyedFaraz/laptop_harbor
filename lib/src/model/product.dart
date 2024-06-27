import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptop_harbor/core/app_data.dart';
import 'package:laptop_harbor/src/model/product_size_type.dart';

enum ProductType { all, watch, mobile, headphone, tablet, tv }

class Product {
  String name;
  int price;
  int? off;
  String about;
  bool isAvailable;
  ProductSizeType? sizes;
  int _quantity;
  List<String> images;
  bool isFavorite;
  double rating;
  ProductType type;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  Product({
    required this.name,
    required this.price,
    required this.isAvailable,
    this.off,
    required this.quantity,
    required this.images,
    required this.isFavorite,
    required this.rating,
    required this.type,
  });
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      name: data['name'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      isAvailable: data['isAvailable'] ?? false,
      off: data['off']?.toDouble(),
      quantity: data['quantity'] ?? 0,
      images: List<String>.from(data['images'] ?? []),
      isFavorite: data['isFavorite'] ?? false,
      rating: data['rating'] ?? 0,
      type: ProductType.values.firstWhere(
        (e) => e.toString() == 'ProductType.${data['type']}',
        orElse: () => ProductType.unknown,
      ),
    );
  }
}
