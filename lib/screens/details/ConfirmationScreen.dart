import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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
        child: Column(
          children: [
            AnimationLimiter(
              child: Column(
                children: [
                Card(
                  child: AnimationConfiguration.staggeredList(
                    position:
                        0, // Esta posición es 0 ya que es un único elemento
                    duration: const Duration(milliseconds: 2375),
                    child: SlideAnimation(
                      verticalOffset:
                          50.0, // Ajusta el offset vertical si es necesario
                      child: FadeInAnimation(
                        child: ListTile(
                          title: Text(isDateSelected
                              ? 'Fecha seleccionada: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'
                              : 'Selecciona una fecha'),
                          trailing: Icon(Icons.calendar_today),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Card(
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
            Card(
              child: ListTile(
                title: Text('Seleccionar Paquete'),
                trailing: DropdownButton<String>(
                  value: selectedPackage,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPackage = newValue;
                      _calculateTotal();
                    });
                  },
                  items:
                      widget.packages.map<DropdownMenuItem<String>>((package) {
                    return DropdownMenuItem<String>(
                      value: package['name'],
                      child: Text(package['name']),
                    );
                  }).toList(),
                  hint: selectedPackage == null
                      ? Text('Seleccione un paquete')
                      : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Total: \$${total.toStringAsFixed(2)} MXN'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar lógica para guardar la reserva
              },
              child: Text('Confirmar Reserva'),
            ),
          ],
        ),
      ),
    );
  }
}
