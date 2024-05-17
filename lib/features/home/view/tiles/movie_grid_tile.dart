import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/router/router_imports.dart';
import '../../../../shared/data/data_sources/remote/api_constant.dart';
import '../../../../shared/data/models/movie_model.dart';
import '../../../../shared/widgets/widgets_imports.dart';
import '../../../../core/utils/enums.dart';
import '../../../movie_details/view/movie_details.dart';

class MovieGridTile extends StatelessWidget {
  const MovieGridTile(
      {super.key, required this.movie, required this.movieType});
  final Movie movie;
  final MovieType movieType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Future.delayed(const Duration(milliseconds: 200)).then((value) {
          pushTo(AppRouter.movieDetails,
              arguments: MovieDetails(id: movie.id!, movieType: movieType));
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(7)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              child: CachedNetworkImage(
                imageUrl: '${ApiConstant.imageUrl}${movie.posterPath}',
                errorWidget: (context, url, error) =>
                    const GridPlaceholderWidget(),
                placeholder: (context, url) => const GridPlaceholderWidget(),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.title!,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
