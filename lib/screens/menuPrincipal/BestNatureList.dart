import 'package:flutter/material.dart';

class BestNatureList extends StatelessWidget {
  final String category;
  final String subcategoryFilter;
  
   BestNatureList({
    required this.category,
   required this.subcategoryFilter,
  });

 
  final Map<String, List<Map<String, dynamic>>> categorySpots = {
  'Flights': [
    {
      'title': 'Sky Adventures',
      'location': 'Cloud Nine',
      'price': '99.00',
      'image': 'assets/onboarding/illustration2.png',
       'subcategory': 'Most viewed',
    },
    {
      'title': 'High Flyers',
      'location': 'Stratosphere',
      'price': '149.00',
      'image': 'assets/onboarding/illustration2.png',
       'subcategory': 'Most viewed',
    },
     {
      'title': 'High Flyers',
      'location': 'Stratosphere',
      'price': '149.00',
      'image': 'assets/onboarding/illustration2.png',
       'subcategory': 'Most viewed',
    }, {
      'title': 'High Flyers',
      'location': 'Stratosphere',
      'price': '149.00',
      'image': 'assets/onboarding/illustration2.png',
       'subcategory': 'Recommend',
    },
    // Añade más lugares relacionados con vuelos aquí...
  ],
  'Hotel': [
    {
      'title': 'Luxury Stay',
      'location': 'Dreamland',
      'price': '299.00',
      'image': 'assets/onboarding/illustration.png',
        'subcategory': 'Most viewed',
    },
    {
      'title': 'Ocean View Rooms',
      'location': 'Beachside',
      'price': '399.00',
      'image': 'assets/onboarding/illustration2.png',
       'subcategory': 'Recommend',

    },
    // Añade más lugares relacionados con hoteles aquí...
  ],
  'Bus': [
    {
      'title': 'Scenic Bus Tour',
      'location': 'Countryside',
      'price': '49.00',
      'image': 'assets/onboarding/illustration3.png',
        'subcategory': 'Most viewed',
    },
    {
      'title': 'City Explorers',
      'location': 'Urban Center',
      'price': '59.00',
      'image': 'assets/onboarding/illustration2.png',
             'subcategory': 'Recommend',

    },
    // Añade más lugares relacionados con autobuses aquí...
  ],
  // Agrega más categorías y lugares según sea necesario...
};
 @override
  Widget build(BuildContext context) {
  //  List<Map<String, dynamic>> natureSpots = categorySpots[category] ?? [];
 // Filtrar los lugares por categoría y subcategoría
 List<Map<String, dynamic>> natureSpots = categorySpots[category] ?? [];

    // Filtrar los lugares por categoría y subcategoría
    List<Map<String, dynamic>> filteredSpots = natureSpots.where((spot) {
      return spot['subcategory'] == subcategoryFilter;
    }).toList() ?? [];

    return Container(
      height: 350, // Ajusta la altura según sea necesario
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredSpots.length,
        itemBuilder: (BuildContext context, int index) {
          var spot = filteredSpots[index];
          return Container(
            width: 180, // Ajusta el ancho según sea necesario
            margin: EdgeInsets.only(
              left: index == 0 ? 20 : 10,
              right: 10,
              top: 10,
              bottom: 10,
            ), // Añade margen alrededor de la tarjeta
            child: Card(
              elevation: 4.0,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        spot['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          spot['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: Colors.red),
                            Text(
                              spot['location'],
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$${spot['price']} /person',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}