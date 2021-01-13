import 'dart:convert';

import 'package:flutter_bloc_base/src/data/movie_repository.dart';
import 'package:flutter_bloc_base/src/data/remote/response/movie_response.dart';
import 'package:flutter_bloc_base/src/models/movie.dart';
import 'package:flutter_bloc_base/src/models/movie_image.dart';
import 'package:flutter_bloc_base/src/models/movie_info.dart';
import 'package:http/http.dart';

class MovieRepositoryImpl extends MovieRepository {
  final API_KEY = 'd61431a2fb64b6e56c6f086952e63ab6';
  final Client _client;

  MovieRepositoryImpl({Client client}) : _client = client ?? Client();

  @override
  Future<List<Movie>> fetchMovies(String type) async {
    final response = await _client.get('https://api.themoviedb.org/3/movie/$type?api_key=$API_KEY');
    if (response.statusCode == 200) {
      return MovieResponse.parserFromJson(json.decode(response.body))?.movies ?? List.empty();
    } else {
      throw Exception('Fail to load movie');
    }
  }

  @override
  Future<MovieInfo> getMovieInfo(int movieId) async {
    final response = await _client.get('https://api.themoviedb.org/3/movie/$movieId?api_key=$API_KEY');
    if (response.statusCode == 200) {
      return MovieInfo.parserFromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load movie info');
    }
  }

  @override
  Future<MovieImage> getMovieImages(int movieId) async {
    final response = await _client.get('https://api.themoviedb.org/3/movie/$movieId/images?api_key=$API_KEY');
    if (response.statusCode == 200) {
      return MovieImage.parserFromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load movie info');
    }
  }
}