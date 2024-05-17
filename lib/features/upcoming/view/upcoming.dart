import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../shared/data/repositories/movie_repo.dart';
import '../../../core/utils/enums.dart';
import '../../../shared/widgets/widgets_imports.dart';
import '../../home/view/tiles/movie_grid_tile.dart';
import '../view_model/upcoming_view_model.dart';

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
