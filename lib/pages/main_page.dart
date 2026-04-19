import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hakbang/pages/profile_page.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/widgets/ai_gabay.dart';
import 'package:hakbang/widgets/discovery.dart';
import 'package:hakbang/widgets/home_widget.dart';
import 'package:hakbang/widgets/scholarship.dart';

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
        return Scaffold(
          backgroundColor: Color(0xFF0c0d10),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Color(0xFF272f1e),
              backgroundColor: Color(0xFF13141a),
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (Set<MaterialState> states) =>
                    states.contains(MaterialState.selected)
                    ? const TextStyle(color: Color(0xFFc8f032))
                    : const TextStyle(color: Color(0xFF4a5751)),
              ),
            ),
            child: NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (value) {
                setState(() {
                  navigationBarIndex.value = value;
                });
              },
              destinations: [
                NavigationDestination(
                  icon: SvgPicture.asset("assets/house.svg", height: 20),
                  label: "Home",
                ),
                NavigationDestination(
                  icon: SvgPicture.asset("assets/map.svg", height: 20),
                  label: "Discover",
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    "assets/graduation-hat.svg",
                    height: 20,
                  ),
                  label: "Scholars",
                ),
                NavigationDestination(
                  icon: SvgPicture.asset("assets/robot.svg", height: 20),
                  label: "Gabay",
                ),
                NavigationDestination(
                  icon: SvgPicture.asset("assets/user.svg", height: 20),
                  label: "Profile",
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              IndexedStack(
                index: index,
                children: [HomeWidget(), Discovery(), Scholarship(), AiGabay(), ProfilePage()],
              ),
            ],
          ),
        );
      },
    );
  }
}
