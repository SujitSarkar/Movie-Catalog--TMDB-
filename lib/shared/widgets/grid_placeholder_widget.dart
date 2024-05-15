part of 'widgets_imports.dart';

class GridPlaceholderWidget extends StatelessWidget {
  const GridPlaceholderWidget({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: height ?? MediaQuery.of(context).size.width * .3,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: AppColors.cardColor,
          ),
          child: Icon(
            FeatherIcons.image,
            color: Colors.white38,
            size: MediaQuery.of(context).size.width * .3,
          ),
        ));
  }
}
