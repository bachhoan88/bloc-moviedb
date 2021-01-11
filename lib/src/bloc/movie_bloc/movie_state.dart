import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_base/src/models/models.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieInit extends MovieState {}

class MovieFetched extends MovieState {
  final List<Movie> movies;
  final String type;
  MovieFetched(this.movies, this.type);

  @override
  List<Object> get props => [movies, type];
}

class MovieFetchError extends MovieState {
  final String message;
  MovieFetchError(this.message);

  @override
  List<Object> get props => [message];
}