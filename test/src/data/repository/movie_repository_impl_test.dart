import 'package:flutter_bloc_base/src/data/constant/constant.dart';
import 'package:flutter_bloc_base/src/data/repository/movie_repository_impl.dart';
import 'package:flutter_bloc_base/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../../movie_factory.dart';

class ClientMock extends Mock implements Client {}

void main() {
  group('Fetch Movies with Type', () {
    test('Return a [Movie] when fetch Movie with Type [popular]', () async {
      final client = ClientMock();
      final type = Constant.popular;
      final API_KEY = 'd61431a2fb64b6e56c6f086952e63ab6';

      when(client.get('https://api.themoviedb.org/3/movie/$type?api_key=$API_KEY')).thenAnswer((_) async => Response(
            createMovieJson,
            200,
          ));

      final repository = MovieRepositoryImpl(client: client);

      expect(await repository.fetchMovies(type), isA<List<Movie>>());
    });

    test('Throws [Exception] on non-200 response', () async {
      final client = ClientMock();
      final type = Constant.popular;
      final API_KEY = 'd61431a2fb64b6e56c6f086952e63ab6';

      when(client.get('https://api.themoviedb.org/3/movie/$type?api_key=$API_KEY')).thenAnswer((_) async => Response(
        'Not Found',
        404,
      ));

      final repository = MovieRepositoryImpl(client: client);

      expect(
            () async => await repository.fetchMovies(type),
        throwsA(isA<Exception>()),
      );
    });

    test('Throws [Exception] when fetch Movie with Type [popular] on parser error', () async {
      final client = ClientMock();
      final type = Constant.popular;
      final API_KEY = 'd61431a2fb64b6e56c6f086952e63ab6';

      when(client.get('https://api.themoviedb.org/3/movie/$type?api_key=$API_KEY')).thenAnswer((_) async => Response(
        'error parser',
        200,
      ));

      final repository = MovieRepositoryImpl(client: client);

      expect(
            () async => await repository.fetchMovies(type),
        throwsA(isA<Exception>()),
      );
    });
  });
}
