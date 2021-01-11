import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String name;

  Genre({this.id, this.name});

  factory Genre.parserFromJson(Map<String, dynamic> result) {
    if (result == null) return null;
    return Genre(id: result['id'], name: result['name']);
  }

  @override
  List<Object> get props => [id, name];
}
