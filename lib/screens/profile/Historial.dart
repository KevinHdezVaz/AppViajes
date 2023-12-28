import 'package:appviajes/screens/Onboarding/SignInScreen.dart';
import 'package:appviajes/services/Api/apiRest.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Historial extends StatefulWidget {
  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  Future<List<dynamic>>? reservationsFuture;
  var apiRest = ApiRest();

  @override
  void initState() {
    super.initState();
    reservationsFuture = fetchUserReservations();
  }

Future<List<dynamic>> fetchUserReservations() async {
    final prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');

    if (authToken == null) {
      // authToken es null, maneja este caso aquí
      // Por ejemplo, puedes redirigir al usuario a la pantalla de inicio de sesión
      throw Exception('No se encontró el token de autenticación');
    }

    return apiRest.fetchUserReservations(authToken);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Reservas'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Acción del botón de configuración
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: reservationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay reservaciones"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var reservation = snapshot.data![index];
             return ListTile(
  title: Text(reservation['name'] ?? 'Nombre no disponible'),
  subtitle: Text(
    'Fecha: ${reservation['travel_date'] ?? 'Fecha no disponible'} - '
    'Paquete: ${reservation['package'] ?? 'Paquete no disponible'}'
  ),
);

            },
          );
        },
      ),
    );
  }
}
