part of 'trending_tv_imports.dart';

class TrendingTv extends StatelessWidget {
  const TrendingTv({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrendingTvViewModel>(
        init: TrendingTvViewModel(movieRepo: MovieRepo()),
        autoRemove: false,
        builder: (trendingTvViewModel) => trendingTvViewModel.isLoading.value
            ? const LoadingWidget()
            : PaginationWidget(
                onRefresh: trendingTvViewModel.onRefresh,
                onLoading: trendingTvViewModel.onLoading,
                refreshController: trendingTvViewModel.refreshController,
                child: MasonryGridView.builder(
                  addAutomaticKeepAlives: false,
                  itemCount: trendingTvViewModel.trendingTvs.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) => MovieGridTile(
                    movie: trendingTvViewModel.trendingTvs[index],
                    movieType: MovieType.tv,
                  ),
                )));
  }
}
