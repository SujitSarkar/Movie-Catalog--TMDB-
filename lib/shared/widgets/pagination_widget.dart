part of 'widgets_imports.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    super.key,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    required this.child,
  });
  final RefreshController refreshController;
  final Function() onRefresh;
  final Function() onLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(waterDropColor: AppColors.secondaryColor),
      footer: CustomFooter(
        builder: (context, mode) {
          final Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("Pull up load");
          } else if (mode == LoadStatus.loading) {
            body = const LoadingWidget();
          } else if (mode == LoadStatus.failed) {
            body = const Text("Load failed! Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("Release to load more");
          } else {
            body = const Text("No more data");
          }
          return SizedBox(height: 45.0, child: Center(child: body));
        },
      ),
      child: child,
    );
  }
}
