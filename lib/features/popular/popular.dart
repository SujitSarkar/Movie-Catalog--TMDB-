part of 'popular_imports.dart';

class Popular extends StatelessWidget {
  const Popular({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularViewModel>(
        init: PopularViewModel(movieRepo: MovieRepo()),
        autoRemove: false,
        builder: (populatViewModel) => populatViewModel.isLoading.value
            ? const LoadingWidget()
            : PaginationWidget(
                onRefresh: populatViewModel.onRefresh,
                onLoading: populatViewModel.onLoading,
                refreshController: populatViewModel.refreshController,
                child: MasonryGridView.builder(
                  addAutomaticKeepAlives: false,
                  itemCount: populatViewModel.popularMovies.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) => MovieGridTile(
                    movie: populatViewModel.popularMovies[index],
                    movieType: MovieType.movie,
                  ),
                ),
              ));
  }
}
