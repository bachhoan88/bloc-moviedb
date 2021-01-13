import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base/src/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:flutter_bloc_base/src/bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:flutter_bloc_base/src/data/movie_repository.dart';

class MovieDetailBloc extends Bloc<GetMovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;
  Connectivity connectivity = Connectivity();

  MovieDetailBloc(this.movieRepository) : super(MovieDetailInit());

  @override
  Stream<MovieDetailState> mapEventToState(GetMovieDetailEvent event) async* {
    final connection = await connectivity.checkConnectivity();
    if (connection == ConnectivityResult.none) {
      yield GetMovieDetailError('Please check the network connection');
      return;
    }

    if (event is GetMovieDetailEvent) {
      try {
        final info = await movieRepository.getMovieInfo(event.movieId);
        yield GetMovieDetailSuccess(info);
        return;
      } on Exception catch(e) {
        yield GetMovieDetailError(e.toString());
      }
    }

    addError(Exception('Cannot support the event'));
  }
}
