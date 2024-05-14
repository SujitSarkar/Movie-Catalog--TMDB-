import 'dart:convert';
import '../../../extensions/string_extension.dart';

MovieModel movieModelFromJson(String str) =>
    MovieModel.fromJson(json.decode(str));

class MovieModel {
  final int? totalPages;
  final int? totalResults;
  final int? page;
  final List<Movie>? result;

  MovieModel({
    this.totalPages,
    this.totalResults,
    this.page,
    this.result,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        page: json["page"],
        result: json["results"] == null
            ? []
            : List<Movie>.from(json["results"]!.map((x) => Movie.fromJson(x))),
      );
}

class Movie {
  final int? id;
  final String? overview;
  final String? posterPath;
  final String? title;
  final List<int>? genreIds;
  final DateTime? releaseDate;
  final double? voteAverage;

  Movie({
    this.id,
    this.overview,
    this.posterPath,
    this.title,
    this.genreIds,
    this.releaseDate,
    this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        title: json["title"] ?? json["name"] ?? 'Not found',
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        releaseDate: json["release_date"] != null
            ? '${json["release_date"]}'.toDate()
            : json["first_air_date"] != null
                ? '${json["first_air_date"]}'.toDate()
                : null,
        voteAverage: json["vote_average"]?.toDouble(),
      );
}
