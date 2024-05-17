import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/router/app_router.dart';
import '../../../core/router/router_imports.dart';
import '../../../shared/data/data_sources/remote/api_constant.dart';
import '../../../shared/data/repositories/movie_details_repo.dart';
import '../../../shared/widgets/widgets_imports.dart';
import '../../../core/utils/enums.dart';
import '../../play_movie/view/play_movie.dart';
import '../view_model/movie_details_view_model.dart';
import 'widgets/widget_imports.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.id, required this.movieType});
  final int id;
  final MovieType movieType;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late MovieDetailsViewModel movieDetailsViewModel;
  @override
  void initState() {
    movieDetailsViewModel =
        Get.put(MovieDetailsViewModel(movieDetailsRepo: MovieDetailsRepo()));
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      await movieDetailsViewModel.fetchMovieDetails(
          id: widget.id, movieType: widget.movieType);
      movieDetailsViewModel.fetchSimilarMoviesOrTvs(
          id: widget.id, movieType: widget.movieType);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      movieDetailsViewModel.clearAll();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.5),
        child: IconButton(
            onPressed: () => popScreen(),
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Obx(() => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Movie or Tv show Details
                movieDetailsViewModel.detailsLoading.value
                    ? const GridPlaceholderWidget(height: 300)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CachedNetworkImage(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * .55,
                                imageUrl:
                                    '${ApiConstant.imageUrl}${movieDetailsViewModel.movieDetails.value?.posterPath ?? ''}',
                                errorWidget: (context, url, error) =>
                                    const GridPlaceholderWidget(),
                                placeholder: (context, url) =>
                                    GridPlaceholderWidget(
                                  height:
                                      MediaQuery.of(context).size.height * .55,
                                ),
                                fit: BoxFit.cover,
                              ),
                              PosterMaskWidget(
                                onTap: () {
                                  pushTo(AppRouter.playMovie,
                                      arguments: PlayMovie(
                                          url: movieDetailsViewModel
                                                  .movieDetails
                                                  .value
                                                  ?.homepage ??
                                              ''));
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          //Title
                          MovieDetailsTitleSection(
                              model: movieDetailsViewModel.movieDetails.value!),
                          const Divider(
                                  color: AppColors.cardColor,
                                  thickness: 1.5,
                                  height: 28)
                              .paddingSymmetric(horizontal: 16),
                          //Date & Genre
                          MovieDetailsDateGenreSection(
                              model: movieDetailsViewModel.movieDetails.value!),

                          const Divider(
                                  color: AppColors.cardColor,
                                  thickness: 1.5,
                                  height: 28)
                              .paddingSymmetric(horizontal: 16),

                          //Prolog
                          Text(
                            'Prolog',
                            style: Theme.of(context).textTheme.titleLarge,
                          ).paddingSymmetric(horizontal: 16),
                          const SizedBox(height: 8),
                          Text(
                            movieDetailsViewModel
                                    .movieDetails.value?.overview ??
                                'Not found',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.hintColor),
                          ).paddingSymmetric(horizontal: 16)
                        ],
                      ),
                const SizedBox(height: 16),

                //Related Movies
                Text(
                  'Related ${widget.movieType == MovieType.movie ? 'Movies' : 'Tv Shows'}',
                  style: Theme.of(context).textTheme.titleLarge,
                ).paddingSymmetric(horizontal: 16),
                const SizedBox(height: 8),
                SizedBox(
                    height: 200,
                    child: movieDetailsViewModel.similarLoading.value
                        ? const LoadingWidget()
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                movieDetailsViewModel.similarMoviesOrTvs.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) =>
                                SimilarMovieGridTile(
                                    movie: movieDetailsViewModel
                                        .similarMoviesOrTvs[index],
                                    movieType: widget.movieType),
                          )),
              ],
            ),
          )),
    );
  }
}
