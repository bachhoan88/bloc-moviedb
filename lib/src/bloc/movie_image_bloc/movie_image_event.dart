
import 'package:equatable/equatable.dart';

class GetMovieImagesEvent extends Equatable {
  final int movieId;
  GetMovieImagesEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}