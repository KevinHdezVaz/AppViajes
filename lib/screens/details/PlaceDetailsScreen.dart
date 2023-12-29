import 'dart:async';
import 'package:appviajes/screens/details/ConfirmationScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final String title;
  final String location;
   final List<String> imageUrls;

  final Map<String, dynamic> costExtra;

  final String duration;
  final String detalles;
  final String openingTime;
  final String closingTime;
  final double latitud;
  final double longitud;
  final double rating;
  final String nota;
  final String image_price;
  final int membersCount;
  final List<Map<String, dynamic>> packages;

  PlaceDetailsScreen({
    required this.title,
    required this.location, 
    required this.costExtra,
    required this.detalles,
    required this.imageUrls,
    required this.openingTime,
    required this.nota,
    required this.closingTime,
    required this.duration,
    required this.rating,
    required this.latitud,
    required this.longitud,
    required this.image_price,
    required this.membersCount,
    required this.packages,
  });

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  DateTime today = DateTime.now();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(
        controller); // Asumiendo que _controller es un Completer<GoogleMapController>
  }

  @override
  void initState() {
    super.initState();
  }

List<Widget> _buildPriceListForWeek(Map<String, dynamic> prices) {
    List<Widget> priceWidgets = [];
    prices.forEach((day, price) {
      priceWidgets.add(
        Text('$day - $price MXN', style: TextStyle(fontSize: 16)),
      );
    });
    return priceWidgets;
  }

  TableRow _buildPriceRow(String day, String price) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(day, style: TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('$price MXN', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
 Table _buildPriceTable(Map<String, dynamic> prices) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      children: [
        ...prices.keys.map((day) {
          return _buildPriceRow(day, prices[day]);
        }).toList(),
      ],
    );
  }

  String dayOfWeek = DateFormat('EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer();
    final LatLng _cocoBongoLatLng = LatLng(widget.latitud, widget.longitud);

    Set<Marker> markers = {
      Marker(
        markerId: MarkerId('coco_bongo_playa_del_carmen'),
        position: _cocoBongoLatLng,
        infoWindow: InfoWindow(
          title: widget.title,
        ),
      ),
    };

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          /*
          CircularParticle(
            key: UniqueKey(),
            awayRadius: 10,
            numberOfParticles: 30,
            speedOfParticles: 1,
            height: screenHeight,
            width: screenWidth,
            onTapAnimation: true,
            particleColor: Colors.white.withAlpha(150),
            awayAnimationDuration: Duration(milliseconds: 600),
            maxParticleSize: 4,
            isRandSize: true,
            isRandomColor: true,
            randColorList: [
              Color.fromARGB(255, 232, 171, 29),
              Color.fromARGB(252, 84, 0, 132)
            ],
            awayAnimationCurve: Curves.bounceIn,
            enableHover: true,
            hoverColor: Colors.white,
            hoverRadius: 10,
            connectDots: false, //not recommended
          ),

          */
          SingleChildScrollView(
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Scaffold(
                            backgroundColor: Colors.black,
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            body: Center(
                              child: PhotoView(
                                imageProvider: NetworkImage(imageUrl),
                              ),
                            ),
                          ),
                        ));
                      },
                      child: Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(widget.location,
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.timer, color: Colors.grey),
                          Text(widget.duration,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: Color.fromARGB(252, 84, 0, 132)),
                          Text('${widget.rating}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey)),
                          Text('(${widget.membersCount}+ Trips Members)',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 26),
                      Divider(
                        height: 4,
                        color: Color.fromARGB(255, 232, 171, 29),
                      ),
                      SizedBox(height: 26),
                      Text('Detalles',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      Text(
                        widget.detalles,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 26),
                      Divider(
                        height: 4,
                        color: Color.fromARGB(255, 232, 171, 29),
                      ),
                      SizedBox(height: 26),
                      Text('Paquetes:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      // Asegúrate de eliminar el SingleChildScrollView que envuelve a la Column si existe
                      AnimationLimiter(
                        child: Column(
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 3000),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 150.0,
                              child: FadeInAnimation(
                                child: widget,
                              ),
                            ),
                            children: widget.packages.map((package) {
                              return Card(
                                child: ExpansionTile(
                                  title: Text(
                                    package['name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  children:
                                      package['details'].map<Widget>((detail) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(detail),
                                    );
                                  }).toList(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 26),
                      Divider(
                        height: 4,
                        color: Color.fromARGB(255, 232, 171, 29),
                      ),
                      SizedBox(height: 26),
                      Text('Ubicación:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 26),
                      Container(
                        width: 400,
                        height: 300,
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            controller.showMarkerInfoWindow(MarkerId(
                                'coco_bongo_playa_del_carmen')); // Esto hará que la ventana de información sea visible inmediatamente
                          },
                          initialCameraPosition: CameraPosition(
                            target: _cocoBongoLatLng,
                            zoom: 15.0,
                          ),
                          markers: markers,
                        ),
                      ),
                      SizedBox(height: 36),
                      Divider(
                        height: 4,
                        color: Color.fromARGB(255, 232, 171, 29),
                      ),
                      SizedBox(height: 36),
                      Text('Precios:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 26),

       
              // Sección de Precios
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Precios:',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    ...widget.packages.map((package) {
                      return Card(
                        child: ExpansionTile(
                          title: Text(
                            package['name'],
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          children: [
                            _buildPriceTable(package['prices']),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

                      Image.asset(widget.image_price),
                      SizedBox(height: 36),
                      
                      SizedBox(height: 26),
                      Divider(
                        height: 4,
                        color: Color.fromARGB(255, 232, 171, 29),
                      ),
                      SizedBox(height: 26),
                      Text('Horario:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wb_sunny, color: Colors.orange),
                          Text(widget.openingTime,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(
                              width:
                                  20), // Espacio entre texto de apertura y cierre
                          Icon(Icons.nights_stay, color: Colors.deepPurple),
                          Text(widget.closingTime,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 26),
                      Divider(
                        height: 4,
                        color: Color.fromARGB(255, 232, 171, 29),
                      ),
                      SizedBox(height: 26),
                      Text('Notas:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),

                      Text(widget.nota, style: TextStyle(fontSize: 16)),
                      SizedBox(height: 26),
                      Card(
                        elevation:
                            4.0, // Opcional: elevación para efecto sombra
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Opcional: agregar un poco de espacio
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Alinea los textos a la izquierda
                            children: [
                              Text(
                                "Costos Extras",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Column(
                                  children:
                                      widget.costExtra.entries.map((entry) {
                                    return ListTile(
                                      title: Text(entry.key),
                                      subtitle: Text(entry.value.toString()),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ConfirmationScreen(
                                     
                                    title: widget.title, 
                                    packages: widget.packages,
                                  
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Reservar ahora',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
        ],
      ),
    );
  }
}
