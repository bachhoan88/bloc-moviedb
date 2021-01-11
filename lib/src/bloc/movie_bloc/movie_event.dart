import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
}

class FetchMovieWithType extends MovieEvent {
  final String type;

  FetchMovieWithType(this.type);

  @override
  List<Object> get props => [type];
}