import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data_sources/remote/api_endpoint_url.dart';
import '../data_sources/remote/remote_imports.dart';
import '../models/movie_model.dart';

class MovieRepo extends ApiClient {
  Future<MovieModel?> getPopularMovie({required int page}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.popularMovie}$page');
      if (response.statusCode == 200) {
        return movieModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<MovieModel?> getTrendingTv({required int page}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.trendingTv}$page');
      if (response.statusCode == 200) {
        return movieModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<MovieModel?> getTrendingMovie({required int page}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.trendingMovie}$page');
      if (response.statusCode == 200) {
        return movieModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<MovieModel?> getTopRatedMovie({required int page}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.topRatedMovie}$page');
      if (response.statusCode == 200) {
        return movieModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<MovieModel?> getUpcomingMovie({required int page}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.upcomingMovie}$page');
      if (response.statusCode == 200) {
        return movieModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<MovieModel?> getSearchedMovie({required String searchKey}) async {
    try {
      final Response<dynamic> response =
          await getRequest(path: '${ApiEndpointUrl.searchMovie}$searchKey');
      if (response.statusCode == 200) {
        return movieModelFromJson(jsonEncode(response.data));
      }
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }
}
