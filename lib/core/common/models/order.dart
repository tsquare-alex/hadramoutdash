import '../../../src/app_export.dart';

import 'client.dart';
import 'dishes.dart';
import 'species.dart';

class OrderModel extends Equatable {
  final String id;
  final bool cancelled;
  final ClientModel client;
  final bool confirmed;
  final double deliveryFees;
  final bool delivered;
  final double price;
  final String createdAt;
  final List<SpeciesModel>? species;
  final List<DishesModel>? dishes;

  const OrderModel({
    required this.id,
    required this.cancelled,
    required this.client,
    required this.confirmed,
    required this.deliveryFees,
    required this.delivered,
    required this.price,
    required this.createdAt,
    this.species,
    this.dishes,
  });

  @override
  List<Object?> get props => [
        id,
        cancelled,
        client,
        confirmed,
        delivered,
        deliveryFees,
        price,
        species,
        dishes,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cancelled': cancelled,
      'client': client.toJson(),
      'confirmed': confirmed,
      'delivery_fees': deliveryFees,
      'delivered': delivered,
      'price': price,
      'created_at': createdAt,
      'species': species?.map((x) => x.toJson()).toList(),
      'dishes': dishes?.map((x) => x.toJson()).toList(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      cancelled: json['cancelled'] ?? false,
      client: ClientModel.fromJson(json['client']),
      confirmed: json['confirmed'] ?? false,
      deliveryFees: json['delivery_fees']?.toDouble() ?? 0.0,
      delivered: json['delivered'] ?? false,
      price: json['price']?.toDouble() ?? 0.0,
      createdAt: json['created_at'] ?? '',
      species: json['species'] != null
          ? List<SpeciesModel>.from(
              json['species']?.map((x) => SpeciesModel.fromJson(x)))
          : null,
      dishes: json['dishes'] != null
          ? List<DishesModel>.from(
              json['dishes']?.map((x) => DishesModel.fromJson(x)))
          : null,
    );
  }
}
