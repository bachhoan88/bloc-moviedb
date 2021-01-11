import 'package:flutter_bloc_base/src/models/models.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(String type);

  Future<MovieInfo> getMovieInfo(int movieId);

  Future<MovieImage> getMovieImages(int movieId);
}