import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReservationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> reservation;

  ReservationDetailsScreen({Key? key, required this.reservation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> costExtra = reservation['costExtra'] ?? {};
  ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Reserva',style: TextStyle(color: Colors.white),),
          backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildDetailCard('Nombre', reservation['nombre'], Icons.person),
            _buildDetailCard('Fecha', reservation['travel_date'], Icons.calendar_today),
            _buildDetailCard('Paquete', reservation['package'], Icons.card_giftcard),
            _buildDetailCard('Hotel', reservation['selectedHotel'], Icons.hotel),
            _buildDetailCard('Total', reservation['total']?.toString(), Icons.attach_money),
            _buildCostExtraSection(costExtra),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => generateAndShowPdf(context),
        child: Icon(Icons.print),
        tooltip: 'Generar Comprobante',
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

  Future<void> generateAndShowPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Detalles de la Reserva', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.Divider(),
              _buildPdfDetailSection('Nombre', reservation['nombre']),
              _buildPdfDetailSection('Fecha', reservation['travel_date']),
              _buildPdfDetailSection('Paquete', reservation['package']),
              _buildPdfDetailSection('Hotel', reservation['selectedHotel']),
              _buildPdfCostExtraSection(reservation['costExtra']),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget _buildPdfDetailSection(String title, String? value) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Expanded(child: pw.Text(value ?? 'No disponible', textAlign: pw.TextAlign.right)),
        ],
      ),
    );
  }

  pw.Widget _buildPdfCostExtraSection(Map<String, dynamic>? costExtra) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 5),
          child: pw.Text('Costos Extras:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        ),
        ...costExtra?.entries.map((entry) => _buildPdfDetailSection(entry.key, entry.value.toString())) ?? [],
      ],
    );
  }
}
