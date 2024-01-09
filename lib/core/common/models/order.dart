import 'package:intl/intl.dart';

import '../../../src/app_export.dart';

import 'cart.dart';
import 'client.dart';
import 'delivery.dart';


class OrderModel extends Equatable {
  final String id;
  final bool cancelled;
  final ClientModel client;
  final bool confirmed;
  final bool delivered;
  final double total;
  final double subTotal;
  final String createdAt;
  final DateTime orderDate;
  final String orderTime;
  final String orderMethod;
  final List<CartModel> cartModel;
  final DeliveryModel? deliveryModel;


  const OrderModel({
    required this.id,
    required this.cancelled,
    required this.client,
    required this.confirmed,
    required this.orderDate,
    required this.orderTime,
    required this.orderMethod,
    this.deliveryModel,
    required this.delivered,
    required this.total,
    required this.subTotal,
    required this.createdAt,
    required this.cartModel,

  });

  @override
  List<Object?> get props => [
    id,
    cancelled,
    client,
    confirmed,
    orderDate,
    delivered,
    deliveryModel,
    total,
    cartModel,
    orderTime,
    orderDate,
    orderMethod,
  ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cancelled': cancelled,
      'client': client.toJson(),
      'confirmed': confirmed,
      'order_date': orderDate,
      'order_time': orderTime,
      'order_method': orderMethod,
      'delivery_details': deliveryModel?.toJson(),
      'delivered': delivered,
      'total': total,
      'sub_total': subTotal,
      'created_at': createdAt,
      'items': cartModel.map((x) => x.toJson()).toList(),
    };
  }
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      cancelled: json['cancelled'] ?? false,
      client: ClientModel.fromJson(json['client']),
      confirmed: json['confirmed'] ?? false,
      delivered: json['delivered'] ?? false,
      total: json['total']?.toDouble() ?? 0.0,
      subTotal: json['sub_total']?.toDouble() ?? 0.0,
      createdAt: json['created_at'] ?? '',
      orderDate: json['order_date'] is String
          ? DateFormat('yyyy-MM-dd').parse(json['order_date'])
          : DateTime.now(),
      orderTime: json['order_time'] ?? '',
      orderMethod: json['order_method'] ?? '',
      cartModel: (json['items'] as List<dynamic>? ?? []).map((itemJson) => CartModel.fromJson(itemJson)).toList(),
      deliveryModel: json['delivery_details'] != null
          ? DeliveryModel.fromJson(json['delivery_details'])
          : null,
    );
  }





}
// factory OrderModel.fromJson(Map<String, dynamic> json) {
//   return OrderModel(
//     id: json['id'] ?? '',
//     cancelled: json['cancelled'] ?? false,
//     client: ClientModel.fromJson(json['client']),
//     confirmed: json['confirmed'] ?? false,
//     delivered: json['delivered'] ?? false,
//     price: json['price']?.toDouble() ?? 0.0,
//     createdAt: json['created_at'] ?? '',
//     orderDate: json['order_date'] is String
//         ? DateTime.parse(json['order_date'])
//         : DateTime.now(),
//     orderTime: json['order_time'] ?? '',
//     orderMethod: json['order_method'] ?? '',
//     cartModel: (json['items'] as List<dynamic>? ?? []).map((itemJson) => CartModel.fromJson(itemJson)).toList(),
//     deliveryModel: json['delivery_details'] != null
//         ? DeliveryModel.fromJson(json['delivery_details'])
//         : null,
//   );
// }