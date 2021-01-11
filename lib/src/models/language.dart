import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final String name;
  final String engName;
  final String countryCode;

  Language({this.name, this.engName, this.countryCode});

  factory Language.parserFromJson(Map<String, dynamic> result) {
    if (result == null) return null;

    return Language(
      name: result['name'],
      engName: result['english_name'],
      countryCode: result['iso_639_1'],
    );
  }

  @override
  List<Object> get props => [name, engName, countryCode];
}