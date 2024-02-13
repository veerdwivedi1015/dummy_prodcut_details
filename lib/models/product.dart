import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.description,
    required this.image,
    required this.title,
    required this.price,
  });

  final int id;
  final String description;
  final String price;
  final String image;
  final String title;

  factory Product.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return const Product(
        id: -1,
        description: "Error",
        price: "",
        image: "Error",
        title: "Error",
      );
    }

    return Product(
      id: map['id'],
      description: map['description'],
      price: (map['price']).toString(),
      image: map['image'],
      title: map['title'],
    );
  }

  @override
  List<Object?> get props => [id, title, price];
}
