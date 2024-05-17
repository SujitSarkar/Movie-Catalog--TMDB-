import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tmdb_movie/core/router/router_imports.dart';
import '../../../shared/data/repositories/movie_repo.dart';
import '../../../core/utils/enums.dart';
import '../../../shared/widgets/widgets_imports.dart';
import '../../home/view/tiles/movie_grid_tile.dart';
import '../../home/view/widgets/search_field.dart';
import '../view_model/search_view_model.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
        init: SearchViewModel(movieRepo: MovieRepo()),
        builder: (searchViewModel) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: SearchField(
                controller: searchViewModel.searchController,
                focusNode: searchViewModel.searchFocusnode,
                hintText: 'Search Movies',
              ),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(right: 16)),
                    onPressed: () => popScreen(),
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ))
              ],
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
