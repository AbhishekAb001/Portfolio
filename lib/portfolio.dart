import 'package:flutter/material.dart';
import 'package:portfolio/view/desktop/desktop_main_screen.dart';
import 'package:portfolio/view/mobile/mobile_main_screen.dart';
import 'package:portfolio/view/mobile/mobile_navbar.dart';

import 'view/desktop/desktop_navbar.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize:
                Size(constraints.maxWidth, constraints.maxHeight * 0.1),
            child: (constraints.maxWidth > 600)
                ? const DesktopNavbar()
                : const MobileNavbar(),
          ),
          body: (constraints.maxWidth > 600)
              ? const DesktopMainScreen()
              : const MobileMainScreen(),
        );
      },
    );
  }
}
