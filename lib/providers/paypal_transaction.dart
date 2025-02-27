import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:io' as io; // Import 'dart:io' for platform checking

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TransactionPage(),
    );
  }
}

class TransactionPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<TransactionPage> {
  String? checkoutUrl;
  String executeUrl = "";
  String accessToken = "";

  final String clientId = "Ac0mDd89c4-tqZr5MeNm72b7o6wYNtc08John006fLbvxbHn0euSdbDgI336TGZdzXlaE7pwcEFB9eqF";
  final String secret = "EChJ5LUMVkqyj0RvbPW-W0bmfD48iqnX9K6Jge_tgTNtwPxLw7qtCxmPX9C9Jokle_g2cAcxDfS-Dxhc";
  final String returnURL = "https://facebook.com";
  final String cancelURL = "https://takealot.com";
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController() // Initialize WebViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(checkoutUrl ?? "https://www.paypal.com"));
    getAccessToken();
  }

  Future<void> getAccessToken() async {
    final response = await http.post(
      Uri.parse("https://api.sandbox.paypal.com/v1/oauth2/token"),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$clientId:$secret')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        accessToken = data['access_token'];
      });
      createPayPalPayment();
    }
  }

  Future<void> createPayPalPayment() async {
    final response = await http.post(
      Uri.parse("https://api.sandbox.paypal.com/v1/payments/payment"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "intent": "sale",
        "payer": {"payment_method": "paypal"},
        "transactions": [{
          "amount": {"total": "10.00", "currency": "USD"},
          "description": "Payment for your order"
        }],
        "redirect_urls": {
          "return_url": returnURL,
          "cancel_url": cancelURL
        }
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final approvalUrl = data['links'].firstWhere((link) => link['rel'] == 'approval_url')['href'];
      setState(() {
        checkoutUrl = approvalUrl;
      });
      // If running on web, open PayPal in a new tab instead of WebView
      if (io.Platform.isAndroid || io.Platform.isIOS) {
        _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(approvalUrl));
      } else {
        launchUrl(Uri.parse(approvalUrl), mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PayPal Checkout")),
      body: checkoutUrl == null
          ? Center(child: CircularProgressIndicator())
          : (io.Platform.isAndroid || io.Platform.isIOS)
          ? WebViewWidget(controller: _controller!)
          : Center(
        child: Text("Redirecting to PayPal...", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
