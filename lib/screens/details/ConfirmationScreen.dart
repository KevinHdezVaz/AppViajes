import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmationScreen extends StatefulWidget {
  final Map<String, dynamic> placeDetails;
  final List<Map<String, dynamic>> packages;
  final Map<String, dynamic> prices;
  final Map<String, dynamic> costExtra;

  ConfirmationScreen({
    Key? key,
    required this.placeDetails,
    required this.packages,
    required this.prices,
    required this.costExtra,
  }) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  int numberOfPassengers = 1;
  String selectedPackage = '';
  Map<String, dynamic> selectedExtraCosts = {};
  // Controladores para los nuevos campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companionsController = TextEditingController();
  late DateTime selectedDate;
  bool isDateSelected =
      false; // Añadir un flag para rastrear si la fecha ha sido seleccionada
  // ... resto de tus variables de estado

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // Fecha predeterminada
    selectedPackage = widget.packages.isNotEmpty
        ? widget.packages[0]['name']
        : ''; // Paquete predeterminado
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
        isDateSelected =
            true; // Actualizar el flag cuando se selecciona una fecha
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmar Reserva"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                isDateSelected
                    ? "Fecha del Viaje: ${DateFormat('dd/MM/yyyy').format(selectedDate)}"
                    : "Elige tu fecha del viaje", // Mostrar este texto si la fecha no ha sido seleccionada
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),

            Divider(),
            Card(
              child: ListTile(
                title: Text("Número de Pasajeros"),
                subtitle: DropdownButton<int>(
                  value: numberOfPassengers,
                  onChanged: (int? newValue) {
                    setState(() {
                      numberOfPassengers = newValue!;
                    });
                  },
                  items: <int>[1, 2, 3, 4, 5]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Campo de texto para el nombre completo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre Completo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre completo';
                  }
                  return null;
                },
              ),
            ),

         

            Divider(),

            Card(
              child: ListTile(
                title: Text("Seleccionar Paquete"),
                trailing: IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {
                    _showPackageDetails(context);
                  },
                ),
                subtitle: DropdownButton<String>(
                  value: selectedPackage,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPackage = newValue!;
                    });
                  },
                  items: widget.packages.map<DropdownMenuItem<String>>(
                      (Map<String, dynamic> package) {
                    return DropdownMenuItem<String>(
                      value: package['name'],
                      child: Text(package['name']),
                    );
                  }).toList(),
                ),
              ),
            ),

            Divider(),
            // Aquí puedes agregar una lógica similar para seleccionar costos extras
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para enviar la reserva
                },
                child: Text('Enviar Reserva'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPackageDetails(BuildContext context) {
    // Encuentra los precios del paquete seleccionado
    var packagePrices = widget.prices[selectedPackage];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Detalles de Precios - $selectedPackage"),
          content: SingleChildScrollView(
            child: packagePrices != null
                ? Column(
                    children: packagePrices.entries.map<Widget>((entry) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${entry.key}: ${entry.value}'),
                      );
                    }).toList(),
                  )
                : Text(
                    "No hay detalles de precios disponibles para este paquete."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
