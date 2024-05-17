import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../shared/data/repositories/movie_repo.dart';
import '../../../core/utils/enums.dart';
import '../../../shared/widgets/widgets_imports.dart';
import '../../home/view/tiles/movie_grid_tile.dart';
import '../view_model/trending_movie_view_model.dart';

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
