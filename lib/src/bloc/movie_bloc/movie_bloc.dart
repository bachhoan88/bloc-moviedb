import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_event.dart';
import 'package:flutter_bloc_base/src/bloc/movie_bloc/movie_state.dart';
import 'package:flutter_bloc_base/src/data/movie_repository.dart';
import 'package:flutter_bloc_base/src/data/repository/movie_repository_impl.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  Connectivity connectivity = Connectivity();

  MovieBloc(this.movieRepository) : super(MovieInit());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    final connectResult = await connectivity.checkConnectivity();
    if (connectResult == ConnectivityResult.none) {
      yield MovieFetchError('Please check the network connection');
      return;
    }

    if (event is FetchMovieWithType) {
      try {
        final movies = await movieRepository.fetchMovies(event.type);
        yield MovieFetched(movies, event.type);
        return;
      } on Exception catch(e) {
        yield MovieFetchError(e.toString());
      }
    }

    addError(Exception('Cannot support the event'));
  }
}