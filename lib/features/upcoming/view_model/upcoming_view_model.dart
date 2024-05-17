import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_new/pull_to_refresh.dart';
import '../../../shared/data/models/movie_model.dart';
import '../../../shared/data/repositories/movie_repo.dart';

class UpcomingViewModel extends GetxController {
  UpcomingViewModel({required this.movieRepo});
  final MovieRepo movieRepo;
  final RxBool isLoading = false.obs;
  final RxInt page = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxList<Movie> upcomingMovies = <Movie>[].obs;
  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    isLoading(true);
    await fetchUpcomingMovies();
    isLoading(false);
  }

  Future<void> fetchUpcomingMovies() async {
    if (page.value <= totalPages.value) {
      final MovieModel? movieModel =
          await movieRepo.getUpcomingMovie(page: page.value);
      if (movieModel != null) {
        upcomingMovies.addAll(movieModel.result ?? []);
        page.value++;
        totalPages.value = movieModel.totalPages!;
      }
      debugPrint('Upcoming Movies: ${upcomingMovies.length}');
      update();
    }
  }

  Future<void> onLoading() async {
    await fetchUpcomingMovies();
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    page.value = 1;
    upcomingMovies.clear();
    await fetchUpcomingMovies();
    refreshController.refreshCompleted();
  }
}
