import 'package:frontend_template/utils/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  late final String baseUrl;
  final accessToken = Supabase.instance.client.accessToken;

  ApiService() {
    baseUrl = AppConfig.apiBaseUrl;
  }

  // Basic ping that doesn't need auth
  Future<String> ping() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/ping'));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw 'Failed to ping';
    } catch (e) {
      rethrow;
    }
  }

  // Authenticated ping that needs bearer token
  Future<String> pingAuthenticated() async {
    try {
      if (accessToken == null) throw 'No auth token';

      final response = await http.get(
        Uri.parse('$baseUrl/ping-authenticated'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      }
      throw 'Failed to ping authenticated endpoint';
    } catch (e) {
      rethrow;
    }
  }
}
