part of 'movie_details_imports.dart';

class MovieDetailsViewModel extends GetxController {
  MovieDetailsViewModel({required this.movieDetailsRepo});
  final MovieDetailsRepo movieDetailsRepo;
  final RxBool detailsLoading = true.obs;
  final RxBool similarLoading = true.obs;
  final RxList<Movie> similarMoviesOrTvs = <Movie>[].obs;
  final Rxn<MovieDetailsModel> movieDetails = Rxn<MovieDetailsModel>();

  void clearAll() {
    similarMoviesOrTvs([]);
    movieDetails.value = MovieDetailsModel();
    similarLoading(true);
    detailsLoading(true);
  }

  Future<void> fetchMovieDetails(
      {required int id, required MovieType movieType}) async {
    final MovieDetailsModel? details = movieType == MovieType.movie
        ? await movieDetailsRepo.getMovieDetails(id: id)
        : await movieDetailsRepo.getTvDetails(id: id);
    if (details != null) {
      movieDetails(details);
    }
    debugPrint('Details: ${movieDetails.value?.title}');
    detailsLoading(false);
  }

  Future<void> fetchSimilarMoviesOrTvs(
      {required int id, required MovieType movieType}) async {
    final MovieModel? movieModel = movieType == MovieType.movie
        ? await movieDetailsRepo.getRelatedMovies(id: id)
        : await movieDetailsRepo.getRelatedTvs(id: id);
    if (movieModel != null) {
      similarMoviesOrTvs(movieModel.result ?? []);
    }
    debugPrint('Similar Movie: ${similarMoviesOrTvs.length}');
    similarLoading(false);
  }
}
