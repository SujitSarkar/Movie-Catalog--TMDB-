part of 'bottom_nav_imports.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int visit = 0;
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(FeatherIcons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(FeatherIcons.user), label: 'Account'),
  ];

  List<Widget> pages = const [Home(), Account()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: visit,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: visit,
        onTap: (value) => setState(() => visit = value),
        backgroundColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textColor,
        selectedItemColor: AppColors.secondaryColor,
      ),
    );
  }
}
