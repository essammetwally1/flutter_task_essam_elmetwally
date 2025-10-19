import 'package:flutter/material.dart';
import 'package:flutter_task_essam_elmetwally/app_theme.dart';
import 'package:flutter_task_essam_elmetwally/components/navbar_icon.dart';
import 'package:flutter_task_essam_elmetwally/tabs/addads_tab.dart';
import 'package:flutter_task_essam_elmetwally/tabs/ads_tab.dart';
import 'package:flutter_task_essam_elmetwally/tabs/chat_tab.dart';
import 'package:flutter_task_essam_elmetwally/tabs/home_tab.dart';
import 'package:flutter_task_essam_elmetwally/tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 4;

  final List<Widget> _pages = const [
    ProfileTab(),
    AdsTab(),
    AddadsTab(),
    ChatTab(),
    HomeTab(),
  ];

  BottomNavigationBarItem buildItem({
    required int index,
    required String iconName,
    required String label,
  }) {
    final isActive = selectedIndex == index;
    return BottomNavigationBarItem(
      label: '',
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppTheme.blue : Colors.transparent,
              width: 1,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NavbarIcon(
              iconName: iconName,
              color: isActive ? AppTheme.blue : AppTheme.grey,
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 20,
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    color: isActive ? AppTheme.blue : AppTheme.darkgrey,
                    fontSize: isActive ? 12 : 10,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
                  ),
                  child: Text(label),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(child: _pages[selectedIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            backgroundColor: AppTheme.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (index) => setState(() => selectedIndex = index),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              buildItem(index: 0, iconName: 'profile', label: 'حسابى'),
              buildItem(index: 1, iconName: 'ads', label: 'أعلاناتى'),
              buildItem(index: 2, iconName: 'addads', label: 'أضف أعلان'),
              buildItem(index: 3, iconName: 'chat', label: 'محادثة'),
              buildItem(index: 4, iconName: 'main', label: 'الرئيسية'),
            ],
          ),
        ),
      ),
    );
  }
}
