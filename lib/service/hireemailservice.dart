import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Hireemailservice {
  static Future<bool> sendHireEmail(
    String email,
    String name,
    String number,
    String role,
    String date,
  ) async {
    try {
      String endpoint = "https://api.emailjs.com/api/v1.0/email/send";
      Uri uri = Uri.parse(endpoint);

      Map<String, dynamic> body = {
        "service_id": "service_hq84zlv",
        "template_id": "template_7yh0swc",
        "user_id": "JlNUyZ9u49B2ZAHzQ",
        "template_params": {
          "user_email": email,
          "user_name": name,
          "phone_number": number,
          "role": role,
          "start_date": date,
        },
      };
      Future.delayed(const Duration(seconds: 1));

      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        log(response.body);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
