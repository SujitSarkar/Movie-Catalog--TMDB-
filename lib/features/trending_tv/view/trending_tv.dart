import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../shared/data/repositories/movie_repo.dart';
import '../../../core/utils/enums.dart';
import '../../../shared/widgets/widgets_imports.dart';
import '../../home/view/tiles/movie_grid_tile.dart';
import '../view_model/trending_tv_view_model.dart';

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
