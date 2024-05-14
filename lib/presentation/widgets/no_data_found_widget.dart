part of 'widgets_imports.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'No data found !',
      style: Theme.of(context).textTheme.bodyLarge,
    ));
  }
}
