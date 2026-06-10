import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class ApiService {
  // ---------------------------------------------------------------
  // IMPORTANT: Change this to your computer's local IP address.
  // Do NOT use 'localhost' on a physical device — it won't work.
  // Find your IP:  Windows → ipconfig  |  Mac/Linux → ifconfig
  // Example: static const String baseUrl = 'http://192.168.1.5/student_api';
  // ---------------------------------------------------------------
  //static const String baseUrl = 'http://10.0.2.2/student_api';
  static const String baseUrl = 'http://localhost/student_api';   //for local host
  //  ↑ 10.0.2.2 is the Android Emulator alias for your PC's localhost

  static const String insertEndpoint = '$baseUrl/insert_student.php';
  static const String fetchEndpoint = '$baseUrl/fetch_students.php';

  /// Insert a new student record into the database.
  Future<Map<String, dynamic>> insertStudent(Student student) async {
    try {
      final response = await http
          .post(
            Uri.parse(insertEndpoint),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(student.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  /// Fetch all student records from the database.
  Future<List<Student>> fetchStudents() async {
    try {
      final response = await http
          .get(Uri.parse(fetchEndpoint))
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        final List<dynamic> list = data['students'];
        return list.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch students');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }
}
