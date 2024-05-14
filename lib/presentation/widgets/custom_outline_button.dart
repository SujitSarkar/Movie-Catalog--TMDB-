part of 'widgets_imports.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton(
      {super.key,
      required this.onTap,
      required this.child,
      this.backgroundColor,
      this.borderRadius,
      this.splashColor,
      this.borderColor,
      this.minimumSize,
      this.fixedSize,
      this.maximumSize});

  final Function() onTap;
  final Widget child;
  final Size? fixedSize;
  final Size? minimumSize;
  final Size? maximumSize;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final MaterialStateProperty<Color?>? splashColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                minimumSize:
                    minimumSize ?? Size(MediaQuery.of(context).size.width, 44),
                side: BorderSide(color: borderColor ?? AppColors.primaryColor),
                shape: RoundedRectangleBorder(
                    borderRadius: borderRadius ??
                        const BorderRadius.all(Radius.circular(11))))
            .copyWith(
                overlayColor: splashColor ??
                    MaterialStateProperty.all(
                        AppColors.primaryColor.withOpacity(0.3))),
        onPressed: onTap,
        child: child);
  }
}
