import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileNavbar extends StatefulWidget {
  const MobileNavbar({super.key});

  @override
  State<MobileNavbar> createState() => _MobileNavbarState();
}

class _MobileNavbarState extends State<MobileNavbar> {
  late double width;
  late double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Center(
      child: AppBar(
        backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
        title: Text(
          "Portfolio",
          style: GoogleFonts.roboto(
            fontSize: (width * 0.02 > 16) ? width * 0.02 : 20,
            color: const Color.fromRGBO(229, 101, 0, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
