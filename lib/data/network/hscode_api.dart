import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:topparcel/data/models/response/create_hscode_response.dart';

abstract class HScodeApi {
  static Future<CreateHscodeResponse> getHSCodesList(
      String email, String password, String code) async {
    final url = Uri.parse('https://topparcel.com/api/hscode');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
      'code': code,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      return CreateHscodeResponse.fromJson(responseBody);
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }
}
