import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc_base/src/bloc/blocs.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_event.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_state.dart';
import 'package:flutter_bloc_base/src/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:flutter_bloc_base/src/bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:flutter_bloc_base/src/data/movie_repository.dart';
import 'package:flutter_bloc_base/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../movie_detail_factory.dart';
import '../../movie_factory.dart';
import '../connectivity_mock.dart';
import '../movie_repository_mock.dart';

void main() {
  group('Test MovieBloc Init', () {
    MovieDetailBloc movieDetailBloc;
    final MovieRepository movieRepository = MovieRepositoryMock();

    setUp(() {
      movieDetailBloc = MovieDetailBloc(movieRepository);
    });

    test('Test default init', () {
      expect(movieDetailBloc.state, MovieDetailInit());
    });

    tearDown(() {
      movieDetailBloc.close();
    });
  });

  group('Test Get Movie detail with no internet', () {
    final MovieRepository movieRepository = MovieRepositoryMock();
    final Connectivity connectivity = ConnectivityMock();

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [] when nothing is added',
      build: () => MovieDetailBloc(movieRepository),
      expect: const <MovieDetailState>[],
    );

    final movieId = 1;
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [GetMovieDetailError] when GetMovieDetailEvent is added',
      build: () => MovieDetailBloc(movieRepository),
      act: (bloc) async => {
        bloc.connectivity = connectivity,
        bloc.add(GetMovieDetailEvent(movieId))
      },
      expect: [GetMovieDetailError('Please check the network connection')],
    );
  });

  group('Test Get Movie Detail with has wifi internet', () {
    final MovieRepository movieRepository = MovieRepositoryMock();
    final Connectivity connectivity = ConnectivityMock();

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [] when nothing is added',
      build: () => MovieDetailBloc(movieRepository),
      expect: const <MovieDetailState>[],
    );

    final movieId = 1;
    final info = createMovieInfo;

    when(movieRepository.getMovieInfo(movieId)).thenAnswer((_) async => info);
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [GetMovieDetailSuccess] when GetMovieDetailEvent is added',
      build: () => MovieDetailBloc(movieRepository),
      act: (bloc) async => {
        bloc.connectivity = connectivity,
        bloc.add(GetMovieDetailEvent(movieId))
      },
      expect: [GetMovieDetailSuccess(info)],
    );
  });

  group('Test Fetch Movie with has mobile internet', () {
    final MovieRepository movieRepository = MovieRepositoryMock();
    final Connectivity connectivity = ConnectivityMock();

    final movieId = 1;
    final info = createMovieInfo;

    when(movieRepository.getMovieInfo(movieId)).thenAnswer((_) async => info);
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [GetMovieDetailSuccess] when GetMovieDetailEvent is added',
      build: () => MovieDetailBloc(movieRepository),
      act: (bloc) async => {
        bloc.connectivity = connectivity,
        bloc.add(GetMovieDetailEvent(movieId))
      },
      expect: [GetMovieDetailSuccess(info)],
    );
  });

  group('Test Fetch Movie with has mobile internet', () {
    final MovieRepository movieRepository = MovieRepositoryMock();
    final Connectivity connectivity = ConnectivityMock();

    final movieId = 1;
    final exception = Exception('Error');

    when(movieRepository.getMovieInfo(movieId)).thenThrow(exception);
    when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [GetMovieDetailSuccess] when GetMovieDetailEvent is added',
      build: () => MovieDetailBloc(movieRepository),
      act: (bloc) async => {
        bloc.connectivity = connectivity,
        bloc.add(GetMovieDetailEvent(movieId))
      },
      expect: [GetMovieDetailError(exception.toString())],
    );
  });
}
