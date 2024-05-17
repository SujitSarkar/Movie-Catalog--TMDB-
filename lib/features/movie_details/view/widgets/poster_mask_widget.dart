part of 'widget_imports.dart';

class PosterMaskWidget extends StatelessWidget {
  const PosterMaskWidget({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * .55,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, AppColors.primaryColor.withOpacity(0.7)],
        )),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryColor.withOpacity(0.7),
          child: Icon(
            FeatherIcons.play,
            color: AppColors.secondaryColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
