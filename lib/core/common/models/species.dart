
import 'package:equatable/equatable.dart';

import 'section.dart';

class SpeciesModel extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? image;
  final double price;
  final String createdAt;
  final SectionModel section;
  final bool? offer;
  final int? offerValue;

  SpeciesModel({
    required this.id,
    required this.title,
    this.description,
    this.image,
    required this.price,
    required this.createdAt,
    required this.section,
    this.offer,
    this.offerValue,
  });

  @override
  List<Object?> get props =>
      [id, title, description, image, price, createdAt, section,offer,offerValue];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'created_at': createdAt,
      'section': section.toJson(),
      'offer': offer,
      'offerValue': offerValue,
    };
  }

  factory SpeciesModel.fromJson(Map<String, dynamic> json) {
    return SpeciesModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      image: json['image'],
      price: json['price']?.toDouble() ?? 0.0,
      createdAt: json['created_at'] ?? '',
      section: SectionModel.fromJson(json['section']),
      offer: json['offer'] ?? false,
      offerValue: json['offerValue']?.toInt() ?? 0,
    );
  }
}