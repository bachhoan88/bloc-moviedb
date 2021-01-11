import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_base/src/models/models.dart';

class MovieInfo extends Equatable {
  final bool adult;
  final String backdropPath;
  final Collection collection;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final List<Company> companies;
  final List<Country> countries;
  final List<Language> languages;

  MovieInfo({
    this.adult,
    this.backdropPath,
    this.collection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.companies,
    this.countries,
    this.languages,
  });

  String get getCategories {
    var result = genres?.first?.name ?? '';
    for (var i = 1; i < genres.length; i++) {
      result += ', ${genres[i].name}';
    }
    return result;
  }

  String get year {
    var result = '';
    if ((releaseDate?.length ?? 0) > 4) {
      result = releaseDate.substring(0, 4);
    }

    return result;
  }

  String get country {
    var result =  '';
    if ((countries?.length ?? 0) > 0) {
      for (var i = 0; i < countries.length; i++) {
        result += countries[i].code;
        if (i < countries.length - 1) {
          result += ', ';
        }
      }
    } 
    return result;
  }

  factory MovieInfo.parserFromJson(Map<String, dynamic> result) {
    if (result == null) return null;
    return MovieInfo(
      adult: result['adult'],
      backdropPath: result['backdrop_path'],
      budget: result['budget'],
      homepage: result['homepage'],
      id: result['id'],
      imdbId: result['imdb_id'],
      originalLanguage: result['original_language'],
      originalTitle: result['original_title'],
      overview: result['overview'],
      popularity: result['popularity'],
      posterPath: result['poster_path'],
      releaseDate: result['release_date'],
      revenue: result['revenue'],
      runtime: result['runtime'],
      status: result['status'],
      tagline: result['tagline'],
      title: result['title'],
      video: result['video'],
      voteAverage: result['vote_average'] ?? 0.0,
      voteCount: result['vote_count'],
      genres: (result['genres'] as List)?.map((e) => Genre.parserFromJson(e))?.toList(),
      countries: (result['production_countries'] as List)?.map((e) => Country.parserFromJson(e))?.toList(),
      companies: (result['production_companies'] as List)?.map((e) => Company.parserFromJson(e))?.toList(),
      collection: Collection.parserFromJson(result['belongs_to_collection']),
      languages: (result['spoken_languages'] as List)?.map((e) => Language.parserFromJson(e))?.toList(),
    );
  }

  @override
  List<Object> get props => [
        adult,
        backdropPath,
        budget,
        homepage,
        id,
        imdbId,
        originalTitle,
        originalLanguage,
        overview,
        popularity,
        posterPath,
        releaseDate,
        revenue,
        runtime,
        status,
        tagline,
        title,
        video,
        voteCount,
        voteAverage,
        genres,
        countries,
        companies,
        collection,
        languages,
      ];
}
