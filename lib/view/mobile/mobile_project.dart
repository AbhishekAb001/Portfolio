import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio/service/firebase_firestoreservice.dart';
import 'package:portfolio/widgets/mobile_project_onboard.dart';
import 'package:portfolio/widgets/project_onboard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MobileProject extends StatefulWidget {
  final String subject;
  const MobileProject({super.key, required this.subject});

  @override
  State<MobileProject> createState() => _ProjectsState();
}

class _ProjectsState extends State<MobileProject> {
  bool isLoading = false;
  double width = 0;
  double height = 0;
  List<Map<String, dynamic>> projects = [];
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    setState(() {
      isLoading = true;
    });
    getProjects();
  }

  void getProjects() async {
    await FirebaseFirestoreservice()
        .getProjectBySubject(widget.subject)
        .then((value) {
      setState(() {
        projects = value;
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: const Color.fromARGB(255, 243, 33, 33),
                size: 50,
              ),
            )
          : projects.isEmpty
              ? const Center(
                  child: Text(
                    "No projects available",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: projects.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        return MobileProjectOnboard(
                          project: projects[index],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: projects.length,
                        effect: const WormEffect(
                          dotColor: Color.fromARGB(153, 255, 255, 255),
                          activeDotColor: Colors.red,
                          radius: 3,
                        ),
                      ),
                    ),
                  ],
                ),
      floatingActionButton: projects.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: _currentPage > 0
                        ? () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    backgroundColor: _currentPage > 0
                        ? Colors.blue
                        : Colors.grey, // Disable effect
                    child: const Icon(Icons.arrow_back),
                  ),
                  FloatingActionButton(
                    onPressed: _currentPage < projects.length - 1
                        ? () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    backgroundColor: _currentPage < projects.length - 1
                        ? Colors.blue
                        : Colors.grey, // Disable effect
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
    );
  }
}
