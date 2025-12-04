// api_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://127.0.0.1/app/';  // Adjust for your local XAMPP setup

class ApiService {
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}login.php'),
      body: {'username': username, 'password': password},
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> register(
      String username,
      String password,
      String nid,
      String dob,
      String phone,
      String email,
      Uint8List? imageBytes,
      ) async {
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}register.php'));
    request.fields['username'] = username;
    request.fields['password'] = password;
    request.fields['nid'] = nid;
    request.fields['dob'] = dob;
    request.fields['phone'] = phone;
    request.fields['email'] = email;
    if (imageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('image', imageBytes, filename: 'image.jpg'));
    }
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    return json.decode(respStr);
  }

  static Future<Map<String, dynamic>> forgotPassword(String nid, String newPassword) async {
    final response = await http.post(
      Uri.parse('${baseUrl}forgot.php'),
      body: {'nid': nid, 'new_password': newPassword},
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getUsernameByNid(String nid) async {
    final response = await http.post(
      Uri.parse('${baseUrl}get_username.php'),
      body: {'nid': nid},
    );
    return json.decode(response.body);
  }
}