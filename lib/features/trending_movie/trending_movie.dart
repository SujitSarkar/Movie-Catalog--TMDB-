part of 'trending_movie_imports.dart';

class TrendingMovie extends StatelessWidget {
  const TrendingMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrendingMovieViewModel>(
        init: TrendingMovieViewModel(movieRepo: MovieRepo()),
        autoRemove: false,
        builder: (trendingMovieViewModel) =>
            trendingMovieViewModel.isLoading.value
                ? const LoadingWidget()
                : PaginationWidget(
                    onRefresh: trendingMovieViewModel.onRefresh,
                    onLoading: trendingMovieViewModel.onLoading,
                    refreshController: trendingMovieViewModel.refreshController,
                    child: MasonryGridView.builder(
                      addAutomaticKeepAlives: false,
                      itemCount: trendingMovieViewModel.trendingMovies.length,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) => MovieGridTile(
                        movie: trendingMovieViewModel.trendingMovies[index],
                        movieType: MovieType.movie,
                      ),
                    )));
  }
}
