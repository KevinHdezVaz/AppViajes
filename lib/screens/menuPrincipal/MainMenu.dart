import 'package:appviajes/screens/menuPrincipal/BestNatureList.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

  int _selectedCategoryIndex = 0;
  String _selectedSubcategory = 'most viewed';


  
class _MainMenuState extends State<MainMenu> {
 
 


  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
       _selectedSubcategory = 'most viewed'; 
    });
  }

  void _onSubcategorySelected(String subcategory) {
  setState(() {
    _selectedSubcategory = subcategory;
  });
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
        mainAxisSize: MainAxisSize.min, // Para que la columna solo ocupe el espacio de sus hijos.
        children: [
          Text(
            'Hola',
            style: TextStyle(fontSize: 18), // Ajusta el tamaño de fuente según tu diseño.
          ),
          Text(
            'Bienvenido de nuevo!',
            style: TextStyle(fontSize: 12), // Ajusta el tamaño de fuente según tu diseño.
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
            // Discover Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                ],
              ),
            ),Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               
                _buildSubcategoryButton('Most viewed'),
                _buildSubcategoryButton('Recommend'),
                _buildSubcategoryButton('All'),
              ],
            ),
          ),

           BestNatureList(
    category: categories[_selectedCategoryIndex]['text'],
    subcategoryFilter: _selectedSubcategory, // Asegúrate de pasar la subcategoría aquí
),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          // Puedes agregar más items si lo necesitas
        ],
      ),
    );
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
 

// Función auxiliar para construir cada título de categoría
Widget _buildCategoryTitle(String title, bool isSelected) {
  return GestureDetector(
    onTap: () {
      // Aquí puedes actualizar el estado para cambiar la categoría seleccionada
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.orange : Colors.grey,
          ),
        ),
        if (isSelected)
          Container(
            margin: EdgeInsets.only(top: 2),
            height: 2,
            width: 20,
            color: Colors.orange,
          ),
      ],
    ),
  );
}
// Datos de ejemplo para las categorías
final List<Map<String, dynamic>> categories = [
  {'icon': Icons.flight, 'text': 'Flights'},
  {'icon': Icons.hotel, 'text': 'Hotel'},
  {'icon': Icons.directions_bus, 'text': 'Bus'},
  // Añade más categorías según sea necesario
];
