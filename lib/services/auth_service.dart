import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String _baseUrl = "https://your-auth-service-url.com";
  final String _clientId = "yourClientId";
  final String _clientSecret = "yourClientSecret";

  // Function to authenticate user
  Future<Map<String, dynamic>> authenticateUser(String username, String password) async {
    final url = Uri.parse('$_baseUrl/oauth/token');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'password',
        'client_id': _clientId,
        'client_secret': _clientSecret,
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return {'success': true, 'token': responseData['access_token']};
    } else {
      return {'success': false, 'message': 'Authentication failed'};
    }
  }

  // Function to refresh token
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final url = Uri.parse('$_baseUrl/oauth/token');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'refresh_token',
        'client_id': _clientId,
        'client_secret': _clientSecret,
        'refresh_token': refreshToken,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return {'success': true, 'token': responseData['access_token'], 'refresh_token': responseData['refresh_token']};
    } else {
      return {'success': false, 'message': 'Token refresh failed'};
    }
  }

  // Function to revoke token
  Future<bool> revokeToken(String accessToken) async {
    final url = Uri.parse('$_baseUrl/oauth/revoke');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'token': accessToken,
        'client_id': _clientId,
        'client_secret': _clientSecret,
      },
    );

    return response.statusCode == 200;
  }
}
