import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import '../providers/cart_provider.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Column(
        children: [
          Expanded(child: CartItemsList()),
          PaymentMethodSelection(),
        ],
      ),
    );
  }
}

class CartItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context); // ✅ Using correct CartProvider
    return ListView.builder(
      itemCount: cart.cartItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(cart.cartItems[index]["title"]),
        );
      },
    );
  }
}


class PaymentMethodSelection extends StatefulWidget {
  @override
  _PaymentMethodSelectionState createState() => _PaymentMethodSelectionState();
}

class _PaymentMethodSelectionState extends State<PaymentMethodSelection> {
  String? selectedPayment = 'Stripe';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          title: Text('Stripe'),
          value: 'Stripe',
          groupValue: selectedPayment,
          onChanged: (value) => setState(() => selectedPayment = value as String?),
        ),
        RadioListTile(
          title: Text('PayPal'),
          value: 'PayPal',
          groupValue: selectedPayment,
          onChanged: (value) => setState(() => selectedPayment = value as String?),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedPayment == 'Stripe') {
              processStripePayment();
            } else {
              processPayPalPayment(context);
            }
          },
          child: Text('Pay Now'),
        ),
      ],
    );
  }
}

void processStripePayment() {
  // Implement Stripe payment processing logic
}

void processPayPalPayment(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => UsePaypal(
        sandboxMode: true,
        clientId: "Ac0mDd89c4-tqZr5MeNm72b7o6wYNtc08John006fLbvxbHn0euSdbDgI336TGZdzXlaE7pwcEFB9eqF",
        secretKey: "EChJ5LUMVkqyj0RvbPW-W0bmfD48iqnX9K6Jge_tgTNtwPxLw7qtCxmPX9C9Jokle_g2cAcxDfS-Dxhc",
        returnURL: "http://localhost:3000/success", // Change for localhost testing
        cancelURL: "http://localhost:3000/cancel", // Change for localhost testing
        //returnURL: "myapp://payment-success",
        //cancelURL: "myapp://payment-cancel",
        transactions: [
          {
            "amount": {
              "total": '10.00',
              "currency": "USD",
            },
            "description": 'Purchase',
            "note_to_payer": 'Your purchase is successful. Thank you!'
          }
        ],
        onSuccess: (Map params) {
          print("Payment Success: $params");
        },
        onError: (error) {
          print("Payment Error: $error");
        },
        onCancel: () {
          print("Payment Cancelled");
        },
      ),
    ),
  );
}
