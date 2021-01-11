import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final int id;
  final String logoPath;
  final String name;
  final String originalCountry;

  Company({this.id, this.logoPath, this.name, this.originalCountry});

  factory Company.parserFromJson(Map<String, dynamic> result) {
    if (result == null) return null;

    return Company(
      id: result['id'],
      logoPath: result['logo_path'],
      name: result['name'],
      originalCountry: result['origin_country'],
    );
  }

  @override
  List<Object> get props => [id, logoPath, name, originalCountry];
}