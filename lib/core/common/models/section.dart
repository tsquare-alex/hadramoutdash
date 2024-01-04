import '../../../src/app_export.dart';

class SectionModel extends Equatable {
  final String id;
  final String title;

  const SectionModel({
    required this.id,
    required this.title,
  });

  @override
  List<Object> get props => [id, title];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
