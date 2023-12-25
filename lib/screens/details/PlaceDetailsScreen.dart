import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:photo_view/photo_view.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final String title;
  final String location;
  final Map<String, dynamic> prices;
  final List<String> imageUrls;
  final String duration;
  final String detalles;

  final double rating;
  final int membersCount;
  final List<Map<String, dynamic>> packages;

  PlaceDetailsScreen({
    required this.title,
    required this.location,
    required this.prices,
    required this.detalles,
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
                errorWidget: (context, url, error) => Icon(Icons.error),
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
                      Text('Precios:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 26),
                      ListView.builder(
                        physics:
                            NeverScrollableScrollPhysics(), // para evitar el desplazamiento si está dentro de otro ScrollView
                        shrinkWrap:
                            true, // si está dentro de un Column/ListView para calcular la altura según los hijos
                        itemCount: widget.prices.length,
                        itemBuilder: (context, index) {
                          String key = widget.prices.keys.elementAt(index);
                          Map<String, String> priceEntry = widget.prices[key];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            child: ListTile(
                              title: Text('$key:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: priceEntry.entries
                                    .map((entry) => Text(
                                          '${entry.key}: ${entry.value} MXN',
                                          style: TextStyle(fontSize: 16),
                                        ))
                                    .toList(),
                              ),
                            ),
                          );
                        },
                      ),

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
        ],
      ),
    );
  }
}
