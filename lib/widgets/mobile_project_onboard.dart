import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileProjectOnboard extends StatefulWidget {
  final Map<String, dynamic> project;

  MobileProjectOnboard({
    required this.project,
  });

  @override
  _ProjectOnboardState createState() => _ProjectOnboardState();
}

class _ProjectOnboardState extends State<MobileProjectOnboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final String title = project['name'] ?? 'No Title';
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final List<String> technologies =
        List<String>.from(project['concepts'] ?? []);
    final String startDate = project['startDate'] ?? 'No start date available';
    final String endDate = project['endDate'] ?? 'No end date available';
    final String projectLink = project['repo'] ?? 'No project link available';
    final bool status = project['status'] ?? false; // Default to false if null
    final List<String> images = List<String>.from(project['images'] ?? []);
    final List<String> description =
        List<String>.from(project['description'] ?? []);
    final String idea = project['idea'] ?? 'No idea available';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: width * 0.05),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.robotoSlab(
                color: const Color.fromARGB(247, 246, 152, 0),
                fontSize: width * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: width * 0.01),
            Expanded(
              child: Text(
                " - $idea",
                style: GoogleFonts.robotoSlab(
                  color: Colors.white,
                  fontSize: width * 0.02,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(width * 0.05),
          child: Column(children: [
            images.isNotEmpty
                ? CarouselSlider.builder(
                    itemCount: images.length,
                    options: CarouselOptions(
                      height: height * 0.45,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: width,
                        height: height * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 42, 41, 41),
                        ),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image loaded successfully
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Center(
                                child: Icon(Icons.error, color: Colors.red));
                          },
                        ),
                      );
                    },
                  )
                : AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: width,
                    height: height * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 42, 41, 41),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "No images available",
                      style: GoogleFonts.robotoSlab(
                        color: Colors.white60,
                        fontSize: width * 0.015,
                      ),
                    ),
                  ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                const Icon(Icons.description, color: Colors.white),
                SizedBox(width: width * 0.01),
                Text(
                  "Description",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            ListView.builder(
              shrinkWrap: true,
              itemCount: description.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: height * 0.02),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: const Color.fromRGBO(229, 101, 0, 1),
                        size: width * 0.015, // Adjusted dot size
                      ),
                      SizedBox(width: width * 0.01),
                      Expanded(
                        child: Text(
                          description[index],
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white60,
                            fontSize: width * 0.022, // Adjusted font size
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                const Icon(Icons.info, color: Colors.white),
                SizedBox(width: width * 0.01),
                Text(
                  "Status :",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: width * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: width * 0.01),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: width * 0.2,
                  height: width * 0.05,
                  decoration: BoxDecoration(
                    color: status
                        ? const Color.fromARGB(206, 0, 255, 0)
                        : const Color.fromARGB(255, 255, 0, 0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    status ? "Completed" : "In Progress",
                    style: GoogleFonts.robotoSlab(
                      color: Colors.white,
                      fontSize: width * 0.022,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                const Icon(Icons.memory_rounded, color: Colors.white),
                SizedBox(width: width * 0.01),
                Text(
                  "Technologies Used : ",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: width * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: width * 0.005),
                Expanded(
                  child: Text(
                    "[ ${technologies.join(', ')} ]",
                    style: GoogleFonts.robotoSlab(
                      color: Colors.white60,
                      fontSize: width * 0.02,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                const Icon(Icons.date_range, color: Colors.white),
                SizedBox(width: width * 0.01),
                Text(
                  "Start Date : ",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: width * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: width * 0.005),
                Text(
                  startDate,
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white60,
                    fontSize: width * 0.02,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                const Icon(Icons.data_object, color: Colors.white),
                SizedBox(width: width * 0.01),
                Text(
                  "End Date : ",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: width * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: width * 0.005),
                Text(
                  endDate,
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white60,
                    fontSize: width * 0.02,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                const Icon(Icons.link, color: Colors.white),
                SizedBox(width: width * 0.01),
                Text(
                  "Project Link :",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: width * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: width * 0.005),
                TextButton(
                  onPressed: () => launchUrl(Uri.parse(projectLink)),
                  child: Text(
                    projectLink,
                    style: GoogleFonts.robotoSlab(
                      color: Colors.blue,
                      fontSize: width * 0.02,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void launchUrl(Uri uri) async {
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
      log('Launched $uri');
    } else {
      log('Could not launch $uri');
    }
  }
}
