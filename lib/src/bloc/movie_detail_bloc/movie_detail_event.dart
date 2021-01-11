import 'package:equatable/equatable.dart';

class GetMovieDetailEvent extends Equatable {
  final int movieId;
  GetMovieDetailEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}