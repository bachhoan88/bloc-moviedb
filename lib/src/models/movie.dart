import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final int voteCount;
  final bool video;
  final double voteAverage;
  final String title;
  final double popularity;
  final String posterPath;
  final String originalLanguage;
  final String originalTitle;
  final List<int> genreIds;
  final String backdropPath;
  final bool adult;
  final String overview;
  final String releaseDate;

  Movie({
    this.id,
    this.voteCount,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  factory Movie.parserFromJson(Map<String, dynamic> result) {
    if (result == null) return null;

    return Movie(
      id: result['id'],
      voteCount: result['vote_count'],
      video: result['video'],
      voteAverage: double.parse(result['vote_average'].toString()),
      title: result['title'],
      popularity: result['popularity'],
      posterPath: result['poster_path'],
      originalTitle: result['original_title'],
      originalLanguage: result['original_language'],
      backdropPath: result['backdrop_path'],
      adult: result['adult'],
      overview: result['overview'],
      releaseDate: result['release_date'],
      genreIds: List<int>.from(result['genre_ids']),
    );
  }

  @override
  List<Object> get props => [
        id,
        voteAverage,
        video,
        voteAverage,
        title,
        posterPath,
        posterPath,
        originalLanguage,
        originalTitle,
        genreIds,
        backdropPath,
        adult,
        overview,
        releaseDate,
      ];
}