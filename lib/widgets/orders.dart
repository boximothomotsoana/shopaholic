import 'package:auth/UI/dashboard.dart';
import 'package:auth/utils/app_colors.dart';
import 'package:auth/widgets/tracking_order.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'cart_screen.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Map<String, dynamic>> orders = [
    {'id': '12345', 'status': 'In Transit'},
    //{'id': '67890', 'status': 'Delivered'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredOrders = orders
        .where((order) =>
    order['id'].toString().contains(searchQuery) ||
        order['status'].toString().toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (MediaQuery.of(context).size.width > 600) {
                // Desktop: Show search as a modal bottom sheet
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return FractionallySizedBox(
                      heightFactor: 0.9, // Controls the modal height
                      child: OrderSearchScreen(orders: orders), // Custom search screen for desktop
                    );
                  },
                );
              } else {
                // Mobile: Show search using OrderSearchDelegate
                showSearch(context: context, delegate: OrderSearchDelegate(orders));
              }
            },
          ),

        ],
      ),
      body: filteredOrders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/no_data.json', width: 200, height: 200),
            SizedBox(height: 20),
            Text('No orders yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
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
                  context, MaterialPageRoute(builder: (context) => CartScreen())
                );
              },
              child: Text('Go to Cart To Order'),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          final order = filteredOrders[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Icon(
                order['status'] == 'Delivered' ? Icons.check_circle : Icons.local_shipping,
                color: order['status'] == 'Delivered' ? Colors.green : Colors.blue,
              ),
              title: Text('Order #${order['id']}'),
              subtitle: Text('Status: ${order['status']}'),
              tileColor: Colors.grey[200],
              onTap: () {
                if (MediaQuery.of(context).size.width > 600) {
                  // Desktop: Show as a dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          width: 500, // Set a reasonable width for the pop-up
                          padding: EdgeInsets.all(16),
                          child: OrderDetailScreen(order: order),
                        ),
                      );
                    },
                  );
                } else {
                  // Mobile: Navigate to full page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailScreen(order: order),
                    ),
                  );
                }
              },

            ),
          );
        },
      ),
    );
  }
}

class OrderSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> orders;

  OrderSearchDelegate(this.orders);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Map<String, dynamic>> filteredOrders = orders
        .where((order) =>
    order['id'].toString().contains(query) ||
        order['status'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return ListTile(
          title: Text('Order #${order['id']}'),
          subtitle: Text('Status: ${order['status']}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailScreen(
                  order: {
                    'id': '12345',
                    'status': 'Shipped',
                    'items': [
                      {
                        'name': '2 Piece Plain Navy Work Suit - 30 x 50 cm',
                        'price': 289,
                        'quantity': 1,
                        'seller': 'Vuyo Hub',
                        'imageUrl': 'https://example.com/image1.jpg'
                      },
                      {
                        'name': 'Conti Suit 2 Piece Black Reflective Poly Cotton - EU 34',
                        'price': 348,
                        'quantity': 1,
                        'seller': 'Loon',
                        'imageUrl': 'https://example.com/image2.jpg'
                      }
                    ]
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, dynamic>> filteredOrders = orders
        .where((order) =>
    order['id'].toString().contains(query) ||
        order['status'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return ListTile(
          title: Text('Order #${order['id']}'),
          subtitle: Text('Status: ${order['status']}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailScreen(
                  order: {
                    'id': '12345',
                    'status': 'Shipped',
                    'items': [
                      {
                        'name': '2 Piece Plain Navy Work Suit - 30 x 50 cm',
                        'price': 289,
                        'quantity': 1,
                        'seller': 'Vuyo Hub',
                        'imageUrl': 'https://example.com/image1.jpg'
                      },
                      {
                        'name': 'Conti Suit 2 Piece Black Reflective Poly Cotton - EU 34',
                        'price': 348,
                        'quantity': 1,
                        'seller': 'Loon',
                        'imageUrl': 'https://example.com/image2.jpg'
                      }
                    ]
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: order['items'] == null || order['items'].isEmpty
          ? Center(
        child: Text(
          'No items in this order.',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: order['items']?.length ?? 0,
        itemBuilder: (context, index) {
          final item = order['items'][index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                if (item['imageUrl'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item['imageUrl'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] ?? 'Unknown Item',
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'R ${item['price'] ?? '0.00'}   Qty: ${item['quantity'] ?? 1}',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Sold by ${item['seller'] ?? 'Unknown Seller'}',
                        style: TextStyle(color: AppColors.secondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.light,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.assignment_return, color: AppColors.primary),
                label: Text('LOG RETURN', style: TextStyle(color: AppColors.primary)),
              ),
              TextButton.icon(
                onPressed: () {
                  if (MediaQuery.of(context).size.width > 600) {
                    // Desktop: Show as a modal sheet
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // Allows full-screen height if needed
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.99, // Adjust height of the modal
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: TrackingScreen(), // Show tracking screen inside modal
                          ),
                        );
                      },
                    );
                  } else {
                    // Mobile: Navigate to full page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackingScreen(),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.track_changes, color: AppColors.primary),
                label: Text('TRACK', style: TextStyle(color: AppColors.primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: OrderScreen(),
  ));
}

class OrderSearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orders;

  OrderSearchScreen({required this.orders});

  @override
  _OrderSearchScreenState createState() => _OrderSearchScreenState();
}

class _OrderSearchScreenState extends State<OrderSearchScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredOrders = widget.orders.where((order) {
      return order['id'].toString().contains(searchQuery) ||
          order['status'].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search Orders...",
            border: InputBorder.none,
          ),
        ),
      ),
      body: filteredOrders.isEmpty
          ? Center(child: Text("No matching orders"))
          : ListView.builder(
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          final order = filteredOrders[index];
          return ListTile(
            title: Text('Order #${order['id']}'),
            subtitle: Text('Status: ${order['status']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailScreen(
                    order: order, // Passing selected order to the detail page
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

