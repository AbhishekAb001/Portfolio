import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/view/mobile/about_screen.dart';
import 'package:portfolio/view/mobile/contact_screen.dart';
import 'package:portfolio/view/mobile/home_screen.dart';
import 'package:portfolio/view/mobile/project_screen.dart';

class MobileMainScreen extends StatefulWidget {
  const MobileMainScreen({super.key});

  @override
  State<MobileMainScreen> createState() => _MobileMainScreenState();
}

class _MobileMainScreenState extends State<MobileMainScreen> {
  late double width;
  late double height;
  bool isName = false;
  bool isRole = false;
  int selectedIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const AboutScreen(),
    const ProjectScreen(),
    const ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.black, // Change to your theme color
        activeColor: Colors.orange, // Color when item is selected
        style: TabStyle.react,
        items: [
          TabItem(
            icon: Icon(FontAwesomeIcons.home,
                size: width * 0.05, color: Colors.white60),
            title: "Home",
          ),
          TabItem(
            icon: Icon(FontAwesomeIcons.user,
                size: width * 0.05, color: Colors.white60),
            title: "About",
          ),
          TabItem(
            icon: Icon(FontAwesomeIcons.briefcase,
                size: width * 0.05, color: Colors.white60),
            title: "Projects",
          ),
          TabItem(
            icon: Icon(FontAwesomeIcons.envelope,
                size: width * 0.05, color: Colors.white60),
            title: "Contact",
          ),
        ],
        initialActiveIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
