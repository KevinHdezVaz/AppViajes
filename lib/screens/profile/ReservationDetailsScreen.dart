import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ReservationDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> reservation;

  ReservationDetailsScreen({Key? key, required this.reservation})
      : super(key: key);

  @override
  _ReservationDetailsScreenState createState() =>
      _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  late ScreenshotController screenshotController;

  @override
  void initState() {
    super.initState();
    screenshotController = ScreenshotController();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> costExtra = widget.reservation['costExtra'] ?? {};
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de la Reserva',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            margin: EdgeInsets.zero,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Image(image: AssetImage('assets/images/arriba.png')),
                ),
                _buildDetailCard('ID', widget.reservation['id'].toString(),
                    Icons.phone_iphone_outlined),
                _buildDetailCard(
                    'Nombre', widget.reservation['nombre'], Icons.person),
                _buildDetailCard('Fecha de reserva',
                    widget.reservation['travel_date'], Icons.calendar_today),
                _buildDetailCard('Paquete', widget.reservation['package'],
                    Icons.card_giftcard),
                _buildDetailCard(
                    'Hotel', widget.reservation['selectedHotel'], Icons.hotel),
                _buildDetailCard(
                    'Total',
                    widget.reservation['total']?.toString(),
                    Icons.attach_money),
                _buildDetailCard(
                    'Fecha en la que lo realizo',
                    widget.reservation['fechahoy']?.toString(),
                    Icons.calendar_month_rounded),
                _buildCostExtraSection(costExtra),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "OBSERVACIONES",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  style: TextStyle(fontSize: 10),
                  "DEBERA PRESENTAR ESTE CUPON IMPRESO O DIGITAL AL MOMENTO DEL PICK UP/CHECK IN PARA PODER ACCEDER AL SERVICIO PREVIAMENTE CONTRATADO Y SU IDENTIFICACIÓN.SI TIENE ALGUN BALANCE PENDIENTE DEBERA LIQUIDARLO DURANTE EL CHECK IN. PARA PROMOCIONES DEBERAN PRESENTAR UNA IDENTIFICACION QUE DEMUESTRE LA EDAD Y/O NACIONALIDAD DE LOS ADULTOS, MENORES E INFANTES PARA JUSTIFICAR EL PRECIO, DE LO CONTRARIO EL PROVEEDOR DEL SERVICIO PODRA COBRARLE LA DIFERENCI DEL TICKET SIN PROMOCIÓN. SE LE RECOMIENDA ESTAR PRESENTE EN EL LOBBY DEL HOTEL O EL PUNTO DE ENCUENTRO 5 MINUTOS ANTES PARA REALIZAR EL CHECK IN. EN CASO DE NO PRESENTARSE SE TOMARA COMO NO SHOW Y NO SE REALIZARA LA DEVOLUCIÓN DEL MONTO PAGADO, SE RE-AGENDARA CONFORME A LAS POLITICAS ESTABLECIDAS POR EL PROVEEDOR DEL SERVICIO.",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "CANCELACIONES",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  style: TextStyle(fontSize: 10),
                  "TODA CANCELACIÓN SE DEBERA HACER CON 24 HORAS DE ANTICIPACIÓN A LA ACTIVIDAD, DE LO CONTRARIO NO SE HARA CANCELACIÓN Y PODRA HABER UN CARGO CONFORME A LAS POLITICAS DEL PROVEEDOR DEL SERVICIO TURISTICO. PARA RESERVAS ADQUIRIDAS CON PROMOCIONES, DESCUENTOS O PAQUETES NO HAY CANCELACIONES NI DEVOLUCIONES.",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "DUDAS O ACLARACIONES",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  style: TextStyle(fontSize: 10),
                  "PUEDE CONTACTARNOS MEDIANTE WHATSAPP PARA CUALQUIER DUDA O ACLARACIÓN RESPECTO A SU RESERVACIÓN O CUALQUIER COMENTARIO RESPECTO AL SERVICIO.",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "WHATSAPP: (+52) 9983706776",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Image(image: AssetImage('assets/images/footer.png')),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => captureAndSaveScreenshot(context),
        child: Icon(Icons.camera_alt),
        tooltip: 'Tomar y Guardar Captura',
      ),
    );
  }

  Widget _buildDetailCard(String title, String? value, IconData icon) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value ?? 'No disponible'),
      ),
    );
  }

  Widget _buildCostExtraSection(Map<String, dynamic> costExtra) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          'Costos Extras',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: costExtra.entries
              .map((entry) => Text('${entry.key}: \$${entry.value}'))
              .toList(),
        ),
      ),
    );
  }

  void captureAndSaveScreenshot(BuildContext context) async {
    Uint8List? imageBytes = await screenshotController.capture();

    if (imageBytes != null) {
      final directory = await getExternalStorageDirectory();

      // Verificar si se obtuvo el directorio externo
      if (directory != null) {
        final downloadsDirectory = Directory('${directory.path}/Download');

        // Crear la carpeta "Download" si no existe
        if (!await downloadsDirectory.exists()) {
          await downloadsDirectory.create(recursive: true);
        }

        final filePath = '${downloadsDirectory.path}/screenshot.png';

        await File(filePath).writeAsBytes(imageBytes);

        final result = await ImageGallerySaver.saveFile(filePath);
        print("Imagen guardada en: $result");

        // Abrir el archivo en el explorador de archivos
        OpenFile.open(filePath);

        Fluttertoast.showToast(
            msg: 'Comprobante guardado en tu carpeta de Descargas');
      } else {
        print("Error al obtener el directorio externo");
      }
    } else {
      // Manejar el caso cuando la captura de pantalla falla
      print("Error al capturar la pantalla");
    }
  }
}
