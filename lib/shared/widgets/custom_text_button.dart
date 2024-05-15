part of 'widgets_imports.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.onTap,
      required this.child,
      this.width,
      this.height,
      this.borderRadius,
      this.splashColor});
  final Function() onTap;
  final Widget child;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final MaterialStateProperty<Color?>? splashColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                elevation: 0.0,
                minimumSize: Size(
                    width ?? MediaQuery.of(context).size.width, height ?? 44),
                shape: RoundedRectangleBorder(
                    borderRadius: borderRadius ??
                        const BorderRadius.all(Radius.circular(11))))
            .copyWith(
                overlayColor: splashColor ??
                    MaterialStateProperty.all(
                        AppColors.primaryColor.withOpacity(0.5))),
        onPressed: onTap,
        child: child);
  }
}
