import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/static_data.dart';
import '../../../core/router/app_router.dart';
import '../../../core/router/router_imports.dart';
import '../../popular/view/popular.dart';
import '../../top_rated/view/top_rated.dart';
import '../../trending_movie/view/trending_movie.dart';
import '../../trending_tv/view/trending_tv.dart';
import '../../upcoming/view/upcoming.dart';
import 'widgets/search_field.dart';

class HomeWithSliver extends StatefulWidget {
  const HomeWithSliver({super.key});

  @override
  State<StatefulWidget> createState() => _HomeWithSliverState();
}

class _HomeWithSliverState extends State<HomeWithSliver>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: StaticData.movieCategory.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  title: SearchField(
                    onTap: () => pushTo(AppRouter.search),
                    controller: TextEditingController(),
                    hintText: 'Search Movies',
                    prefixIcon: FeatherIcons.search,
                    readOnly: true,
                  ),
                  floating: true,
                  pinned: true,
                  snap: true,
                  primary: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabAlignment: TabAlignment.start,
                    controller: tabController,
                    unselectedLabelColor: AppColors.textColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: AppColors.secondaryColor,
                    dividerColor: Colors.transparent,
                    indicatorColor: AppColors.secondaryColor,
                    isScrollable: true,
                    padding: EdgeInsets.zero,
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    onTap: (value) {
                      debugPrint(value.toString());
                    },
                    tabs: StaticData.movieCategory
                        .map((item) => Tab(text: item))
                        .toList(),
                  )),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: const [
              Popular(),
              TrendingTv(),
              TrendingMovie(),
              TopRated(),
              Upcoming()
            ],
          )),
    );
  }
}
