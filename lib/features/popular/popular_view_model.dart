part of 'popular_imports.dart';

class PopularViewModel extends GetxController {
  PopularViewModel({required this.movieRepo});
  final MovieRepo movieRepo;
  final RxBool isLoading = false.obs;
  final RxInt page = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxList<Movie> popularMovies = <Movie>[].obs;

  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    isLoading(true);
    await fetchPopularMovie();
    isLoading(false);
  }

  Future<void> fetchPopularMovie() async {
    if (page.value <= totalPages.value) {
      final MovieModel? movieModel =
          await movieRepo.getPopularMovie(page: page.value);
      if (movieModel != null) {
        popularMovies.addAll(movieModel.result ?? []);
        page.value++;
        totalPages.value = movieModel.totalPages!;
      }
      debugPrint('Popular Movie: ${popularMovies.length}');
      update();
    }
  }

  Future<void> onLoading() async {
    await fetchPopularMovie();
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    page.value = 1;
    popularMovies.clear();
    await fetchPopularMovie();
    refreshController.refreshCompleted();
  }
}
