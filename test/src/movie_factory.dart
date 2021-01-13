import 'package:flutter_bloc_base/src/models/models.dart';

Movie get createMovie => Movie(
  id: 1,
  voteCount: 100,
  video: false,
  voteAverage: 4.0,
  title: 'Movie name',
  posterPath: 'poster-path',
  popularity: 2.0,
  originalLanguage: 'en',
  originalTitle: 'Movie name',
  genreIds: List.of([1, 2, 3]),
  backdropPath: 'backdrop-path',
  adult: false,
  overview: 'movie overview',
  releaseDate: '2020-12-12',
);