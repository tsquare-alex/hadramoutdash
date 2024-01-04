import '../../../src/app_export.dart';

import 'section.dart';

class DishesModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String image;
  final double price;
  final int? quantity;
  final String createdAt;
  final SectionModel section;
  final bool offer;
  final int offerValue;

  const DishesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    this.quantity,
    required this.createdAt,
    required this.section,
    required this.offer,
    required this.offerValue,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        price,
        createdAt,
        section,
        offer,
        offerValue,
        quantity,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'quantity': quantity,
      'created_at': createdAt,
      'section': section.toJson(),
      'offer': offer,
      'offerValue': offerValue,
    };
  }

  factory DishesModel.fromJson(Map<String, dynamic> json) {
    return DishesModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      quantity: json['quantity']?.toInt() ?? 1,
      createdAt: json['created_at'] ?? '',
      section: SectionModel.fromJson(json['section']),
      offer: json['offer'] ?? false,
      offerValue: json['offerValue']?.toInt() ?? 0,
    );
  }
}
