part of 'widget_imports.dart';

class MovieDetailsTitleSection extends StatelessWidget {
  const MovieDetailsTitleSection({super.key, required this.model});
  final MovieDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title ?? "Not Found",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              FeatherIcons.star,
              color: AppColors.hintColor,
              size: 18,
            ),
            Text(
              '${model.voteAverage ?? "Not found"} (IMDB)',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.hintColor, fontWeight: FontWeight.bold),
            ).paddingSymmetric(horizontal: 6),
            const SizedBox(width: 16),
            if (model.runtime != null)
              const Icon(
                FeatherIcons.clock,
                color: AppColors.hintColor,
                size: 18,
              ),
            if (model.runtime != null)
              Text(
                '${model.runtime} minutes',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.hintColor, fontWeight: FontWeight.bold),
              ).paddingOnly(left: 6),
          ],
        )
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
