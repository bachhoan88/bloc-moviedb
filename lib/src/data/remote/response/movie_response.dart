import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_base/src/models/models.dart';

class MovieResponse extends Equatable {
  final int page;
  final List<Movie> movies;
  final int totalPages;
  final int totalResult;

  MovieResponse({this.page, this.movies, this.totalPages, this.totalResult});

  factory MovieResponse.parserFromJson(Map<String, dynamic> result) {
    return MovieResponse(
      page: result['page'],
      movies: (result['results'] as List)?.map((e) => Movie.parserFromJson(e))?.toList(),
      totalPages: result['total_pages'],
      totalResult: result['total_results'],
    );
  }

  @override
  List<Object> get props => [page, movies, totalPages, totalResult];
}