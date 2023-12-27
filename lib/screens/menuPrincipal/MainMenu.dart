import 'package:appviajes/screens/details/PlaceDetailsScreen.dart';
import 'package:appviajes/screens/explorar/ExploreScreen.dart';
import 'package:appviajes/screens/menuPrincipal/DiscoverSreen.dart';
import 'package:appviajes/screens/profile/ProfileScreen.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

final Map<String, List<Map<String, dynamic>>> categorySpots = {
   'Antros': [
      {
        'title': 'Coco Bongo',
        'location': 'Cancún',
        'openingTime': '9 P.M.',
        'latitud':20.6275,
        'longitud': -87.0811,
        'precio': '1,462',
        'image_price':"assets/images/cocobongo_precio.png",
         
        'cost_extra': {
          
            'Ninguno': '',
            
          
         
        },
         'nota': 'Transportación a partir de 10 pax', 
        'detalles':
            'La disco más popular de México con proyecciones en pantallas gigantes y shows de acróbatas impactantes.\n\nUbicado justo en el corazón de la Zona Hotelera, Coco Bongo Cancún destaca entre decenas de bares y discotecas que forman la capital de la fiesta en México.\n\nA tan sólo una calle del majestuoso Mar Caribe, emerge un coloso espectacular indicando a los viajeros la llegada a la noche más impactante de sus vidas.',
        'closingTime': '3 A.M.',
        'transportation': 'Transportación a partir de 10 pax',
        'prices': {
          'Regular': {
            'Lunes a Miércoles': '1,462 ',
            'Jueves a Domingo': '1,921 '
          },
          'Premium': {
            'Lunes a Miércoles': '2,040 ',
            'Jueves a Domingo': '2,414 '
          },
          'Gold Member': {
            'Domingo a Jueves': '2,635 ',
            'Viernes y Sábado': '2,805 '
          },
          'Front Row': {
            'Domingo a Jueves': '3,094 ',
            'Viernes y Sábado': '3,400 '
          },
          'Royal Service': {
            'Domingo a Jueves': '2,890 ',
            'Viernes y Sábado': '3,060 '
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
        'title': 'Beach Party Coco Bongo',
        'location': 'Cancún',
        'openingTime': '9 P.M.',
        'precio': '595',
        'closingTime': '3 A.M.',
        'latitud':21.132413582407267,
        'longitud': -86.74684188334079,
        'image_price':"assets/images/beach_cocobongo.png",
        'cost_extra': {
            'Ninguno': '', 
        },
         'nota': 'Transportación a partir de 10 pax', 
        'detalles':
            'Durante tu estancia en Cancún debes visitar Coco Bongo Beach Party, ¡la mejor experiencia en Beach Party con una impresionante vista al mar Caribe! ¡Ninguna otra fiesta será suficiente después de vivir esta emocionante experiencia!\n\nVen y descubre el más imponente Beach Party hecho en México que emerge frente a las aguas cristalinas del majestuoso Mar Caribe y su arena blanca, dando vida a una fiesta interminable de sol, colores y ritmos frescos que robarán el aliento de todos.\n\nEntretenimiento de alto impacto, un mega desfile de tecnología, acrobacias y números nunca antes vistos en una escenario de este tipo te estarán esperando. ¡Conoce una nueva experiencia de entretenimiento en Latinoamérica!',
        'transportation': 'Transportación a partir de 10 pax',
        'prices': {
          'Todos los dias': {
            'Ladies': '595 ',
            'Regular': '935 ',
            'Premium': '1,445  ',
            'Celebrity': '2,040 ',
            'Bottle Pack': '4,080  ',
          },
        },
        'images': [
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Coco%20Bongo%20Beach.webp?alt=media&token=1eb3dac4-431d-4409-8558-af8834ed6dd4',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/274479936_296912162507169_1862556493175755358_n.webp?alt=media&token=77e07f0b-5164-43fa-90de-f06a6e34f752',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/286953143_366685498863168_7006921262691112864_n.webp?alt=media&token=cbc3813c-578c-4ec8-a054-f54c2b83cbcc',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/278129920_325725972959121_39050200529810096_n.webp?alt=media&token=f10a59a0-87de-4f53-bb60-76a25d509e18',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/293691404_395787852619599_2152582235903090992_n.webp?alt=media&token=9fe3836f-2b71-4599-9574-8a4e1022074e',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/315303975_475910471274003_4802411455334766976_n.webp?alt=media&token=a4750d42-30d0-417f-9c3d-3af87fde78fc',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/315308614_475972364601147_4380450071053415190_n.webp?alt=media&token=66f8e171-a0af-4e7b-a95a-55424a15f9cb',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/292595212_10158268655385518_7920150126779706035_n.webp?alt=media&token=b63fb308-b18a-4b28-affa-76fec0bbaafa',
        ],
        'subcategory': 'Most viewed',
        'packages': [
          {
            'name': 'Ladies',
            'details': ['Acceso', 'Barra libre nacional']
          },
          {
            'name': 'Regular',
            'details': ['Acceso', 'Barra libre']
          },
          {
            'name': 'Premium',
            'details': [
              'Acceso',
              'Barra libre Premium',
              "Snack's ilimitados",
            ]
          },
          {
            'name': 'Celebrity',
            'details': [
              'Acceso',
              'Área reservada en palco',
              'Barra libre Premium',
              'Platillo de snacks p/p',
              'Toalla y locker',
            ]
          },
          {
            'name': 'Bottle Pack',
            'details': [
              '4 covers',
              'Botella del menú',
              '5 refrescos ó 2 jarras de jugo',
              'Mesa',
            ]
          },
        ],
      },
      {
        'title': 'Congo Bar',
        'location': 'Cancún',
 
        'openingTime': '9 P.M.',

        'latitud':21.133429920537235,
        'longitud': -86.74713098251176,
         'precio': '800',
         'image_price':"assets/images/congobar.png",
        'closingTime': '3 A.M.',
        'cost_extra': {
            'Ninguno': '', 
        },
         'nota': 'Transportación a partir de 10 pax', 
        'detalles':
            '¡Prepárate para disfrutar de una de las mejores noches de tu vida! Congo Bar se ha convertido en el favorito de locales y turistas en su visita a Cancún. \n\nTe sorprenderás con los espectáculos especiales que tenemos para ti con las Congo Girls y nuestros increíbles acróbatas, ¡así que prepara tu celular para tomar muchas fotos y videos! Nuestro dj te hará bailar y te invita a unirte a la conga con todos nuestros visitantes. ¿Estás listo?.',
        'transportation': 'Transportación a partir de 10 pax',
        'prices': {
          'Todos los dias': {
            'Regular': '800',
          },
        },
        'images': [
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/133765771_1344513839232959_4806847838900149772_n.jpg?alt=media&token=4452d218-3a83-40fa-a462-ed536cec681a',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/270038798_1051842945636699_8946132292583942847_n.jpg?alt=media&token=89867023-66cd-421c-a6c7-9025cdd63f9f',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/217547325_1480239508993724_4510065749995768282_n.jpg?alt=media&token=c9c7a175-f021-4b6f-b171-6360832f0cce',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/151805545_1381268228890853_2387354906786124528_n.jpg?alt=media&token=7e643465-978d-4b70-b19e-b85b623732fa',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/252095849_1558131281204546_7702102367856219740_n.jpg?alt=media&token=73d13757-7711-435a-8157-7e1b4c1ca88a',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/178614940_1428715184146157_3475934914331347154_n.jpg?alt=media&token=85a4a508-ba14-44c3-bbf4-1e19f019f31f',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/242805544_1530839743933700_5942285961030479663_n.jpg?alt=media&token=b8c579b8-2d1f-4f42-abdb-4b118f77d66a',
                 ],
        'subcategory': 'Most viewed',
        'packages': [
          {
            'name': 'Regular',
            'details': ['Acceso', 'Barra libre nacional']
          },
        ],
      },
       
    ],
    'Acuático': [
      {
        'title': 'Jungle Tour',
        'location': 'Cancún', 
        'latitud':21.12455832612029,
        'longitud': -86.75501261040323,
        'openingTime': '9 P.M.',
        'precio': '800',
        'image_price':"assets/images/jungle_price.png",
        'cost_extra': {
            'Impuesto de muelle': '360 MXN', 
        },
         'nota': 'Transportación a partir de 10 pax',
        'detalles':
            'Vive la adrenalina de manejar tu propio bote rápido hasta mar abierto donde realizarás snorkel y podrás observar la vida marina.',
        'closingTime': '3 A.M.',
        'transportation': 'Transportación a partir de 10 pax',
        'prices': {
          'Todos los dias': {
            'Jungle Tour Express': '800',
            'Jungle Tour Snorkel': '900'
          },
        },
        'images': [
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/52695076_2370076813024715_3573757770635149312_n.webp?alt=media&token=bfb5d082-1ff9-457a-9b5e-1a6f45fc476a',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/45216609_2196873137011751_991465884289597440_n.webp?alt=media&token=d59830d7-a695-46db-a89a-5f4bcb61b516',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/67479462_2622399794459081_7521081862417022976_n.webp?alt=media&token=6bc77d06-8468-441e-a263-8e9059cdfaad',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/65006547_2572370912795303_2992173410110406656_n%20(1).webp?alt=media&token=7de3bc21-dd8b-4b43-a72d-94df4018fef9',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/56426977_2434072083291854_2640201673426862080_n.webp?alt=media&token=8a8ba6b2-0b6a-4cf6-890f-f8b79eec1ed9',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/66472978_2595559923809735_436457999708454912_n.webp?alt=media&token=f5db2589-a4cd-4929-9149-8ec0bf226d4b',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/67146545_2606535812712146_7793198328727994368_n.webp?alt=media&token=458710da-1827-4f38-b2d6-afb964dc7276'
        ],
        'subcategory': 'Most viewed',
        'packages': [
          {
            'name': 'Jungle Tour Snorkel',
            'details': [
              'Guía bilingüe (español-inglés)',
              'Bote rápido (2-4 pax)',
              'Paseo en laguna Nichupte',
              'Snorkel en arrecife',
              'Botella de agua'
            ]
          },
        ],
      },
      {
        'title': 'Isla Mujeres',
        'location': 'Cancún',
        'openingTime': '9 P.M.',
          'precio': '1,100',
'latitud':21.23669926206936,
        'longitud': -86.73555932253596, 
        'image_price':"assets/images/islamujer.png",
         'cost_extra': {
            'Impuesto de muelle': '360 MXN', 
            'Transportación redonda': '190 MXN'
        },
         'nota': 'Transportación a partir de 10 pax', 
        'detalles':
            'Diviértete a bordo del catamarán con bebidas y fiesta ilimitada junto con tu familia o amigos. Margaritas, Sex in the beach, Tequila Sunrise, Cerveza, Jugos, Refrescos, etc. \nSumérgete en mar abierto y descubre la vida submarina en el museo sub-acuático MUSA. Peces, tortugas y corales te acompañarán en tu aventura acuática. \n\nAdemás realiza una visita exprés al centro de Isla Mujeres para conocer y comprar souvenirs. Relájate en el club de playa privado donde podrás disfrutar de un delicioso bufete y las comodidades como camastros, jugar voleyball, remar en canoas, fotos para tus redes sociales, servicio de mesero y más!!! \n\nPor si fuera poco, visita una de las playas más famosas de todo México "Playa Norte". Podrás caminar y nadar con toda tranquilidad hasta 40 metros y el agua te llegará hasta el pecho. \n\n\nVive la adrenalina en el Spinnaker al elevarte y tirarte de 20 metros de altura en mar abierto.',
        'closingTime': '3 A.M.',
        'transportation': 'Transportación a partir de 10 pax',
        'prices': {
          'Todos los dias': {
            'Clásico Adultos': '1,100 ',
            'Clásico Menores': '900 '
          },
          'Solo Domingos': {
            'Promo Nacionales': '900',
          },
        },
        'images': [
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/04%20-%20LoRes%20-%20Vista%20Cancun%20-%20Punta%20Sur-1.jpeg?alt=media&token=b539b51a-20a1-4851-b944-8fe3f2a5209b',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/01%20LoRes%20Party%20Models%20Cancun%20Sailing.jpeg?alt=media&token=aad0a5fd-ddb6-43a0-9007-a82f1c84c8e1',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/03%20-%20IXI%20Beach%20-%20LORES%20-%20Playa%20Norte%20Friends.jpeg?alt=media&token=c0b8667c-799e-42d4-9380-ad0415e1bda3',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/06%20-%20Beach%20club%20-%20Playa%20Mexico%20-%20Ice%20Bar%20Isla%20Mujeres%20-%20Beach%20girls.jpeg?alt=media&token=7b799362-2e81-460f-b698-ad6dae92a414',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/15%20-%20LoRes%20-%20Private%20Isla%20Mujeres%20tour%20in%20catamaran%20-%20Sea%20Passion%20I%20II%20-%20Cancun%20Sailing.jpg?alt=media&token=9eed3d8c-ee49-4e18-8c7d-cc81d7448552',
        ],
        'subcategory': 'Most viewed',
        'packages': [
          {
            'name': 'Clásico y Promo Nacionales',
            'details': [
              'Traslado en catamarán (ida y vuelta)',
              'Guía bilingüe (Español-Inglés)',
              'Barra libre',
              'Buffet',
              'Snorkel y equipo de snorkel',
              'Club de playa',
              'Tiempo libre en Isla Mujeres',
              'Spinnaker (si el clima lo permite)'
            ]
          },
        ],
      },
    ],
    'Cultural': [
      {
        'title': 'Chichen Itza',
        'location': 'Cancún',
        'openingTime': '9 P.M.',
      'cost_extra': {
            'Ninguno': '', 
             
        },
        'latitud':20.68432348897362,
        'longitud': -88.56779588670287,
         'precio': '1,200',
        'image_price':"assets/images/chichenitza.png",
      
        'detalles':
            'Descubre lo mejor de la cultura maya y aprende más sobre una de las 7 maravillas del mundo Chichén Itzá.\n\nNada y refréscate en un cenote. Cuenta la leyenda que las aguas del cenote tienen la propiedad de rejuvenecer 10 años a las personas y los mayas los consideraban la entrada al inframundo.Disfruta de un delicioso buffet con auténtica comida regional yucateca como cochinita pibil, sopa de lima, entre otros.\n\nVisita uno de los pueblos mágicos Valladolid .Todo esto a bordo de un autobús con A/A desde la comodidad de tu hotel y un guía bilingüe certificado que te llevará de la mano a conocer todos y cada uno de estos lugares.',
        'closingTime': '3 A.M.',
        
         'nota': 'Hora de recogida dependerá del hotel', 
        'transportation': 'Transportación a partir de 10 pax',
        'prices': {
          'Todos los dias': {
            'Clásico Adultos': '1,200',
            'Clásico Menores': '900',
            'Deluxe Adultos': '1,600',
            'Deluxe Menores': '1,100'
          },
          'Solo domingos': {
            'Promoción Mexicanos': '900',
          }
        },
        'images': [
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Fondo%207.jpg?alt=media&token=703b9906-3d9a-41d3-81bf-bb018e2106f1',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/52f37e41-1142-490e-acff-f93a8f53b8d3.jpg?alt=media&token=3fa5a7b3-d087-41c4-acd0-e7115e24a0ac',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/chichen-itza-private-tour-cancun-adventures-10_0.jpg?alt=media&token=6dfad5e3-5dcc-4abb-b7ad-5334aee57274',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/cenote_saamal.jpg?alt=media&token=d364d03f-64e7-4eb1-81b0-4cfe1709d1f0',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/87882576-16f9-481c-998d-bd5c966dcbe1.jpg?alt=media&token=3030e64f-b616-4142-a96a-2eadc03e4db0',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Chichen%20Itzá%2011.jpg?alt=media&token=666145fe-7cb3-44e2-850c-bfad5d569c83',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Chichen%20Itzá%2010.jpg?alt=media&token=fec2f030-e3a4-4de1-a398-19e90e8a23fd',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Chichen%20Itzá%2014%20(1).jpg?alt=media&token=c2b72f17-1fa4-404b-ba76-b30a24830d57',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Chichen%20Itzá%204.jpg?alt=media&token=93c25da2-a1ff-4c5e-9829-dc49f0447b87',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Chichen%20Itzá%203.jpg?alt=media&token=5e5d6128-d8d9-4935-bcb4-fa0b5b1ba20e',
        ],
        'subcategory': 'Most viewed',
        'packages': [
          {
            'name': 'Clásico',
            'details': [
              'Recogida en hotel',
              'Transportación redonda',
              'Guía certificado bilingüe (español-inglés)',
              'Buffet comida regional',
              'Entrada a zona arqueológica',
              'Visita guiada a la zona arqueológica',
              'Nado en cenote',
              'Tiempo para comprar artesanías'
            ]
          },
          {
            'name': 'Deluxe',
            'details': [
              'Recogida en hotel',
              'Transportación redonda',
              'Box lunch a bordo del autobús',
              'Bebidas a bordo del autobús',
              'Guía certificado bilingüe (español-inglés)',
              'Buffet comida regional',
              '2 bebidas no alcohólicas en restaurante',
              'Entrada a zona arqueológica',
              'Visita guiada a la zona arqueológica',
              'Nado en cenote',
              'Tiempo para comprar artesanías'
            ]
          },
          {
            'name': 'Promo Mexicanos',
            'details': [
              'Recogida en hotel',
              'Transportación redonda',
              'Guía certificado bilingüe (español-inglés)',
              'Buffet comida regional',
              'Entrada a zona arqueológica',
              'Visita guiada a la zona arqueológica',
              'Nado en cenote',
              'Tiempo para comprar artesanías'
            ]
          }
        ],
      },
      {
        'title': '4x1 (Tulum, Cobá, Cenote y Playa del Carmen)',
        'location': 'Cancún',
         'precio': '1,200',
        'openingTime': '9 P.M.', 
        'latitud':20.21152406491527,
        'longitud': -87.46516059163379,
         'image_price':"assets/images/chichenitza.png",
       'cost_extra': {
            'Ninguno': '', 
             
        },
         'nota': 'Hora de recogida dependerá del hotel', 
        'detalles':
            'En este fantástico tour "4x1" visita 4 atracciones turísticas en un solo día. Conoce acerca de la cultura maya en Tulum y tómate fotos en las pirámides que están frente al mar turquesa. \n\nDéjate sorprender por los 45 metros de altura de la pirámide "Nohoch Mool", donde sentirás la conexión con la naturaleza y la cultura maya. Podrás rentar una bicicleta para recorrer la zona arqueológica o un tricitaxi para transportarte.\n\nPara refrescarte nadaremos en un cenote subterráneo donde quedarás impresionado con las maravillas que la naturaleza crea.Además degustarás un exquisito buffet de comida regional yucateca como sopa de lima, cochinita pibil, papatzules, cotzitos, etc.\n\nTodo esto a bordo de un autobús de lujo con aire acondicionado y un guía bilingüe certificado que te llevará de la mano a todos y cada uno de los lugares',
        'closingTime': '3 A.M.',
        'transportation': 'Transportación a partir de 10 pax',
        'prices': {
          'Todos los dias': {
            'Clásico Adultos': '1,200',
            'Clásico Menores': '900',
            'Deluxe Adultos': '1,600',
            'Deluxe Menores': '1,100'
          },
          'Solo domingos': {
            'Promoción Mexicanos': '900',
          }
        },
        'images': [
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Tulúm%20%26%20Coba%206.jpg?alt=media&token=719e434e-a632-42a8-8b59-fc842d324f66',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/g9.jpg?alt=media&token=1b0378d5-991a-419a-8b8f-1dc5e9108fbf',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/12705shopping_playa_del_carmen.jpg?alt=media&token=92cb6663-4219-473a-9803-3411b5cfeba1',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/playa_del_carmen_shopping_5a_avenida_compras.jpg?alt=media&token=915ee114-eb32-4088-9e90-991514cc9a7f',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Tulúm%20%26%20Coba%2015.jpg?alt=media&token=7759da2a-a124-4c15-86f7-af3aeabd9ee3',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Tulúm%20%26%20Coba%2013.jpg?alt=media&token=3afa0cd5-d401-4f44-b407-e1ac1c4c342a',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Tulúm%20%26%20Coba%2014.jpg?alt=media&token=8ebb521e-17f1-4ec9-8fd6-3c604739d229',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Tulúm%20%26%20Coba%203.jpg?alt=media&token=f35ab0e9-3acb-44b2-b9d3-61758323257d',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/Tulúm%20%26%20Coba%204.jpg?alt=media&token=588bdc1e-7e8f-45a5-81ff-221416f573b9',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/cenote-multum-ha.jpg?alt=media&token=60f0df72-4a88-4d81-afef-3bc93f1ac701'
        ],
        'subcategory': 'Most viewed',
        "packages": [
          {
            "name": "Clásico",
            "details": [
              "Recogida en hotel o punto de encuentro",
              "Transportación redonda",
              "Buffet comida regional",
              "Guía certificado bilingüe (español-inglés)",
              "Entrada a zonas arqueológicas",
              "Visita guiada en zonas arqueológicas",
              "Nado en cenote",
              "Visita rápida a la 5ta avenida"
            ]
          },
          {
            "name": "Deluxe",
            "details": [
              "Recogida en hotel o punto de encuentro",
              "Transportación redonda",
              "Box lunch a bordo del autobús",
              "Bebidas a bordo del autobús",
              "Guía certificado bilingüe (español-inglés)",
              "Entrada a zonas arqueológicas",
              "Visita guiada en zonas arqueológicas",
              "Nado en cenote",
              "Visita rápida a la 5ta avenida",
              "Buffet comida regional",
              "2 bebidas no alcohólicas en restaurante"
            ]
          },
          {
            "name": "Promo Mexicanos",
            "details": [
              "Recogida en hotel o punto de encuentro",
              "Transportación redonda",
              "Guía certificado bilingüe (español-inglés)",
              "Entrada a zonas arqueológicas",
              "Visita guiada en zonas arqueológicas",
              "Nado en cenote",
              "Visita rápida a la 5ta avenida",
              "Buffet comida regional",
            ]
          }
        ]
      },
      // Añade más lugares relacionados con autobuses aquí...
    ],

    'Familiar': [
      {
        'title': 'Barco Pirata (Capitan Hook)',
        'location': 'Cancún',
        'openingTime': '9 P.M.',
         'precio': '1,520',
          'latitud':21.14406659165124,
        'longitud': -86.78627714437395,
         'image_price':"assets/images/barcopirata.png",

         'cost_extra': {
            'Impuesto de muelle': '360 MXN', 
               'Transportación redonda': '190 MXN',  
        },
         'nota': 'Promoción 2x1 en cena Vegetariana, Pollo a la parrilla y Corte New York', 
        'detalles':
            'Combinando la historia de la piratería con el lujo y tecnología moderna, nuestros Galeones están equipados con un sistema de audio, luz y video de última generación para un show nocturno espectacular en la cubierta principal. \n\nLa zona VIP ofrece vistas excelentes y atención personalizada, mientras que para cenar disponemos de salones climatizados temáticos.',
        'closingTime': '3 A.M.',
        'transportation': 'Transportación a partir de 10 pax',
        'prices': {
          'Todos los dias': {
            'Vegetariana': '1,520',
            'Pollo a la parrilla': '1,520',
            'Corte New York': '1,710',
            'Cola Langosta': '1,900',
            'Mar y Tierra': '2,090'
          },
        },
        'images': [
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/19510389_1487819887923243_5911242965986903971_n.jpg?alt=media&token=eed0994e-6170-4dee-80ac-9f37a44f05a6',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/IMG_9601.JPEG?alt=media&token=b5e9b62f-1ea8-4d98-8aa9-285e48070985',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/17265291_1385313024840597_8678676785998881291_n.jpg?alt=media&token=b7095b78-b483-4c14-a094-a2912a04e3a7',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/capitan_01.jpg?alt=media&token=3e4e26c5-b0ff-45cc-9e02-85b005182861',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/23244478_1609011075804123_2077710524911806048_n.jpg?alt=media&token=3cd63ba2-6a46-4272-86f2-a597155821f7',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/IMG_9596.JPEG?alt=media&token=35b230b7-aeea-4696-85d4-f4863b5d7e5c',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/IMG_9598.JPEG?alt=media&token=0e6579ae-97c1-4740-ab0b-f6b8a17b0216',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/IMG_9602.JPEG?alt=media&token=3c615623-61b8-4d4b-9687-42c6248aef54',
          'https://firebasestorage.googleapis.com/v0/b/app-49894.appspot.com/o/IMG_9599%20(1).JPEG?alt=media&token=2f313b77-1f91-407b-ae33-e7dab97bcbbe'
        ],
        'subcategory': 'Most viewed',
        'packages': [
          {
            'name': 'Normal',
            'details': [
              'Actividades',
              'Show"s',
              'Concursos',
              'Cena',
              'Entrada a zona arqueológica',
              'Barra libre',
              'Niños de 2 a 11 años GRATIS',
            ]
          },
        ],
      },
      
      // Añade más lugares relacionados con autobuses aquí...
    ],
};

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  // Define your widget options as screens for each tab.
  final List<Widget> _widgetOptions = [
    DiscoverScreen(),  
    ExploreScreen(categorySpots: categorySpots),  
    ProfileScreen(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: Center(
          child: _widgetOptions
              .elementAt(_selectedIndex), // Display the selected screen
        ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(218, 178, 70, 211),
        onTap: _onItemTapped,
      )    );
 
  }
}
