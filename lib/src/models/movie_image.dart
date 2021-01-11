import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_base/src/models/models.dart';

class MovieImage extends Equatable {
  final List<Img> backdrops;
  final List<Img> posters;

  MovieImage({this.backdrops, this.posters});

  factory MovieImage.parserFromJson(Map<String, dynamic> result) {
    if (result == null) return null;

    return MovieImage(
      backdrops: (result['backdrops'] as List)?.map((e) => Img.parserFromJson(e))?.toList() ?? List.empty(),
      posters: (result['posters'] as List)?.map((e) => Img.parserFromJson(e))?.toList() ?? List.empty(),
    );
  }

  @override
  List<Object> get props => [backdrops, posters];
}