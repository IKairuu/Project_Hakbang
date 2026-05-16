import 'package:flutter/material.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/widgets/ai_gabay.dart';
import 'package:hakbang/widgets/discovery.dart';
import 'package:hakbang/widgets/home_widget.dart';
import 'package:hakbang/widgets/scholarship.dart';
import 'package:hakbang/widgets/review_center.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: navigationBarIndex,
      builder: (context, index, child) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: AppColors.bg,
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: AppColors.accentSurface,
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                backgroundColor: const Color(0xFF0f1013),
                elevation: 0,
                height: 72,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
                  (Set<MaterialState> states) =>
                      states.contains(MaterialState.selected)
                      ? const IconThemeData(color: AppColors.accent)
                      : const IconThemeData(color: Color(0xFF5a6068), size: 24),
                ),
                labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (Set<MaterialState> states) =>
                      states.contains(MaterialState.selected)
                      ? const TextStyle(
                          color: AppColors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        )
                      : const TextStyle(
                          color: Color(0xFF5a6068),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                ),
              ),
              child: NavigationBar(
                selectedIndex: index,
                onDestinationSelected: (value) {
                  setState(() {
                    navigationBarIndex.value = value;
                  });
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.explore_outlined),
                    selectedIcon: Icon(Icons.explore),
                    label: 'Discover',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.workspace_premium_outlined),
                    selectedIcon: Icon(Icons.workspace_premium),
                    label: 'Scholars',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.smart_toy_outlined),
                    selectedIcon: Icon(Icons.smart_toy),
                    label: 'Gabay',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.quiz_outlined),
                    selectedIcon: Icon(Icons.quiz),
                    label: 'Hubs',
                  ),
                ],
              ),
            ),
            body: IndexedStack(
              index: index,
              children: [
                Discovery(),
                Scholarship(),
                HomeWidget(),
                AiGabay(),
                ReviewCenter(),
              ],
            ),
          ),
        );
      },
    );
  }
}
