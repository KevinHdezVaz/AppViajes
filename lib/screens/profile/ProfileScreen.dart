import 'package:appviajes/screens/Onboarding/SignInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Acción del botón de configuración
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
         Padding(
  padding: const EdgeInsets.all(16.0),
  child: CircleAvatar(
    radius: 100, // Tamaño del avatar
    backgroundImage: AssetImage('assets/logox.webp'),
  ),
),

          Center(
            child: FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (snapshot.hasData) {
                  String userName =
                      snapshot.data!.getString('userName') ?? "Usuario";
                  return Text(
                    userName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  );
                } else {
                  return CircularProgressIndicator(); // Mientras se cargan los SharedPreferences
                }
              },
            ),
          ),
 
        
          SizedBox(height: 40),
          _buildLogoutTile(context)
        ],
      ),
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 13), // Esto añade espacio entre cada elemento

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
             child:
                Icon(Icons.exit_to_app, color: Color.fromARGB(252, 84, 0, 132)),
          ),
          title: Text('Cerrar sesión', style: TextStyle(color: Colors.black)),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('token');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCustomListTile({
    required IconData leadingIcon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 3.0,
          horizontal: 3), // Esto añade espacio entre cada elemento
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30.0), // Esquinas redondeadas del Card
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(252, 84, 0, 132),
            child: Icon(leadingIcon, color: Color.fromARGB(252, 84, 0, 132)),
          ),
          title: Text(title, style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      constraints: BoxConstraints(
        minWidth: 14,
        minHeight: 14,
      ),
      child: Text(
        '!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
