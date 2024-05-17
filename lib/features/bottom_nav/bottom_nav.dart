import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../account/account_imports.dart';
import '../home/view/home_with_sliver.dart';

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

  List<Widget> pages = const [HomeWithSliver(), Account()];

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
