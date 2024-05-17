import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_new/pull_to_refresh.dart';
import '../../../shared/data/models/movie_model.dart';
import '../../../shared/data/repositories/movie_repo.dart';

class TopRatedViewModel extends GetxController {
  TopRatedViewModel({required this.movieRepo});
  final MovieRepo movieRepo;
  final RxBool isLoading = false.obs;
  final RxInt page = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxList<Movie> topRatedMovies = <Movie>[].obs;
  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    isLoading(true);
    await fetchTopRatedMovies();
    isLoading(false);
  }

  Future<void> fetchTopRatedMovies() async {
    if (page.value <= totalPages.value) {
      final MovieModel? movieModel =
          await movieRepo.getTopRatedMovie(page: page.value);
      if (movieModel != null) {
        topRatedMovies.addAll(movieModel.result ?? []);
        page.value++;
        totalPages.value = movieModel.totalPages!;
      }
      debugPrint('Top Rated Movies: ${topRatedMovies.length}');
      update();
    }
  }

  Future<void> onLoading() async {
    await fetchTopRatedMovies();
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    page.value = 1;
    topRatedMovies.clear();
    await fetchTopRatedMovies();
    refreshController.refreshCompleted();
  }
}
