import 'package:flutter/material.dart';
import 'package:portfolio/view/desktop/about_section.dart';
import 'package:portfolio/view/desktop/contact_section.dart';
import 'package:portfolio/view/desktop/home_section.dart';
import 'package:portfolio/view/desktop/project_section.dart';
import 'package:portfolio/view/model/navbarstate_model.dart';
import 'package:provider/provider.dart';

class DesktopMainScreen extends StatefulWidget {
  const DesktopMainScreen({super.key});

  @override
  State<DesktopMainScreen> createState() => _DesktopMainScreenState();
}

class _DesktopMainScreenState extends State<DesktopMainScreen> {
  final ScrollController _scrollController = ScrollController();

  void scrollToSection(int index) {
    if (_scrollController.hasClients) {
      double offset = MediaQuery.of(context).size.height * index;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentIndex =
          Provider.of<NavBarStateModel>(context, listen: false).currentIndex;
      scrollToSection(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarStateModel>(
      builder: (context, navBarState, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToSection(navBarState.currentIndex);
        });

        return Scaffold(
          backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
          body: ListView(
            controller: _scrollController,
            children: const [
              HomeSection(),
              AboutSection(),
              ProjectSection(),
              ContactSection(),
            ],
          ),
        );
      },
    );
  }
}
