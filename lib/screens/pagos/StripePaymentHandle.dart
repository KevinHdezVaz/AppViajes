import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;

  Future<bool> stripeMakePayment(String valor) async {
    try {
      paymentIntent = await createPaymentIntent(valor, 'MXN');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  billingDetails: BillingDetails(
                      name: 'YOUR NAME',
                      email: 'kevinhdezvaz@gmail.com',
                      phone: 'YOUR NUMBER',
                      address: Address(
                          city: 'YOUR CITY',
                          country: 'YOUR COUNTRY',
                          line1: 'YOUR ADDRESS 1',
                          line2: 'YOUR ADDRESS 2',
                          postalCode: 'YOUR PINCODE',
                          state: 'YOUR STATE')),
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      //  displayPaymentSheet();

      // Intenta mostrar el sheet de pago y retorna verdadero si tiene éxito
      await Stripe.instance.presentPaymentSheet();
      return true; // Pago exitoso
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
      return false; // Pago fallido o cancelado
    }
  }

  displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      // Notifica al usuario que el pago se completó con éxito
      Fluttertoast.showToast(msg: 'Pago realizado con éxito');

      
    } on Exception catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
            msg: 'Error de Stripe: ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Error no previsto: ${e}');
      }
      // Lanza una excepción para que el bloque catch de makeReservation se ejecute
      throw e;
    }
  }

//create Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//calculate Amount
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
