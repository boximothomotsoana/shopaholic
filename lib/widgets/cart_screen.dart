import 'package:auth/providers/paypal_transaction.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../UI/dashboard.dart';
import 'checkout.dart';
import 'menus.dart';
import 'multi_level_menu.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [
   // {
     // "title": "Wireless Headphones",
     //"image": "assets/images/rr.png",
     // "price": 49.99,
     // "salePrice": 39.99,
     // "isOnSale": true,
     // "quantity": 1,
    //},
    //{
      //"title": "Smart Watch",
      //"image": "assets/images/rr.png",
      //"price": 99.99,
      //"salePrice": null,
      //"isOnSale": false,
      //"quantity": 2,
    //},
    //{
      //"title": "Gaming Mouse",
      //"image": "assets/images/rr.png",
      //"price": 29.99,
      //"salePrice": 24.99,
      //"isOnSale": true,
      //"quantity": 1,
    //},
  ];

  double getTotalPrice() {
    double total = 0.0;
    for (var item in cartItems) {
      double itemPrice = item["salePrice"] ?? item["price"];
      total += itemPrice * item["quantity"];
    }
    return total;
  }

  void updateQuantity(int index, int change) {
    setState(() {
      cartItems[index]["quantity"] += change;
      if (cartItems[index]["quantity"] == 0) {
        cartItems.removeAt(index);
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void checkout() {
    // Handle checkout logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Proceeding to checkout...")),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage()));
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: AppBar(title: Text("Cart"), centerTitle: true),
      body: Row(
        children: [
          // Main cart items
          Expanded(
            flex: 3,
            child: cartItems.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animations/no_data.json', width: 200, height: 200),
                  SizedBox(height: 20),
                  Text('No items here yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                    child: Text('Proceed to Shop'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Dashboard())
                      );
                    },
                    child: Text('Check amazing deals for today'),
                  ),
                ],
              ),
            )
                : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: ListTile(
                          leading: Image.asset(item["image"], width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(item["title"], style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            "\$${(item["salePrice"] ?? item["price"]).toStringAsFixed(2)} x ${item["quantity"]}",
                            style: TextStyle(color: Colors.red),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                onPressed: () => updateQuantity(index, -1),
                              ),
                              Text(item["quantity"].toString(), style: TextStyle(fontSize: 16)),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline),
                                onPressed: () => updateQuantity(index, 1),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => removeItem(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("\$${getTotalPrice().toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: checkout,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.blue,
                        ),
                        child: Text("Proceed to Checkout", style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Right sidebar with ads
          if (!isMobile)
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.grey[200],
                child: ListView(
                  children: [
                    Container(
                      height: 300, // Set a fixed height for the GridView
                      child: GridView.builder(
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.2, // Adjust aspect ratio
                        ),
                        itemCount: 4, // 4 Advert Cards
                        itemBuilder: (context, index) {
                          return _buildAdvertCard(index);
                        },
                      ),
                    ),
                    // Placeholder for ads
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      color: Colors.white,
                      height: 100,
                      child: Center(child: Text("Ad 1")),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      color: Colors.white,
                      height: 100,
                      child: Center(child: Text("Ad 2")),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      color: Colors.white,
                      height: 100,
                      child: Center(child: Text("Ad 3")),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      color: Colors.white,
                      height: 100,
                      child: Center(child: Text("Ad 4")),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  /// **Reusable Advert Card Widget**
  Widget _buildAdvertCard(int index) {
    List<String> titles = ["Sale 50%", "New Arrivals", "Limited Offer", "Exclusive Deal"];
    List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.orange];

    return Card(
      color: colors[index],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          titles[index],
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
