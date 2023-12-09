import 'package:appviajes/screens/details/PlaceDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'BestNatureList.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedCategoryIndex = 0;
  String _selectedSubcategory = 'Most viewed';

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.flight, 'text': 'Flights'},
    {'icon': Icons.hotel, 'text': 'Hotel'},
    {'icon': Icons.directions_bus, 'text': 'Bus'},
 
  ];

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _selectedSubcategory = 'Most viewed';
    });
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
            color: isSelected ? Colors.orange : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              child: Icon(
                Icons.account_circle,
                size: 40.0, // El tamaño del icono
                color: Colors.grey, // El color del icono
              ),
            ),
            SizedBox(width: 10), // Espacio entre el avatar y el texto.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize
                  .min, // Para que la columna solo ocupe el espacio de sus hijos.
              children: [
                Text(
                  'Hola',
                  style: TextStyle(
                      fontSize:
                          18), // Ajusta el tamaño de fuente según tu diseño.
                ),
                Text(
                  'Bienvenido de nuevo!',
                  style: TextStyle(
                      fontSize:
                          12), // Ajusta el tamaño de fuente según tu diseño.
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Acción al presionar el ícono de configuraciones
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        
        child: Column(
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
                        'Explore the beautiful world',
                        style: TextStyle(color: Colors.grey, fontSize: 19),
                      ),
                    ],
                  ),
      
                  SizedBox(height: 10), // Espacio entre widgets
      
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 20, // Espacio horizontal entre los elementos
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
      
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSubcategoryButton('Most viewed'),
                      _buildSubcategoryButton('Recommend'),
                      _buildSubcategoryButton('All'),
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
                      price: spot['price'],
                      imageUrls: spot['images'],
                      duration: '3 days', // Aquí deberías pasar la duración real
                      rating: 4.7, // Aquí deberías pasar el rating real
                      membersCount:
                          20, // Aquí deberías pasar el número real de miembros
                    ),
                  ),
                );
              },
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
        primary: isSelected ? Colors.orange : Colors.white, // Color de fondo
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
