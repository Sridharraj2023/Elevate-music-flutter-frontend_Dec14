import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class ApiTestMySQL {
  // Test basic API connection
  static Future<bool> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.resolvedApiUrl}/../'),
        headers: {'Content-Type': 'application/json'},
      );
      
      print('API Connection Test:');
      print('Status: ${response.statusCode}');
      print('Response: ${response.body}');
      
      return response.statusCode == 200;
    } catch (e) {
      print('API Connection Error: $e');
      return false;
    }
  }

  // Test categories endpoint
  static Future<bool> testCategories() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.resolvedApiUrl}/categories'),
        headers: {'Content-Type': 'application/json'},
      );
      
      print('Categories Test:');
      print('Status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Categories found: ${data.length}');
        return true;
      }
      
      return false;
    } catch (e) {
      print('Categories Test Error: $e');
      return false;
    }
  }

  // Test music endpoint
  static Future<bool> testMusic() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.resolvedApiUrl}/music'),
        headers: {'Content-Type': 'application/json'},
      );
      
      print('Music Test:');
      print('Status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Music items found: ${data.length}');
        return true;
      }
      
      return false;
    } catch (e) {
      print('Music Test Error: $e');
      return false;
    }
  }

  // Run all tests
  static Future<void> runAllTests() async {
    print('=== MySQL Backend API Tests ===');
    
    await testConnection();
    await testCategories();
    await testMusic();
    
    print('=== Tests Complete ===');
  }
}