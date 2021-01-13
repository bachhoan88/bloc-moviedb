import 'package:flutter_bloc_base/src/models/collection.dart';
import 'package:flutter_bloc_base/src/models/company.dart';
import 'package:flutter_bloc_base/src/models/country.dart';
import 'package:flutter_bloc_base/src/models/genre.dart';
import 'package:flutter_bloc_base/src/models/language.dart';
import 'package:flutter_bloc_base/src/models/movie_info.dart';

Collection createCollection = Collection(
  id: 1,
  name: 'Name',
  posterPath: '',
  backdropPath: '',
);

Company createCompany = Company(
  id: 1,
  name: 'Name',
  logoPath: '',
  originalCountry: '',
);

Country createCountry = Country(
  name: 'Name',
  code: 'n',
);

Genre createGenre = Genre(
  id: 1,
  name: 'Fantasy',
);

Language createLanguage = Language(
  name: 'En',
  countryCode: 'en',
  engName: 'Name',
);

MovieInfo createMovieInfo = MovieInfo(
  adult: false,
  backdropPath: '',
  budget: 1,
  homepage: 'home-page',
  id: 1,
  imdbId: '123',
  originalTitle: 'Title',
  originalLanguage: 'En',
  overview: 'Overview',
  popularity: 4.0,
  posterPath: 'poster',
  releaseDate: '2020-12-12',
  revenue: 12345,
  runtime: 123,
  status: 'Released',
  tagline: 'A new era of wonder begins.',
  title: 'Wonder Woman 1984',
  video: false,
  voteCount: 1234,
  voteAverage: 4.0,
  genres: List.of([createGenre]),
  countries: List.of([createCountry]),
  companies: List.of([createCompany]),
  collection: createCollection,
  languages: List.of([createLanguage]),
);
