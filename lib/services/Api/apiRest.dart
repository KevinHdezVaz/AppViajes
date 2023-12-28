import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRest {
  final String baseUrl = "http://192.168.11.15:8000/api"; // Reemplaza con la URL de tu API
 
  Future<http.Response> register(String name, String email, String password, String passwordConfirmation) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );
    return response;
  }
  
// Aquí está la función modificada para integrarse en tu clase ApiRest
  Future<List<dynamic>> fetchUserReservations(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user-reservations'),
      headers: {
        'Authorization': 'Bearer $token', // Utiliza el token de autenticación
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load reservations');
    }
  }

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    return response;
  }
}
