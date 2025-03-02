import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio/service/hireemailservice.dart';

bool isValid(String email) {
  RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  if (email.isEmpty) {
    return false;
  } else if (!emailRegExp.hasMatch(email)) {
    return false;
  } else {
    return true;
  }
}

class MobileBottom {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedRole;
  DateTime? _selectedDate;
  bool isLoading = false;

  final List<String> _roles = [
    "Software Developer",
    "Backend Developer",
    "Flutter Developer"
  ];

  void showHireMeForm(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding: EdgeInsets.only(
                left: width * 0.04,
                top: height * 0.02,
                right: width * 0.04,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(18, 18, 18, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Hire Me",
                      style: GoogleFonts.robotoSlab(
                        color: const Color.fromRGBO(229, 101, 0, 1),
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.02),

                    // Full Name & Email
                    _buildInputField(
                        "Full Name", _nameController, width, height),
                    SizedBox(height: height * 0.03),

                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                              "Phone Number", _phoneController, width, height,
                              keyboardType: TextInputType.phone),
                        ),
                        SizedBox(width: width * 0.02),
                        Expanded(
                          child: _buildInputField(
                              "Email Address", _emailController, width, height,
                              keyboardType: TextInputType.emailAddress),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // Role Selection Dropdown
                    _buildDropdownField("Role ", _roles, width, (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    }, _selectedRole),
                    SizedBox(height: height * 0.03),

                    // Date Picker & File Upload
                    Row(
                      children: [
                        Expanded(
                          child: _buildDatePickerField(
                              context, "Start Date", width, setState),
                        ),
                        SizedBox(width: width * 0.02),
                      ],
                    ),

                    SizedBox(height: height * 0.05),

                    // Submit Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        if (isValid(_emailController.text.trim()) &&
                            _nameController.text.trim().isNotEmpty &&
                            _phoneController.text.trim().isNotEmpty &&
                            _selectedRole != null &&
                            _selectedDate != null) {
                          Hireemailservice.sendHireEmail(
                            _emailController.text.trim(),
                            _nameController.text.trim(),
                            _phoneController.text.trim(),
                            _selectedRole!,
                            _selectedDate!.toLocal().toString().split(' ')[0],
                          ).then((val) {
                            if (val) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Email Sent Successfully"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Failed to send email"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          });

                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Please fill all the fields or check email"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 229, 0, 0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: (isLoading)
                            ? Center(
                                child: LoadingAnimationWidget.progressiveDots(
                                  color: Colors.white,
                                  size: 50,
                                ),
                              )
                            : Text(
                                "Submit",
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.white,
                                  fontSize: width * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      double width, double height,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.robotoSlab(
              color: Colors.white, fontSize: width * 0.025),
        ),
        SizedBox(height: height * 0.01),
        TextFormField(
          controller: controller,
          style: GoogleFonts.robotoSlab(
              color: const Color.fromARGB(144, 255, 255, 255),
              fontSize: width * 0.025),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> options, double width,
      Function(String?) onChanged, String? selectedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.robotoSlab(
                color: Colors.white, fontSize: width * 0.025)),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          dropdownColor: Colors.black,
          style: const TextStyle(color: Colors.white),
          value: selectedValue,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDatePickerField(
      BuildContext context, String label, double width, Function setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.robotoSlab(
                color: Colors.white, fontSize: width * 0.025)),
        const SizedBox(height: 5),
        TextFormField(
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: _selectedDate == null
                ? "Select Date"
                : _selectedDate!.toLocal().toString().split(' ')[0],
            hintStyle: GoogleFonts.robotoSlab(
              color: const Color.fromARGB(144, 255, 255, 255),
              fontSize: width * 0.025,
            ),
          ),
        ),
      ],
    );
  }
}
