part of 'upcoming_imports.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpcomingViewModel>(
        init: UpcomingViewModel(movieRepo: MovieRepo()),
        autoRemove: false,
        builder: (upcomingViewModel) => upcomingViewModel.isLoading.value
            ? const LoadingWidget()
            : PaginationWidget(
                onRefresh: upcomingViewModel.onRefresh,
                onLoading: upcomingViewModel.onLoading,
                refreshController: upcomingViewModel.refreshController,
                child: MasonryGridView.builder(
                  addAutomaticKeepAlives: false,
                  itemCount: upcomingViewModel.upcomingMovies.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) => MovieGridTile(
                    movie: upcomingViewModel.upcomingMovies[index],
                    movieType: MovieType.movie,
                  ),
                )));
  }
}
