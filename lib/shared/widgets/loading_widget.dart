part of 'widgets_imports.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 28,
        width: 28,
        child: kIsWeb || Platform.isAndroid
            ? CircularProgressIndicator(
                color: color ?? AppColors.secondaryColor,
              )
            : Platform.isIOS
                ? CupertinoActivityIndicator(
                    color: color ?? AppColors.secondaryColor)
                : CircularProgressIndicator(
                    color: color ?? AppColors.secondaryColor,
                  ),
      ),
    );
  }
}
