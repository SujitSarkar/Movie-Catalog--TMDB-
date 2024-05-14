part of 'home_imports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find Moview, Tv Series,\nand more..',
            style: Theme.of(context).textTheme.headlineSmall,
          ).paddingSymmetric(horizontal: 16, vertical: 16),
          SearchField(
            onTap: () => pushTo(AppRouter.search),
            controller: TextEditingController(),
            hintText: 'Search Movies',
            prefixIcon: FeatherIcons.search,
            readOnly: true,
          ).paddingSymmetric(horizontal: 16),
          const SizedBox(height: 12),
          SizedBox(
            height: 32,
            child: TabBar(
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
            ),
          ).paddingOnly(bottom: 8),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: const [
              Popular(),
              TrendingTv(),
              TrendingMovie(),
              TopRated(),
              Upcoming()
            ],
          ))
        ],
      ),
    ));
  }
}
