part of 'trending_tv_imports.dart';

class TrendingTvViewModel extends GetxController {
  TrendingTvViewModel({required this.movieRepo});
  final MovieRepo movieRepo;
  final RxBool isLoading = false.obs;
  final RxInt page = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxList<Movie> trendingTvs = <Movie>[].obs;
  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    isLoading(true);
    await fetchTrendingTv();
    isLoading(false);
  }

  Future<void> fetchTrendingTv() async {
    if (page.value <= totalPages.value) {
      final MovieModel? movieModel =
          await movieRepo.getTrendingTv(page: page.value);
      if (movieModel != null) {
        trendingTvs.addAll(movieModel.result ?? []);
        page.value++;
        totalPages.value = movieModel.totalPages!;
      }
      debugPrint('Trending Tvs: ${trendingTvs.length}');
      update();
    }
  }

  Future<void> onLoading() async {
    await fetchTrendingTv();
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    page.value = 1;
    trendingTvs.clear();
    await fetchTrendingTv();
    refreshController.refreshCompleted();
  }
}
