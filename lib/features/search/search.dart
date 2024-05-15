part of 'search_imports.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
        init: SearchViewModel(movieRepo: MovieRepo()),
        builder: (searchViewModel) {
          return Scaffold(
            appBar: AppBar(
              title: SearchField(
                controller: searchViewModel.searchController,
                focusNode: searchViewModel.searchFocusnode,
                hintText: 'Search Movies',
              ).paddingOnly(right: 16),
              titleSpacing: 0.0,
            ),
            body: searchViewModel.isLoading.value
                ? const LoadingWidget()
                : MasonryGridView.builder(
                    addAutomaticKeepAlives: false,
                    itemCount: searchViewModel.searchedMovies.length,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => MovieGridTile(
                      movie: searchViewModel.searchedMovies[index],
                      movieType: MovieType.movie,
                    ),
                  ),
          );
        });
  }
}
