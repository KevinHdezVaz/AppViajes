import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {

  final Map<String, List<Map<String, dynamic>>> categorySpots;

  ExploreScreen({required this.categorySpots});

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> allSpots = [];
    categorySpots.forEach((category, spots) {
      allSpots.addAll(spots);
    });

     return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implementa la acción de búsqueda aquí
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: allSpots.length,
        itemBuilder: (context, index) {
          var spot = allSpots[index];
          return Card(
            color: Colors.white,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Image.asset(
                spot['images'][0], // Asumiendo que 'images' es una lista de rutas de imágenes
                fit: BoxFit.cover,
                width: 80,
              ),
              title: Text(spot['title'], style:  TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(spot['location'], style: TextStyle(color: Colors.grey)),
                  Text('\$${spot['price']}', style: TextStyle(color: Theme.of(context).primaryColor)),
                ],
              ),
              trailing: IconButton(
                iconSize: 40,
                icon: Icon(Icons.arrow_circle_right_sharp),
                color: Colors.orange,
                onPressed: () {
                  // Implementa la acción aquí
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
