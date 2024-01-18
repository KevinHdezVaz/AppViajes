import 'package:appviajes/screens/details/PlaceDetailsScreen.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  final Map<String, List<Map<String, dynamic>>> categorySpots;

  ExploreScreen({required this.categorySpots});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> allSpots = [];
    widget.categorySpots.forEach((category, spots) {
      allSpots.addAll(spots);
    });
    void navigateToDetails(Map<String, dynamic> spot) {
      // Aquí implementarías la navegación a la pantalla de detalles
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceDetailsScreen(
            title: spot['title'],
            location: spot['location'], 
            costExtra: spot['cost_extra'],
            latitud: spot['latitud'],
            longitud: spot['longitud'],
            imageUrls: spot['images'],
            image_price: spot['image_price'],
            duration: '3',
            detalles: spot['detalles'], // Aquí deberías pasar la duración real,
            nota: spot['nota'],
            openingTime: spot['openingTime'],
            closingTime: spot['closingTime'],
            membersCount: 21,
            rating: 5,
            packages: spot['packages'],
          ),
        ),
      );
    }

    List<Map<String, dynamic>> filteredSpots = searchQuery.isEmpty
        ? allSpots
        : allSpots.where((spot) {
            return spot['title'].toLowerCase().contains(searchQuery) ||
                spot['location'].toLowerCase().contains(searchQuery);
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Search your location...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                    width: 10), // Espacio entre el campo de búsqueda y el botón
                
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSpots.length,
              itemBuilder: (context, index) {
                var spot = filteredSpots[index];
                return GestureDetector(
                  onTap: () => navigateToDetails(spot),
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: Image.network(
                        spot['images'][0],
                        fit: BoxFit.cover,
                        width: 80,
                      ),
                      title: Text(spot['title'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(spot['location'],
                              style: TextStyle(color: Colors.grey)),
                       
                        ],
                      ),
                      trailing: IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.arrow_circle_right_sharp),
                        color: Color.fromARGB(252, 84, 0, 132),
                        onPressed: () {},
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
