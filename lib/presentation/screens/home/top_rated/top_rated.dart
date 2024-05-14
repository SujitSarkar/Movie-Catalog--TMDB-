part of 'top_rated_imports.dart';

class TopRated extends StatelessWidget {
  const TopRated({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopRatedViewModel>(
        init: TopRatedViewModel(movieRepo: MovieRepo()),
        autoRemove: false,
        builder: (topRatedViewModel) => topRatedViewModel.isLoading.value
            ? const LoadingWidget()
            : PaginationWidget(
                onRefresh: topRatedViewModel.onRefresh,
                onLoading: topRatedViewModel.onLoading,
                refreshController: topRatedViewModel.refreshController,
                child: MasonryGridView.builder(
                  addAutomaticKeepAlives: false,
                  itemCount: topRatedViewModel.topRatedMovies.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) => MovieGridTile(
                    movie: topRatedViewModel.topRatedMovies[index],
                    movieType: MovieType.tv,
                  ),
                )));
  }
}
