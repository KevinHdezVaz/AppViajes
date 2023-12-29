import 'package:appviajes/models/SpotData.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ConfirmationScreen extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> packages;

  ConfirmationScreen({
    Key? key,
    required this.title,
    required this.packages,
  }) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  int numberOfPassengers = 1;
  String? selectedPackage; // Hazlo nullable
  DateTime selectedDate = DateTime.now();
  double total = 0.0;
  bool isDateSelected = false;
  String? selectedHotel; // Variable para almacenar el hotel seleccionado
String searchQuery = ""; 
List<Map<String, dynamic>> filteredHotels = [];


  final List<Map<String, dynamic>> hotels =  SpotData.listaHoteles["Hotel"] ?? [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null).then((_) {
      setState(() {
        if (widget.packages.isNotEmpty) {
          selectedPackage = widget.packages[0]['name'];
          _calculateTotal();
        }
      });
    });
      filteredHotels = hotels;
 
  }

 

void _showPackageDetails(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Detalles del Paquete'),
        content: SingleChildScrollView(
          child: ListBody(
            children: widget.packages.map((package) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...package['details'].map<Widget>((detail) {
                      return Text('• $detail');
                    }).toList(),
                    SizedBox(height: 10),
                    Text('Precios:'),
                    ...package['prices'].entries.map<Widget>((entry) {
                      return Text('${entry.key}: \$${entry.value}');
                    }).toList(),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


void _filterHotels(String query) {
  List<Map<String, dynamic>> updatedList = hotels.where((hotel) {
    return hotel['title'].toLowerCase().contains(query.toLowerCase());
  }).toList();

  setState(() {
    searchQuery = query;
    filteredHotels = updatedList;
  });
}

  void _calculateTotal() {
    if (selectedPackage == null || !isDateSelected) {
      setState(() {
        total = 0.0;
      });
    } else {
      var package = widget.packages.firstWhere(
        (p) => p['name'] == selectedPackage,
        orElse: () => <String, Object>{},
      );

      if (package.isEmpty || !package.containsKey('prices')) {
        setState(() {
          total = 0.0;
        });
      } else {
        String dayOfWeek = DateFormat('EEEE', 'es_ES').format(selectedDate);
        // Capitalizar la primera letra del día de la semana para que coincida con el JSON
        dayOfWeek = '${dayOfWeek[0].toUpperCase()}${dayOfWeek.substring(1)}';
        var prices = package['prices'] as Map<String, dynamic>;
        var priceString = prices[dayOfWeek];

        if (priceString != null) {
          double priceForDay =
              double.tryParse(priceString.toString().replaceAll(',', '')) ??
                  0.0;
          setState(() {
            total = priceForDay * numberOfPassengers;
          });
        } else {
          setState(() {
            total = 0.0;
          });
        }
      }
    }
  }
Future<void> _showHotelSelectionModal(BuildContext context) async {
  String? selectedHotelTemp = selectedHotel;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Buscar hotel',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: _filterHotels,
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredHotels.length,
                itemBuilder: (BuildContext context, int index) {
  if (index < filteredHotels.length) {
    return ListTile(
      title: Text(filteredHotels[index]['title']),
      onTap: () {
        setState(() {
          selectedHotelTemp = filteredHotels[index]['title'];
        });
        Navigator.of(context).pop();
      },
    );
  } else {
    // Manejo de índice fuera de rango
    return SizedBox();
  }
},

              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    },
  );

  if (selectedHotelTemp != null) {
    setState(() {
      selectedHotel = selectedHotelTemp;
    });
  }
}


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isDateSelected = true;
        _calculateTotal();
        print(selectedPackage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(

        
        child: AnimationLimiter(
          
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 1375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 44.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                 Column(
                      children: [
                        Lottie.asset(
                          'assets/animacion/reserva.json',
                          fit: BoxFit.cover,
                          width: 200, // Establece el ancho deseado
                          height: 200, // Establece el alto deseado
                        ),
                      ],
                    ),
                    SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Card(
                    child: ListTile(
                      title: Text(isDateSelected
                          ? 'Fecha seleccionada: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'
                          : 'Selecciona una fecha'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                ),
                SizedBox(height: 26),
                Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                    child: ListTile(
                      title: Text('Número de Pasajeros'),
                      trailing: DropdownButton<int>(
                        value: numberOfPassengers,
                        onChanged: (int? newValue) {
                          setState(() {
                            numberOfPassengers = newValue ?? 1;
                            _calculateTotal();
                          });
                        },
                        items: List.generate(10, (index) => index + 1)
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 26),
                Padding(
                 padding: const EdgeInsets.only(left: 20, right: 20),        
              child: Card(
                    child: ListTile(
  title: Text('Seleccionar Paquete'),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      DropdownButton<String>(
        value: selectedPackage,
        onChanged: (String? newValue) {
          setState(() {
            selectedPackage = newValue;
            _calculateTotal();
          });
        },
        items: widget.packages
            .map<DropdownMenuItem<String>>((package) {
          return DropdownMenuItem<String>(
            value: package['name'],
            child: Text(package['name']),
          );
        }).toList(),
        hint: selectedPackage == null
            ? Text('Seleccione un paquete')
            : null,
      ),
      IconButton(
        icon: Icon(Icons.help_outline),
        onPressed: () => _showPackageDetails(context),
      ),
    ],
  ),
)

                  ),
                ),SizedBox(height: 26),
           // Reemplaza este Card por el botón de selección de hotel
_buildHotelSelectionButton(context),
SizedBox(height: 26),
             Card(
  child: DottedBorder(
    dashPattern: [8, 4], // Esto define el patrón del punto y el espacio
    strokeWidth: 2, // Esto define el grosor de la línea
    color: Colors.grey, // Esto define el color de la línea punteada
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Total: ',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '\$${total.toStringAsFixed(2)} ',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.green[700], // Un verde oscuro para el precio
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'MXN',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),
SizedBox(height: 26),

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
                      SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }Widget _buildHotelSelectionButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () => _showHotelSelectionModal(context),
    child: Text(selectedHotel ?? 'Seleccionar Hotel'),
  );
}
}
