import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc_base/src/bloc/blocs.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_event.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_state.dart';
import 'package:flutter_bloc_base/src/data/movie_repository.dart';
import 'package:flutter_bloc_base/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../movie_factory.dart';
import '../connectivity_mock.dart';
import '../movie_repository_mock.dart';

void main() {
  group('Test MovieBloc Init', () {
    MovieBloc movieBloc;
    final MovieRepository movieRepository = MovieRepositoryMock();

    setUp(() {
      movieBloc = MovieBloc(movieRepository);
    });

    test('Test default init', () {
      expect(movieBloc.state, MovieInit());
    });

    tearDown(() {
      movieBloc.close();
    });
  });

  group('Test Fetch Movie with no internet', () {
    final MovieRepository movieRepository = MovieRepositoryMock();
    final Connectivity connectivity = ConnectivityMock();

    blocTest<MovieBloc, MovieState>(
      'emits [] when nothing is added',
      build: () => MovieBloc(movieRepository),
      expect: const <MovieState>[],
    );

    final type = 'type';
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);

    blocTest<MovieBloc, MovieState>(
      'emits [MovieFetchError] when FetchMovieWithType is added',
      build: () => MovieBloc(movieRepository),
      act: (bloc) async => {
        bloc.connectivity = connectivity,
        bloc.add(FetchMovieWithType(type))
      },
      expect: <MovieState>[MovieFetchError('Please check the network connection')],
    );
  });

  group('Test Fetch Movie with has wifi internet', () {
    final MovieRepository movieRepository = MovieRepositoryMock();
    final Connectivity connectivity = ConnectivityMock();

    blocTest<MovieBloc, MovieState>(
      'emits [] when nothing is added',
      build: () => MovieBloc(movieRepository),
      expect: const <MovieState>[],
    );

    final type = 'type';
    final movies = List<Movie>.from([createMovie]);

    when(movieRepository.fetchMovies(type)).thenAnswer((_) async => movies);
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

    blocTest<MovieBloc, MovieState>(
      'emits [MovieFetched] when FetchMovieWithType is added',
      build: () => MovieBloc(movieRepository),
      act: (bloc) async => {
        bloc.connectivity = connectivity,
        bloc.add(FetchMovieWithType(type))
      },
      expect: <MovieState>[MovieFetched(movies, type)],
    );
  });

  group('Test Fetch Movie with has mobile internet', () {
    final MovieRepository movieRepository = MovieRepositoryMock();
    final Connectivity connectivity = ConnectivityMock();

    final type = 'type';
    final movies = List<Movie>.from([createMovie]);

    when(movieRepository.fetchMovies(type)).thenAnswer((_) async => movies);
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);

    blocTest<MovieBloc, MovieState>(
      'emits [MovieFetched] when FetchMovieWithType is added',
      build: () => MovieBloc(movieRepository),
      act: (bloc) async => {
        bloc.connectivity = connectivity,
        bloc.add(FetchMovieWithType(type))
      },
      expect: <MovieState>[MovieFetched(movies, type)],
    );
  });


  group('Test Fetch Movie with has internet and repository return [error]', () {
    final MovieRepository movieRepository = MovieRepositoryMock();
    final Connectivity connectivity = ConnectivityMock();

    final type = 'type';
    final message = 'Error';
    final exception = Exception(message);

    when(movieRepository.fetchMovies(type)).thenThrow(exception);
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

    blocTest<MovieBloc, MovieState>(
      'emits [MovieFetched] when FetchMovieWithType is added',
      build: () => MovieBloc(movieRepository),
      act: (bloc) async => {
        bloc.connectivity = connectivity,
        bloc.add(FetchMovieWithType(type))
      },
      expect: <MovieState>[MovieFetchError(exception.toString())],
    );
  });
}
