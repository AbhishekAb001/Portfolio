import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Contatctmainservice {
  static Future<bool> sendContactEmail(
    String email,
    String name,
    String message,
  ) async {
    try {
      String endpoint = "https://api.emailjs.com/api/v1.0/email/send";
      Uri uri = Uri.parse(endpoint);

      Map<String, dynamic> body = {
        "service_id": "service_hq84zlv",
        "template_id": "template_akshmrp",
        "user_id": "JlNUyZ9u49B2ZAHzQ",
        "template_params": {
          "user_email": email,
          "user_name": name,
          "user_messsage": message,
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
    } on Exception
     catch (e) {
      log(e.toString());
      return false;
    }
  }
}
