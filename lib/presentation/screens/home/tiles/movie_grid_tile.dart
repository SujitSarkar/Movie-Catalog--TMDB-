part of '../widgets/widget_imports.dart';

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
