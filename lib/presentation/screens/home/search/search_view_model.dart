part of 'search_imports.dart';

class SearchViewModel extends GetxController {
  SearchViewModel({required this.movieRepo});
  final MovieRepo movieRepo;
  final RxBool isLoading = false.obs;
  final RxList<Movie> searchedMovies = <Movie>[].obs;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusnode = FocusNode();

  ///News Search
  Timer? debounceTimer;

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  @override
  void dispose() {
    debounceTimer?.cancel();
    searchController.clear();
    searchController.removeListener(movieOnSearchChange);
    super.dispose();
  }

  Future<void> initialize() async {
    searchController.addListener(movieOnSearchChange);
    searchFocusnode.requestFocus();
  }

  Future<void> movieOnSearchChange() async {
    if (searchController.text.isNotEmpty) {
      debouncing(
        fn: () async {
          await searchMovie();
        },
      );
    } else {
      searchedMovies.clear();
      update();
    }
  }

  Future<void> searchMovie() async {
    isLoading(true);
    final MovieModel? movieModel = await movieRepo.getSearchedMovie(
        searchKey: searchController.text.trim());

    searchedMovies(movieModel?.result ?? []);

    debugPrint('Searched Movies: ${searchedMovies.length}');
    isLoading(false);
    update();
  }

  void debouncing({required Function() fn, int waitForMs = 800}) {
    debounceTimer?.cancel();
    debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }
}
