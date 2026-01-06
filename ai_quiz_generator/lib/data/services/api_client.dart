import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static String get baseUrl {
    // 1. Check if running on Web
    if (kIsWeb) {
      return "http://localhost:8000";
    }

    // 2. Check if running on Android (Physical or Emulator)
    if (Platform.isAndroid) {
      // 10.0.2.2 is the special alias for the host machine's 'localhost'
      return "http://10.0.2.2:8000";
    }

    // 3. Check for Desktop (Windows/Linux/macOS) or iOS Emulator
    return "http://localhost:8000";
  }

  static Future<T> get<T>(
    String endpoint, {
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return fromJson != null ? fromJson(decoded) : decoded as T;
      } else {
        throw Exception('Failed to load: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }

  static Future<T> post<T>(
    String endpoint, {
    required Map<String, dynamic> body,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        return fromJson != null ? fromJson(decoded) : decoded as T;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Request failed');
      } else {
        throw Exception('Failed to post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }

  static Future<T> put<T>(
    String endpoint, {
    required Map<String, dynamic> body,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        if (response.body.isEmpty) return null as T;
        final decoded = jsonDecode(response.body);
        return fromJson != null ? fromJson(decoded) : decoded as T;
      } else {
        throw Exception('Failed to update: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }
}
