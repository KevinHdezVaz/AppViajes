import 'package:flutter/material.dart';

class BestNatureList extends StatelessWidget {
  final String category;
  final String subcategoryFilter;
  final void Function(Map<String, dynamic>) onCardTap;

  // En el constructor:
  BestNatureList({
    required this.category,
    required this.subcategoryFilter,
    required this.onCardTap,
  });

  final Map<String, List<Map<String, dynamic>>> categorySpots = {
    'Antros': [
      {
        'title': 'Coco Bongo',
        'location': 'Cancún',
        'openingTime': '9 P.M.',
        'closingTime': '3 A.M.',
        'transportation': 'Transportación a partir de 10 pax',
        'prices': {
          'Regular': {
            'Lunes a Miércoles': '1,462 MXN',
            'Jueves a Domingo': '1,921 MXN'
          },
          'Premium': {
            'Lunes a Miércoles': '2,040 MXN',
            'Jueves a Domingo': '2,414 MXN'
          },
          'Gold Member': {
            'Domingo a Jueves': '2,635 MXN',
            'Viernes y Sábado': '2,805 MXN'
          },
          'Front Row': {
            'Domingo a Jueves': '3,094 MXN',
            'Viernes y Sábado': '3,400 MXN'
          },
          'Royal Service': {
            'Domingo a Jueves': '2,890 MXN',
            'Viernes y Sábado': '3,060 MXN'
          }
        },
        'images': [
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/124763274_10157208842885518_7433031921927152722_n.webp?alt=media&token=4ee1cdba-f16c-4040-8cbb-5d6ec5462ed7',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/104886997_10156896177275518_2090329408425446882_n.webp?alt=media&token=17ddb785-b84c-4d9c-9ed4-6577b80af3bf',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/141556653_10157357884735518_1871535725346435169_n.webp?alt=media&token=ae1f3c04-2d3e-43fc-a449-4e72cf6ce42f',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/153456938_1517571895098416_7593285690897993908_n.webp?alt=media&token=685afbc9-4816-4cf2-a215-3acd2792a54b',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/260648584_10157933062195518_8165599518837341972_n.webp?alt=media&token=43572a69-f4c3-4099-9cb4-2c5965e79766' // Más URLs de imágenes
              'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/78E2CCA9-038F-40C1-987A-AE643B92677D.webp?alt=media&token=b1825ffa-ca69-4e13-8148-13028c7be215',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/keFDOMJkadcuq1DDTr6kG9MmN6e0lY0FtmydidHtiWw.webp?alt=media&token=33120952-4d23-42cf-86cb-cbae309150d4',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/288943353_10158240286420518_8744241909549550617_n.webp?alt=media&token=587586f9-f42d-4199-aec8-58693891f0e4',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/292595212_10158268655385518_7920150126779706035_n.webp?alt=media&token=b63fb308-b18a-4b28-affa-76fec0bbaafa',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/277370982_10158108946080518_6499027682268836923_n.webp?alt=media&token=1c32aa75-fbab-446f-abe6-7f0bd5c003b5',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/325662283_3401498136748545_2658967673686187311_n.webp?alt=media&token=847ccc22-1b14-48b2-b727-02568dd279c6',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/331521956_1359002168195191_1043021015544088408_n.webp?alt=media&token=b57395c0-5daa-4203-9022-0e6bb79c8a2b'
        ],
        'subcategory': 'Most viewed',
        'packages': [
          {
            'name': 'Regular',
            'details': ['Acceso regular', 'Barra libre nacional', 'Shows']
          },
          {
            'name': 'Premium',
            'details': ['Acceso regular', 'Barra libre premium', 'Shows']
          },
          {
            'name': 'Gold Member',
            'details': [
              'Acceso prioritario',
              'Barra libre Premium',
              "Snack's",
              'Asiento (se asigna a la llegada)',
              'Servicio de mesero',
              "Show's"
            ]
          },
          {
            'name': 'Front Row',
            'details': [
              'Acceso prioritario',
              'Barra libre Premium',
              "Snack's",
              'Asiento (reservado)',
              'Servicio de mesero',
              "Show's"
            ]
          },
          {
            'name': 'Royal Service',
            'details': [
              'Acceso prioritario',
              'Servicio de botellas ilimitado (menú Premium)',
              'Mesa',
              'Servicio de mesero',
              "Show's"
            ]
          },
        ],
      },
      {
        'title': 'High Flyers',
        'location': 'Stratosphere',
        'price': '149.00',
        'images': [
          'assets/onboarding/illustration2.png',
          'assets/onboarding/illustration3.png',
          // Añade más imágenes según sea necesario
        ],
        'subcategory': 'Most viewed',
      },
      {
        'title': 'High Flyers',
        'location': 'Stratosphere',
        'price': '149.00',
        'images': [
          'assets/onboarding/illustration2.png',
          'assets/onboarding/illustration3.png',
          // Añade más imágenes según sea necesario
        ],
        'subcategory': 'Most viewed',
      },
      {
        'title': 'High Flyers',
        'location': 'Stratosphere',
        'price': '149.00',
        'images': [
          'assets/onboarding/illustration2.png',
          'assets/onboarding/illustration3.png',
          // Añade más imágenes según sea necesario
        ],
        'subcategory': 'Recommend',
      },
      // Añade más lugares relacionados con vuelos aquí...
    ],
    'Hotel': [
      {
        "title": "Luxury Stay",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "Ocean View Rooms",
        "location": "Beachside",
        "price": "399.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Recommend"
      },
      {
        "title": "ADHARA HACIENDA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "ALL RITMO CANCUN RESORT & WATERPARK",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "AQUAMARINA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "ATELIER",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "BEACH PALACE",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "BEACHSCAPE KINHA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "BELOVED",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "BREATHLESS CANCUN SOUL",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "CANCUN BAY RESORT",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "CANOPY BY HILTON CANCUN LA ISLA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "CASA MAYA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "CATALONIA COSTA MUJERES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "CITY EXPRESS PLUS CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "CLUB REGINA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "COMFORT INN CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "CORAL MAR",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "CROWN PARADISE CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "CYAN RESORT & SPA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "DOS PLAYAS",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "DREAMS PLAYA MUJERES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "DREAMS SANDS RESORT & SPA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "DREAMS VISTA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "EMPORIO FAMILY SUITES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "EXCELLENCE PLAYA MUJERES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "FIESTA AMERICANA CORAL BEACH",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "FIESTA AMERICANA CONDESA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "FIESTA AMERICANA VILLAS CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "FINEST PLAYA MUJERES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "FLAMINGO CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "FOUR POINTS BY SHERATON CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "GARZA BLANCA RESORT & SPA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "GOLDEN PARNASSUS RESORT & SPA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "GR SOLARIS",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "GRAND OASIS FASE 3",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "GRAND PARK ROYAL CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "HARD ROCK HOTEL CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "HILTON CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "HILTON CANCUN MAR CARIBE",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "HOSTEL AGUA Y FUEGO",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "HOTEL CANCUN PLAZA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "HOTEL CLUB MED CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "HOTEL RENAISSANCE CANCUN RESORT & MARINA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "HYATT ZILARA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "HYATT ZIVA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "IBEROSTAR CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "IMPERIAL LAS PERLAS",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "JW MARRIOT",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "KEMPINSKI CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "KRYSTAL ALTITUDE",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "KRYSTAL CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "KRYSTAL URBAN CENTRO",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "LAGUNA SUITES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "LE BLANC",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "LIVE AQUA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "MAJESTIC ELEGANCE COSTA MUJERES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "MARRIOTT COURTYARD",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "MELODY MAKER",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "MOON PALACE",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "MOON PALACE NIZUC",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "MOON PALACE SUNRISE",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "NIZUC RESORT & SPA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "NOW EMERALD CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "NYX CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "OASIS PALM BEACH",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "OASIS SMART",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "OCCIDENTAL COSTA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "OCCIDENTAL TUCANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "OCEAN HOTEL & SPA",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "OCEAN VIEW CANCUN ARENAS",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "OLEO CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "PALLADIUM COSTA MUJERES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "PARADISUS CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "PARK ROYAL CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "PLANET HOLLYWOOD BEACH RESORT CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "PRESIDENTE INTER-CONTINENTAL",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "REAL INN CANCUN BY CAMINO REAL",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "RIU CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "RIU CARIBE",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "RIU DUNAMAR",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "RIU LATINO",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "RIU COSTA MUJERES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "RIU KUKULKAN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "RIU LAS AMERICAS",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "RIU PENINSULA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "ROYAL ISLANDER",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "ROYAL SANDS",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "ROYAL SOLARIS",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "ROYALRON CHICS SUITES CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "ROYALTON SPLASH CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "SANDOS CANCUN LIFESTYLE RESORT",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "SEADUST CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "SECRETS PLAYA MUJERES",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "SECRETS THE VINE CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "SOLYMAR",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "SUITES BRISAS",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "SUN PALACE",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "SUNSET MARINA RESORT",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "SUNSET ROYAL BEACH RESORT",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "TEMPTATION",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "THE ROYAL CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "THE WESTIN RESORT & SPA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "TRS CORAL",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "VILLAS DEL PALMAR",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "WALDORF ASTORIA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "WESTIN LAGUNAMAR OCEAN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "WYNDHAM ALLTRA CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      },
      {
        "title": "WYNDHAM GARDEN CANCUN",
        "location": "Dreamland",
        "price": "299.00",
        "images": [
          "assets/onboarding/illustration2.png",
          "assets/onboarding/illustration3.png"
        ],
        "subcategory": "Most viewed"
      }
// Fin de la lista de hoteles
    ],

    'Bus': [
      {
        'title': 'Scenic Bus Tour',
        'location': 'Countryside',
        'price': '49.00',
        'images': [
          'assets/onboarding/illustration2.png',
          'assets/onboarding/illustration3.png',
          // Añade más imágenes según sea necesario
        ],
        'subcategory': 'Most viewed',
      },
      {
        'title': 'City Explorers',
        'location': 'Urban Center',
        'price': '59.00',
        'images': [
          'assets/onboarding/illustration2.png',
          'assets/onboarding/illustration3.png',
          // Añade más imágenes según sea necesario
        ],
        'subcategory': 'Recommend',
      },
      // Añade más lugares relacionados con autobuses aquí...
    ],
    // ... más categorías
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> natureSpots = categorySpots[category] ?? [];

    List<Map<String, dynamic>> filteredSpots;
    if (subcategoryFilter == 'All') {
      // No filtrar si la subcategoría es 'All', simplemente usar todos los spots
      filteredSpots = natureSpots;
    } else {
      // Filtrar por la subcategoría específica
      filteredSpots = natureSpots.where((spot) {
        return spot['subcategory'] == subcategoryFilter;
      }).toList();
    }

    return Container(
      height: 350, // Ajusta la altura según sea necesario
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredSpots.length,
        itemBuilder: (BuildContext context, int index) {
          var spot = filteredSpots[index];
          return Container(
            width: 180, // Ajusta el ancho según sea necesario
            margin: EdgeInsets.only(
              left: index == 0 ? 20 : 10,
              right: 10,
              top: 10,
              bottom: 10,
            ), // Añade margen alrededor de la tarjeta
            child: GestureDetector(
              onTap: () => onCardTap(spot),
              child: Card(
                elevation: 4.0,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            spot['images'][
                                0], // Esto seleccionará la primera imagen de la lista
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spot['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 16, color: Colors.red),
                              Text(
                                spot['location'],
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${spot['price']} /person',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
