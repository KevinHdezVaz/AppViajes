import 'package:appviajes/models/SpotData.dart';
import 'package:appviajes/screens/pagos/StripePaymentHandle.dart';
import 'package:appviajes/services/Api/apiRest.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationScreen extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> packages;
  final Map<String, dynamic> costExtra;

  ConfirmationScreen(
      {Key? key,
      required this.title,
      required this.packages,
      required this.costExtra})
      : super(key: key);

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
  String? selectedCostExtraKey;
  final TextEditingController _nombreController = TextEditingController();
  String totalForStripe ="";
  final List<Map<String, dynamic>> hotels =
      SpotData.listaHoteles["Hotel"] ?? [];


final TextEditingController _cityController = TextEditingController();
final TextEditingController _countryController = TextEditingController();
final TextEditingController _postalCodeController = TextEditingController();
final TextEditingController _stateController = TextEditingController();
// ... otros controladores que necesites ...


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nombreController.dispose();
  }

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
    if (widget.costExtra.isNotEmpty) {
      selectedCostExtraKey = widget.costExtra.keys.first;
    }
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

  bool _validateInputs() {
      // Verifica si todos los campos requeridos han sido seleccionados
  if (!isDateSelected ||
      selectedPackage == null ||
      selectedHotel == null ||
      numberOfPassengers <= 0) {
    return false;
  }

  // Verifica si el campo del nombre no está vacío y cumple con los criterios básicos
  String nombre = _nombreController.text.trim(); // Elimina espacios en blanco al inicio y al final
  if (nombre.isEmpty) {
    return false;
  }
  
  return true;
       
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
        dayOfWeek = '${dayOfWeek[0].toUpperCase()}${dayOfWeek.substring(1)}';
        var prices = package['prices'] as Map<String, dynamic>;
        var priceString = prices[dayOfWeek];

        if (priceString != null) {
          double priceForDay =
              double.tryParse(priceString.toString().replaceAll(',', '')) ??
                  0.0;
          double extraCost = 0.0;
          if (selectedCostExtraKey != null &&
              widget.costExtra.containsKey(selectedCostExtraKey)) {
            extraCost = double.tryParse(widget.costExtra[selectedCostExtraKey]
                    .toString()
                    .replaceAll(',', '')) ??
                0.0;
          }
          String? extraCostString =
              widget.costExtra[selectedCostExtraKey]?.toString();
          if (extraCostString != null) {
            // Eliminar caracteres no numéricos
            extraCostString =
                extraCostString.replaceAll(RegExp(r'[^0-9.]'), '');
            extraCost = double.tryParse(extraCostString) ?? 0.0;
          }

          // Impresiones para depuración
          print('Precio por día: $priceForDay');
          print('Costo extra seleccionado: $selectedCostExtraKey');
          print('Valor del costo extra: $extraCost');

          setState(() {
  total = (priceForDay * numberOfPassengers) + extraCost;
  // Redondear al entero más cercano y convertir a String para Stripe
    totalForStripe = (total).round().toString();
  print('Total calculado: $total'); // Impresión para depuración
  print('Total para Stripe (en centavos): $totalForStripe'); // Impresión para depuración
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
              duration: const Duration(milliseconds: 800),
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
                    child: TextFormField(
                      controller: _nombreController,

                      decoration: InputDecoration(
                        labelText: 'Nombre Completo', 
                      enabledBorder: InputBorder.none, // Esto quita la línea cuando el TextField no está en foco.
    focusedBorder: InputBorder.none, // Esto quita la línea cuando el TextField está en foco.
    contentPadding: EdgeInsets.only(left: 10), // Añade algo de relleno dentro del TextField. 
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor introduce tu nombre completo';
                        }
                        return null; // Si el valor pasado es válido, devuelve null
                      },
                    ),
                  ),
                ),
      
                SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Card(
                    child: ListTile(
                      title: Text(isDateSelected
                          ? 'Fecha seleccionada: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'
                          : 'Selecciona una fecha'),
                      trailing: isDateSelected
                          ? Icon(Icons.check, color: Colors.green)
                          : Icon(Icons.calendar_today),
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownButton<int>(
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
                          // Ícono de verificación que se muestra solo cuando el número de pasajeros es seleccionado
                          if (numberOfPassengers >
                              0) // Asumiendo que 1 es el valor predeterminado y mínimo
                            Icon(Icons.check, color: Colors.green),
                        ],
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
                          // Botón de ayuda para mostrar detalles
                          IconButton(
                            icon: Icon(Icons.help_outline),
                            onPressed: () => _showPackageDetails(context),
                          ),
                          // Ícono de verificación que se muestra solo cuando un paquete es seleccionado
                          if (selectedPackage != null)
                            Icon(Icons.check, color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 26),

                if (widget.costExtra.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Card(
                      child: ListTile(
                        title: Text('Costos Extras'),
                        trailing: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width *
                                  0.4), // Ajusta el 0.3 según sea necesario
                          child: Row(
                            mainAxisSize: MainAxisSize
                                .min, // Importante para que se tome el mínimo espacio necesario
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  isExpanded:
                                      true, // Importante para evitar el desbordamiento
                                  value: selectedCostExtraKey,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCostExtraKey = newValue;
                                      _calculateTotal();
                                    });
                                  },
                                  items: widget.costExtra.keys
                                      .map<DropdownMenuItem<String>>(
                                          (String key) {
                                    return DropdownMenuItem<String>(
                                      value: key,
                                      child: Text(key +
                                          ' - ' +
                                          widget.costExtra[key].toString()),
                                    );
                                  }).toList(),
                                ),
                              ),
                              if (selectedCostExtraKey != null)
                                Icon(Icons.check, color: Colors.green),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 26),
                // Reemplaza este Card por el botón de selección de hotel
                _buildHotelSelectionButton(context),
                SizedBox(height: 26),
                Card(
                  child: DottedBorder(
                    dashPattern: [
                      8,
                      4
                    ], // Esto define el patrón del punto y el espacio
                    strokeWidth: 2, // Esto define el grosor de la línea
                    color: Colors
                        .grey, // Esto define el color de la línea punteada
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
                                color: Colors.green[
                                    700], // Un verde oscuro para el precio
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
                       // _sendReservationData();
                    //  makeReservation();
                          _showPaymentDetailsDialog();
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
  }

  Widget _buildHotelSelectionButton(BuildContext context) {
    return SizedBox(
      width:
          300, // O puedes poner un ancho fijo, por ejemplo 300.0 para 300 píxeles de ancho
      child: ElevatedButton.icon(
        icon: selectedHotel != null
            ? Icon(Icons.check,
                color: Colors
                    .green) // Muestra la palomita si hay un hotel seleccionado
            : Container(), // Un contenedor vacío si no hay hotel seleccionado
        label:
            Text(selectedHotel ?? 'Selecciona tu hotel'), // El texto del botón
        onPressed: () => _showHotelSelectionModal(context),
      ),
    );
  }

  final StripePaymentHandle stripePaymentHandle = StripePaymentHandle();

 void  makeReservation() async {
    // ... lógica para crear una reserva

    try {
//      await stripePaymentHandle.stripeMakePayment(totalForStripe); 
await stripePaymentHandle.stripeMakePayment(
    totalForStripe, // Valor
    'John Doe', // Nombre
    'johndoe@example.com', // Email
    '1234567890', // Teléfono
    'Ciudad', // Ciudad
    'País', // País
    'Calle 123', // Linea 1
    'Departamento 2', // Linea 2
    '12345', // Código Postal
    'Estado' // Estado
);

     
    } catch (e) {
      // Manejo de errores
      print('Error al realizar el pago: $e');
    }
  }
Future<void> _showPaymentDetailsDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // El usuario debe tocar el botón para cerrar el diálogo
        builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Detalles de Pago'),
                content: SingleChildScrollView(
                    child: ListBody(
                        children: <Widget>[
                            TextFormField(
                                controller: _cityController,
                                decoration: InputDecoration(hintText: 'Ciudad'),
                            ),
                            TextFormField(
                                controller: _countryController,
                                decoration: InputDecoration(hintText: 'País'),
                            ),
                            TextFormField(
                                controller: _postalCodeController,
                                decoration: InputDecoration(hintText: 'Código Postal'),
                            ),
                            TextFormField(
                                controller: _stateController,
                                decoration: InputDecoration(hintText: 'Estado/Provincia'),
                            ),
                            // ... otros campos de texto según sea necesario ...
                        ],
                    ),
                ),
                actions: <Widget>[
                    TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                            Navigator.of(context).pop();
                        },
                    ),
                    TextButton(
                        child: Text('Confirmar'),
                        onPressed: () {
                            // Aquí puedes llamar a la función para procesar el pago
                          //  _processPayment();
                        },
                    ),
                ],
            );
        },
    );
}


  Future<void> _sendReservationData() async {
    if (!_validateInputs()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Por favor, completa todos los campos requeridos")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');

    print(authToken);
    if (authToken == null) {
      // authToken es null, maneja este caso aquí
      // Por ejemplo, puedes redirigir al usuario a la pantalla de inicio de sesión
      throw Exception('No se encontró el token de autenticación');
    }
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    var costExtraValue = widget.costExtra[selectedCostExtraKey];
// Usamos RegExp para extraer solo los números (y punto decimal) de la cadena
    var numericValue =
        RegExp(r'(\d+(\.\d+)?)').firstMatch(costExtraValue)?.group(1) ?? '0';

    Map<String, dynamic> reservationData = {
      'nombre':_nombreController.text,
      'title':widget.title,
      'travel_date': formattedDate,
      'number_of_passengers': numberOfPassengers,
      'package': selectedPackage,
      'selectedHotel': selectedHotel.toString(),
      'total': total,
      'costExtra': selectedCostExtraKey != null
          ? {selectedCostExtraKey: double.parse(numericValue)}
          : {},
    };

    // Enviar los datos de la reserva
    try {
      ApiRest api = ApiRest();
      var response = await api.sendReservation(reservationData, authToken);

      print(reservationData);
      print(authToken);
      if (response.statusCode == 200) {
        print('Reserva enviada con éxito');
        // Realiza acciones después del éxito, como navegar a otra pantalla
      } else {
        print('Error al enviar la reserva: ${response.body}');
        // Muestra un mensaje de error
      }
    } catch (e) {
      print('Error al enviar la reserva: $e');
      // Maneja el error, por ejemplo, mostrando un mensaje al usuario
    }
  }
}
