import '../../../src/app_export.dart';

class ClientModel extends Equatable {
  final String uid;
  final String name;
  final int number;
  final String address;
  final String building;
  final String? floor;
  final String? apartment;

  const ClientModel({
    required this.uid,
    required this.name,
    required this.number,
    required this.address,
    required this.building,
    this.floor,
    this.apartment,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        address,
        number,
        building,
        floor,
        apartment,
      ];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'number': number,
      'address': address,
      'building': building,
      'floor': floor,
      'apartment': apartment,
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      number: json['number']?.toInt() ?? 0,
      address: json['address'] ?? '',
      building: json['building'] ?? '',
      floor: json['floor'] ?? '',
      apartment: json['apartment'] ?? '',
    );
  }
}
