

import 'package:hadramoutdash/core/common/models/section.dart';
import 'package:hadramoutdash/src/app_export.dart';

class CartModel extends Equatable {
  final String title;
  final String? description;
  final String? image;
  double price;
  double totalPrice;
  int quantity;
  final String? createdAt;
  final SectionModel section;
  final bool? offer;
  final int? offerValue;
  CartModel(
      {required this.title,
        this.description,
        this.image,
        required this.price,
        required this.totalPrice,
        required this.quantity,
        this.createdAt,
        required this.section,
        this.offer,
        this.offerValue,
      });

  @override
  List<Object?> get props => [title, description, image, price, quantity,totalPrice,createdAt,section,offer,offerValue];


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'totalPrice': totalPrice,
      'quantity': quantity,
      'createdAt': createdAt,
      'offer': offer,
      'offerValue': offerValue,
      'section': section.toJson(),
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      title: json['title'] ?? '',
      section: SectionModel.fromJson(json['section']),
      description: json['description'],
      createdAt: json['created_at'] ?? '',
      offer: json['offer'] ?? false,
      offerValue: json['offerValue']?.toInt() ?? 0,
      image: json['image'],
      quantity: json['quantity']?.toInt() ?? 1,
      price: json['price']?.toDouble() ?? 0.0,
      totalPrice: json['totalPrice']?.toDouble() ?? 0.0,
    );
  }
}
