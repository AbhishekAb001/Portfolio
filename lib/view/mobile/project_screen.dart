import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/view/mobile/mobile_project.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectScreen> {
  late double width;
  late double height;
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
      body: SingleChildScrollView(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() {
                    hoveredIndex = 0;
                  });
                },
                onExit: (_) {
                  setState(() {
                    hoveredIndex = null;
                  });
                },
                child: projectCard(
                  'Java',
                  'assets/java.jpg',
                  "Completed",
                  isHovered: hoveredIndex == 0,
                ),
              ),
              const SizedBox(width: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() {
                    hoveredIndex = 1;
                  });
                },
                onExit: (_) {
                  setState(() {
                    hoveredIndex = null;
                  });
                },
                child: projectCard(
                  'Flutter',
                  'assets/flutter.png',
                  "Completed",
                  isHovered: hoveredIndex == 1,
                ),
              ),
              const SizedBox(width: 20),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() {
                    hoveredIndex = 2;
                  });
                },
                onExit: (_) {
                  setState(() {
                    hoveredIndex = null;
                  });
                },
                child: projectCard(
                  'Spring Boot',
                  'assets/springboot.png',
                  "Learning",
                  isHovered: hoveredIndex == 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget projectCard(String subject, String image, String status,
      {bool isHovered = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MobileProject(
              subject: subject,
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(0, isHovered ? -15 : 0, 0),
            padding: EdgeInsets.all(width * 0.01),
            margin: EdgeInsets.only(bottom: height * 0.02),
            height: height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.25,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Status: ",
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white70,
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          status,
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        if (isHovered && status == "Completed")
                          AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                "View Projects",
                                colors: const [
                                  Color.fromARGB(255, 198, 144, 29),
                                  Color.fromARGB(243, 255, 157, 1),
                                  Color.fromARGB(255, 126, 34, 28),
                                  Color.fromARGB(255, 253, 39, 1),
                                ],
                                textStyle: GoogleFonts.robotoSlab(
                                  color: Colors.white,
                                  fontSize: width * 0.026,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
