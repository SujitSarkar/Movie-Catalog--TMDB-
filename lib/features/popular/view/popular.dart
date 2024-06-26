import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../shared/data/repositories/movie_repo.dart';
import '../../../core/utils/enums.dart';
import '../../../shared/widgets/widgets_imports.dart';
import '../../home/view/tiles/movie_grid_tile.dart';
import '../view_model/popular_view_model.dart';

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
