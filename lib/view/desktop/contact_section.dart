  import 'package:flutter/material.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:portfolio/service/contatctmainservice.dart';
  import 'package:portfolio/widgets/mybottom_sheet.dart';
  import 'package:url_launcher/url_launcher.dart';

  class ContactSection extends StatefulWidget {
    const ContactSection({super.key});

    @override
    State<ContactSection> createState() => _ContactSectionState();
  }

  class _ContactSectionState extends State<ContactSection> {
    late double width;
    late double height;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _messageController = TextEditingController();

    void _launchURL(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }

    void _submitForm() {
      if (_formKey.currentState!.validate() && isValid(_emailController.text)) {
        Contatctmainservice.sendContactEmail(_emailController.text,
                _nameController.text, _messageController.text)
            .then((value) {
          if (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Email sent successfully"),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to send email"),
                backgroundColor: Colors.red,
              ),
            );
          }
        });

        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a valid email"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;

      return Container(
        width: width,
        height: height,
        color: const Color.fromRGBO(18, 18, 18, 1),
        child: Column(
          children: [
            Divider(
              color: Colors.white60,
              thickness: 2,
              indent: width * 0.03,
              endIndent: width * 0.03,
            ),
            AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.only(
                // left: width * 0.03,
                // right: width * 0.03,
                top: height * 0.27,
                bottom: height * 0.08,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Get in Touch",
                        style: GoogleFonts.robotoSlab(
                          fontSize: (width * 0.03 > 16) ? width * 0.03 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        "Let's collaborate! Feel free to reach out.",
                        style: GoogleFonts.robotoSlab(
                          fontSize: (width * 0.01 > 16) ? width * 0.01 : 20,
                          color: Colors.white60,
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            color: const Color.fromRGBO(229, 101, 0, 1),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          GestureDetector(
                            onTap: () => _launchURL("abhibhosale611@gmail.com"),
                            child: Text(
                              "abhibhosale611@gmail.com",
                              style: GoogleFonts.robotoSlab(
                                fontSize: (width * 0.01 > 16) ? width * 0.01 : 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Color.fromRGBO(229, 101, 0, 1),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          GestureDetector(
                            onTap: () => _launchURL("tel:+9284406173"),
                            child: Text(
                              "+91 9284406173",
                              style: GoogleFonts.robotoSlab(
                                fontSize: (width * 0.01 > 16) ? width * 0.01 : 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => redirectToLink(
                                "https://www.instagram.com/abhi_bhosale36/"),
                            child: buildSocialMedia(FontAwesomeIcons.instagram),
                          ),
                          GestureDetector(
                            onTap: () => redirectToLink(
                                "https://www.instagram.com/abhi_bhosale36/"),
                            child: buildSocialMedia(FontAwesomeIcons.twitter),
                          ),
                          GestureDetector(
                            onTap: () => _launchURL("https://wa.me/9284406173"),
                            child: buildSocialMedia(FontAwesomeIcons.whatsapp),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),

                      ///Hire me button lead me to the email to write emals
                      ///
                      GestureDetector(
                        onTap: () {
                          MyBottomSheetDemo().showHireMeForm(context);
                        },
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 400),
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 208, 15, 15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "Hire Me",
                            style: GoogleFonts.robotoSlab(
                              fontSize: (width * 0.01 > 16) ? width * 0.01 : 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    // padding: EdgeInsets.all(width * 0.05),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.02,
                    ),
                    width: width * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            style: GoogleFonts.robotoSlab(
                              color: Colors.white60,
                              fontSize: width * 0.01,
                            ),
                            decoration: InputDecoration(
                              labelText: "Name",
                              filled: true,
                              fillColor: Colors.white10,
                              border: const OutlineInputBorder(),
                              labelStyle: GoogleFonts.robotoSlab(
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.015),
                          TextFormField(
                            controller: _emailController,
                            style: GoogleFonts.robotoSlab(
                              color: Colors.white60,
                              fontSize: width * 0.01,
                            ),
                            decoration: InputDecoration(
                              labelText: "Email",
                              filled: true,
                              fillColor: Colors.white10,
                              border: const OutlineInputBorder(),
                              labelStyle: GoogleFonts.robotoSlab(
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                  .hasMatch(value)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.015),
                          TextFormField(
                            controller: _messageController,
                            maxLines: 5,
                            style: GoogleFonts.robotoSlab(
                              color: Colors.white60,
                              fontSize: width * 0.01,
                            ),
                            decoration: InputDecoration(
                              labelText: "Message",
                              filled: true,
                              fillColor: Colors.white10,
                              border: const OutlineInputBorder(),
                              labelStyle: GoogleFonts.robotoSlab(
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your message";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: height * 0.02),
                          GestureDetector(
                            onTap: _submitForm,
                            child: AnimatedContainer(
                              alignment: Alignment.center,
                              duration: const Duration(milliseconds: 400),
                              width: width * 0.15,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 208, 15, 15),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "Send",
                                style: GoogleFonts.robotoSlab(
                                  fontSize:
                                      (width * 0.01 > 16) ? width * 0.01 : 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    void redirectToLink(String url) async {
      Uri uri = Uri.parse(url);
      try {
        await launchUrl(uri);
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Unable to open the link",
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.01,
              ),
            ),
          ),
        );
      }
    }

    Widget buildSocialMedia(IconData icon) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {},
        onExit: (event) {},
        child: Container(
          width: (width * 0.03 > 16) ? width * 0.03 : 35,
          height: (width * 0.03 > 16) ? width * 0.03 : 30,
          margin: EdgeInsets.only(right: width * 0.02),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(114, 113, 113, 1),
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: (width * 0.3 > 20) ? width * 0.01 : 25,
            color: const Color.fromRGBO(114, 113, 113, 1),
          ),
        ),
      );
    }
  }
