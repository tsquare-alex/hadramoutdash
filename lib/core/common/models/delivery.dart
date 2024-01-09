
import 'package:hadramoutdash/src/app_export.dart';

class DeliveryModel extends Equatable {
  final String title;
  final double fees;


  const DeliveryModel({
    required this.title,
    required this.fees,
  });

  @override
  List<Object?> get props => [
    title,
    fees,
  ];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'fees': fees,
    };
  }

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      title: json['title'] ?? '',
      fees: json['fees']?.toDouble() ?? 0.0,
    );
  }
}
