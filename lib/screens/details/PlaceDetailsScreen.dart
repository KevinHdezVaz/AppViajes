import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final String title;
  final String location;
  final Map<String, dynamic> prices;
  final List<String> imageUrls;
  final String duration;
  final double rating;
  final int membersCount;
  final List<Map<String, dynamic>> packages;

  PlaceDetailsScreen({
    required this.title,
    required this.location,
    required this.prices,
    required this.imageUrls,
    required this.duration,
    required this.rating,
    required this.membersCount,
    required this.packages,
  });

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 250.0,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
              items: widget.imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius:
                            BorderRadius.circular(15.0), // Bordes redondeados
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15.0), // Aplica los bordes redondeados aquí

                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(widget.location,
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.grey),
                      Text(widget.duration,
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Color.fromARGB(252, 84, 0, 132)),
                      Text('${widget.rating}',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                      Text('(${widget.membersCount}+ Trips Members)',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Detalles',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text(
                    'The wave is a sandstone rock formation located in Arizona united states, near its northern border with utah. The formation is situated on the slopes of the coyote buttes in the paria canyon vermilion cliffs wilderness...',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text('Paquetes:',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Column(
                    children: widget.packages.map((package) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(package['name'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            ...package['details']
                                .map((detail) => Text(detail))
                                .toList(),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Text('Detalles',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text('Precios (MXN):',
    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
...widget.prices.entries.map((entry) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('${entry.key}:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ...entry.value.entries.map((priceEntry) => Text(
        '${priceEntry.key}: ${priceEntry.value}',
        style: TextStyle(fontSize: 16),
      )),
    ],
  );
}),
                  Text(
                    'Apertura: 9 P.M.\nCierre: 3 A.M.\n*Transportación a partir de 10 pax*',
                    style: TextStyle(fontSize: 16),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Booking logic goes here
                        },
                        child: Text(
                          'Reservar ahora',
                          style: TextStyle(
                            fontSize: 20, // Cambia el tamaño del texto aquí
                            color: Colors
                                .white, // Opcional: Cambia el color del texto
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          primary: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
