part of 'trending_movie_imports.dart';

class TrendingMovieViewModel extends GetxController {
  TrendingMovieViewModel({required this.movieRepo});
  final MovieRepo movieRepo;
  final RxBool isLoading = false.obs;
  final RxInt page = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxList<Movie> trendingMovies = <Movie>[].obs;
  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    isLoading(true);
    await fetchTrendingMovies();
    isLoading(false);
  }

  Future<void> fetchTrendingMovies() async {
    if (page.value <= totalPages.value) {
      final MovieModel? movieModel =
          await movieRepo.getTrendingMovie(page: page.value);
      if (movieModel != null) {
        trendingMovies.addAll(movieModel.result ?? []);
        page.value++;
        totalPages.value = movieModel.totalPages!;
      }
      debugPrint('Trending Moviee: ${trendingMovies.length}');
      update();
    }
  }

  Future<void> onLoading() async {
    await fetchTrendingMovies();
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    page.value = 1;
    trendingMovies.clear();
    await fetchTrendingMovies();
    refreshController.refreshCompleted();
  }
}
