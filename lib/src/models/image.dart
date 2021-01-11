import 'package:equatable/equatable.dart';

class Img extends Equatable {
  final double aspect;
  final String imagePath;
  final int height;
  final int width;
  final String countryCode;
  final double voteAverage;
  final int voteCount;

  Img({
    this.aspect,
    this.imagePath,
    this.height,
    this.width,
    this.countryCode,
    this.voteAverage,
    this.voteCount,
  });

  factory Img.parserFromJson(Map<String, dynamic> result) {
    if (result == null) return null;

    return Img(
      imagePath: result['file_path'],
      aspect: double.parse(result['aspect_ratio']?.toString() ?? '0') ?? 1.0,
      height: result['height'] ?? 0,
      width: result['width'] ?? 1,
      countryCode: result['iso_639_1'],
      voteAverage: result['vote_average'],
      voteCount: result['vote_count'],
    );
  }

  @override
  List<Object> get props => [aspect, imagePath, width, height, countryCode, voteCount, voteAverage, voteCount];
}