import 'package:appviajes/screens/details/PlaceDetailsScreen.dart';
import 'package:appviajes/screens/profile/Historial.dart';
import 'package:appviajes/services/Api/apiRest.dart';
import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BestNatureList.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedCategoryIndex = 0;
  String _selectedSubcategory = 'Most viewed';
  String userName = "Cargando..."; // Un valor predeterminado
   var apiRest = ApiRest();
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.explore, 'text': 'Antros'},
    {'icon': Icons.waves, 'text': 'Acuático'},
    {'icon': Icons.account_balance, 'text': 'Cultural'},
    {'icon': Icons.family_restroom, 'text': 'Familiar'},
    {'icon': Icons.directions_bike, 'text': 'Extremo'},
    {'icon': Icons.directions_car, 'text': 'Autos'},
    {'icon': Icons.directions_boat, 'text': 'Yates'},
    {'icon': Icons.lock, 'text': 'Privados'},
  ];

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _selectedSubcategory = 'Most viewed';
    });
  }
  @override
  void initState() {
    super.initState();
    
  }

  void _onSubcategorySelected(String subcategory) {
    setState(() {
      _selectedSubcategory = subcategory;
    });
  }

  Widget _buildSubcategoryButton(String subcategory) {
    bool isSelected = _selectedSubcategory == subcategory;
    return GestureDetector(
      onTap: () => _onSubcategorySelected(subcategory),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          subcategory,
          style: TextStyle(
            color: isSelected ? Color.fromARGB(252, 84, 0, 132) : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:   Row(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.account_circle,
                size: 40.0, // El tamaño del icono
                color: Colors.grey, // El color del icono
              ),
            ),
            SizedBox(width: 10), // Espacio entre el avatar y el texto.
      



          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {

 Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Historial()),
        );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CircularParticle(
              key: UniqueKey(),
              awayRadius: 10,
              numberOfParticles: 50,
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
            Column(
              children: [
                // Sección para seleccionar categorías y subcategorías
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Alinea los hijos a la izquierda
                        children: [
                          Text(
                            'Discover',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            'Explora tu destino favorito.',
                            style: TextStyle(color: Colors.grey, fontSize: 19),
                          ),
                        ],
                      ),

                      SizedBox(height: 20), // Espacio entre widgets

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Wrap(
                            spacing:
                                20, // Espacio horizontal entre los elementos
                            children: List.generate(categories.length, (index) {
                              return _categoryButton(
                                context,
                                categories[index]['icon'],
                                categories[index]['text'],
                                _selectedCategoryIndex == index,
                                index,
                              );
                            }),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //   _buildSubcategoryButton('Most viewed'),
                          //  _buildSubcategoryButton('Recommend'),
                          //  _buildSubcategoryButton('All'),
                        ],
                      ),
                    ],
                  ),
                ),

                BestNatureList(
                  category: categories[_selectedCategoryIndex]['text'],
                  subcategoryFilter: _selectedSubcategory,
                  onCardTap: (spot) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceDetailsScreen(
                          title: spot['title'],
                          location: spot['location'],
                          prices: spot['prices']!!,
                          image_price: spot['image_price'],
                          latitud: spot['latitud'],
                          longitud: spot['longitud'],
                          imageUrls: spot['images'],
                          nota: spot['nota'],
                          costExtra: spot['cost_extra'],
                          openingTime: spot['openingTime'],
                          closingTime: spot['closingTime'],
                          duration:
                              '3 days', // Aquí deberías pasar la duración real
                          detalles: spot[
                              'detalles'], // Aquí deberías pasar la duración real,
                          rating: 4.7, // Aquí deberías pasar el rating real
                          packages: spot['packages'],
                           
                          membersCount:
                              20, // Aquí deberías pasar el número real de miembros
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(BuildContext context, IconData icon, String text,
      bool isSelected, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedCategoryIndex =
              index; // Actualiza el índice de la categoría seleccionada
        });
      },
      style: ElevatedButton.styleFrom(
        primary: isSelected
            ? Color.fromARGB(252, 84, 0, 132)
            : Colors.white, // Color de fondo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0), // Redondear las esquinas
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 22.0), // Espaciado interno
      ),
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // Asegúrate de que la columna no ocupe más espacio del necesario
        children: <Widget>[
          Icon(icon,
              color:
                  isSelected ? Colors.white : Colors.grey), // Color del icono
          Text(text,
              style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.grey)), // Color del texto
        ],
      ),
    );
  }
    
}