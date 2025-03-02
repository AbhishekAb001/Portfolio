import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  late double width;
  late double height;
  String selected = "Skills";
  bool isHoverd = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    log("contact :${width * 0.02}");

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
          AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              vertical: width * 0.02 > 16 ? height * 0.13 : height * 0.09,
              horizontal: width * 0.1,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.3,
                  height: height * 0.65,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(156, 116, 113, 113),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/dev.png",
                    width: width * 0.4,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: width * 0.05),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Me",
                        style: GoogleFonts.roboto(
                          fontSize: (width * 0.02 > 16) ? width * 0.02 : 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        "Hi! I’m Abhishek Bhosale, a student at Vishwakarma University Pune studying Computer Science. I’m passionate about technology, problem-solving, and creating innovative solutions, and I’m currently focusing on coding and real-world project development. I’ve had the chance to work on projects like [mention specific school projects or personal work], and I’m always looking for ways to grow my skills and learn new techniques. While I’m still in school, I’m eager to take on internships or freelance opportunities that will help me gain experience in the industry. I’m excited about the future and can’t wait to see where my journey in technology takes me! Feel free to check out my portfolio, and don’t hesitate to reach out if you’d like to chat or collaborate!",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                          fontSize: (width * 0.02 > 20) ? width * 0.01 : 12,
                          color: Colors.white60,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          animatedRow("Skills"),
                          SizedBox(width: width * 0.02),
                          animatedRow("Experience"),
                          SizedBox(width: width * 0.02),
                          animatedRow("Education"),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      if (selected == "Skills")
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: skill(),
                        )
                      else if (selected == "Experience")
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: experienceWidget(),
                        )
                      else if (selected == "Education")
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: educationWidget(),
                        )
                      else
                        Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget skill() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "App Development",
          style: GoogleFonts.roboto(
            fontSize: (width * 0.02 > 16) ? width * 0.01 : 15,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          "Building mobile apps for Android and iOS with Flutter and Dart.",
          textAlign: TextAlign.start,
          style: GoogleFonts.roboto(
            fontSize: (width * 0.02 > 16) ? width * 0.01 : 10,
            color: Colors.white60,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.02),
        Text(
          "Java Development",
          style: GoogleFonts.roboto(
            fontSize: (width * 0.02 > 16) ? width * 0.01 : 15,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          "Developing applications using Java for both web and Android platforms.",
          textAlign: TextAlign.start,
          style: GoogleFonts.roboto(
            fontSize: (width * 0.02 > 16) ? width * 0.01 : 10,
            color: Colors.white60,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.02),
        Text(
          "Backed Development",
          style: GoogleFonts.roboto(
            fontSize: (width * 0.02 > 16) ? width * 0.01 : 15,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          "Creating server-side applications using Spring and Springboot.",
          textAlign: TextAlign.start,
          style: GoogleFonts.roboto(
            fontSize: (width * 0.02 > 16) ? width * 0.01 : 10,
            color: Colors.white60,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget experienceWidget() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dec 2024 - Continue",
              style: GoogleFonts.roboto(
                fontSize: (width * 0.02 > 16) ? width * 0.01 : 15,
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              "Flutter Intern at Incubator By Core2Web",
              style: GoogleFonts.roboto(
                fontSize: (width * 0.02 > 20) ? width * 0.01 : 12,
                color: Colors.white60,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget educationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "2025",
          style: GoogleFonts.roboto(
            fontSize: (width * 0.02 > 16) ? width * 0.01 : 15,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          "Bachelor of Technology in Computer Science from Vishwakarma University Pune",
          style: GoogleFonts.roboto(
            fontSize: (width * 0.02 > 20) ? width * 0.01 : 12,
            color: Colors.white60,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget animatedRow(String title) {
    isHoverd = selected == title;

    final textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: GoogleFonts.roboto(
          fontSize: (width * 0.02 > 16) ? width * 0.01 : 12,
          color:
              isHoverd ? const Color.fromRGBO(229, 101, 0, 1) : Colors.white30,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    double textWidth = textPainter.size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = title;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: (width * 0.02 > 16) ? width * 0.01 : 12,
                color: isHoverd
                    ? const Color.fromRGBO(229, 101, 0, 1)
                    : const Color.fromARGB(195, 255, 255, 255),
                fontWeight: FontWeight.w600,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: isHoverd ? textWidth : 0,
              height: 2,
              color: const Color.fromRGBO(229, 101, 0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
