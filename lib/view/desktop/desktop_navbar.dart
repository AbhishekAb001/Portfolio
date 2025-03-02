import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/view/model/navbarstate_model.dart';
import 'package:provider/provider.dart';

class DesktopNavbar extends StatefulWidget {
  const DesktopNavbar({super.key});

  @override
  State<DesktopNavbar> createState() => _DesktopNavbarState();
}

class _DesktopNavbarState extends State<DesktopNavbar> {
  late double width;
  late double height;
  String isHovered = "";
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    List<String> title = ["Portfolio", "About Me", "Projects", "Contact Me"];
    return AppBar(
      scrolledUnderElevation: 0,
      toolbarHeight: height * 0.1,
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      title: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            SizedBox(
              width: width * 0.01,
            ),
            Text(
              title[sectionIndex],
              style: GoogleFonts.roboto(
                fontSize: (width * 0.02 > 16) ? width * 0.02 : 20,
                color: const Color.fromRGBO(229, 101, 0, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            animatedNavBarComponent("Home", onTap: () {
              Provider.of<NavBarStateModel>(context, listen: false)
                  .updateIndex(index: 0);
              setState(() {
                sectionIndex = 0;
              });
            }),
            SizedBox(width: width * 0.015),
            animatedNavBarComponent("About", onTap: () {
              Provider.of<NavBarStateModel>(context, listen: false)
                  .updateIndex(index: 1);
              setState(() {
                sectionIndex = 1;
              });
            }),
            SizedBox(width: width * 0.015),
            animatedNavBarComponent("Projects", onTap: () {
              Provider.of<NavBarStateModel>(context, listen: false)
                  .updateIndex(index: 2);
              setState(() {
                sectionIndex = 2;
              });
            }),
            SizedBox(width: width * 0.015),
            animatedNavBarComponent("Contact", onTap: () {
              Provider.of<NavBarStateModel>(context, listen: false)
                  .updateIndex(index: 4);
              setState(() {
                sectionIndex = 3;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget animatedNavBarComponent(String title, {Function()? onTap}) {
    bool isSelected = isHovered == title;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        isHovered = title;
      }),
      onExit: (event) => setState(() {
        isHovered = "";
      }),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            vertical: height * 0.015,
            horizontal: width * 0.018,
          ),
          alignment: Alignment.center,
          decoration: (isSelected)
              ? BoxDecoration(
                  color: const Color.fromARGB(255, 208, 15, 15),
                  borderRadius: BorderRadius.circular(10),
                )
              : const BoxDecoration(),
          child: Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: (width * 0.012 > 16) ? width * 0.012 : 16,
              color: (isSelected) ? Colors.black : Colors.white60,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
