import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/view/desktop/projects.dart';

class ProjectSection extends StatefulWidget {
  const ProjectSection({super.key});

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> {
  late double width;
  late double height;
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      color: const Color.fromRGBO(18, 18, 18, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.white60,
            thickness: 2,
            indent: width * 0.03,
            endIndent: width * 0.03,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.only(
                  left: width * 0.03,
                  right: width * 0.03,
                  top: height * 0.08,
                  bottom: height * 0.08,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    SizedBox(width: width * 0.03),
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
                    SizedBox(width: width * 0.02),
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
          ),
        ],
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
            builder: (context) => Projects(
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
            width: width * 0.25,
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
                            fontSize: width * 0.012,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          status,
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            fontSize: width * 0.012,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        if (isHovered && status == "Completed")
                          GestureDetector(
                            onTap: () {
                              log("View Projects ${subject}");
                            },
                            child: AnimatedTextKit(
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
                                    fontSize: width * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                              ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.03),
          Text(
            subject,
            style: GoogleFonts.robotoSlab(
              color: const Color.fromARGB(247, 246, 152, 0),
              fontSize: (width * 0.02 > 16) ? width * 0.015 : 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
