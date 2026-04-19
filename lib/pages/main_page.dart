import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        return Scaffold(
          backgroundColor: Color(0xFF0c0d10),
          bottomNavigationBar: CircleNavBar(
            height: 60,
            circleWidth: 40,
            shadowColor: AppColors.accent,
            inactiveLevelsStyle: TextStyle(color: Colors.white, fontSize: 12),
            circleColor: AppColors.accent,
            onTap: (index) {
              setState(() {
                navigationBarIndex.value = index;
              });
            },
            activeIndex: index,
            levels: ["Discovery", "Scholarship", "Home", "Gabay", "Hubs"],
            activeIcons: [
              SvgPicture.asset("assets/university.svg", height: 20),
              SvgPicture.asset("assets/graduation-hat.svg", height: 20),
              SvgPicture.asset("assets/house.svg", height: 20),
              SvgPicture.asset("assets/robot.svg", height: 20),
              SvgPicture.asset("assets/robot.svg", height: 20),
            ],
            inactiveIcons: [
              SvgPicture.asset("assets/university.svg", height: 30),
              SvgPicture.asset("assets/graduation-hat.svg", height: 30),
              SvgPicture.asset("assets/house.svg", height: 30),
              SvgPicture.asset("assets/robot.svg", height: 30),
              SvgPicture.asset("assets/robot.svg", height: 30),
            ],
            color: AppColors.surface2,
          ),
          body: Stack(
            children: [
              IndexedStack(
                index: index,
                children: [
                  Discovery(),
                  Scholarship(),
                  HomeWidget(),
                  AiGabay(),
                  ReviewCenter(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
