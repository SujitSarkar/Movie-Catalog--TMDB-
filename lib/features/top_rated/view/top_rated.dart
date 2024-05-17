import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../shared/data/repositories/movie_repo.dart';
import '../../../core/utils/enums.dart';
import '../../../shared/widgets/widgets_imports.dart';
import '../../home/view/tiles/movie_grid_tile.dart';
import '../view_model/top_rated_view_model.dart';

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
                    movieType: MovieType.movie,
                  ),
                )));
  }
}
