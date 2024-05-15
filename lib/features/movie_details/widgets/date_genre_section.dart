part of 'widget_imports.dart';

class MovieDetailsDateGenreSection extends StatelessWidget {
  const MovieDetailsDateGenreSection({super.key, required this.model});
  final MovieDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Release date',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              DateFormat('MMM dd, yyyy')
                  .format(model.releaseDate ?? DateTime.now()),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.hintColor, fontWeight: FontWeight.bold),
            ),
          ],
        )),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Genre',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (model.genres != null)
              Wrap(
                children: model.genres!
                    .map((e) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          margin: const EdgeInsets.only(right: 8, bottom: 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.hintColor, width: 0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Text(e.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: AppColors.hintColor,
                                      fontWeight: FontWeight.bold)),
                        ))
                    .toList(),
              )
          ],
        )),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
