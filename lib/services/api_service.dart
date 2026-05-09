import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://69ff07748c70b15fa3cafd0a.mockapi.io/api/v1';

  static const String endpoint = '/users';

  /// Ambil semua users dari MockAPI
  static Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data: ${response.statusCode}');
    }
  }

  /// Tambah user baru ke MockAPI
  static Future<UserModel> createUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal menambah data: ${response.statusCode}');
    }
  }

  /// Hapus user dari MockAPI
  static Future<void> deleteUser(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus data: ${response.statusCode}');
    }
  }
}