import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../features/movie_details/movie_details_model.dart';
import '../data_sources/remote/api_endpoint_url.dart';
import '../data_sources/remote/remote_imports.dart';
import '../models/movie_model.dart';

class MovieDetailsRepo extends ApiClient {
  Future<MovieModel?> getRelatedMovies({required int id}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.movie}$id/similar');
      if (response.statusCode == 200) {
        return movieModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<MovieModel?> getRelatedTvs({required int id}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.tv}$id/similar');
      if (response.statusCode == 200) {
        return movieModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<MovieDetailsModel?> getMovieDetails({required int id}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.movie}$id');
      if (response.statusCode == 200) {
        return movieDetailsModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<MovieDetailsModel?> getTvDetails({required int id}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.tv}$id');
      if (response.statusCode == 200) {
        return movieDetailsModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }
}
