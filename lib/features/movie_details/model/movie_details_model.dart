import 'dart:convert';
import '../../../shared/extensions/string_extension.dart';

MovieDetailsModel movieDetailsModelFromJson(String str) =>
    MovieDetailsModel.fromJson(json.decode(str));

class MovieDetailsModel {
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final int? runtime;
  final String? status;
  final String? tagline;
  final String? title;
  final double? voteAverage;
  final int? voteCount;

  MovieDetailsModel({
    this.genres,
    this.homepage,
    this.id,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailsModel(
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"] != null
            ? '${json["release_date"]}'.toDate()
            : '${json["first_air_date"]}'.toDate(),
        runtime: json["runtime"],
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"] ?? json['original_name'],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}

class Genre {
  final int? id;
  final String? name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );
}
