import 'package:auth/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TrackingScreen extends StatelessWidget {
  final Map<String, dynamic> order = {
    'id': '156544144',
    'deliveryDate': 'Mon, 22 Jul 2024',
    'images': [
      'https://picsum.photos/250?image=9',
      'https://picsum.photos/250?image=9',
      'https://picsum.photos/250?image=9',
      'https://picsum.photos/250?image=9',
      'https://picsum.photos/250?image=9',
      'https://picsum.photos/250?image=9',
    ],
    'tracking': [
      {'date': '13 JUL 2024', 'status': 'Order Paid', 'isCompleted': true},
      {'date': '19 JUL 2024', 'status': 'Shipped - 3 Parcels', 'isCompleted': true},
      {'date': '22 JUL 2024', 'status': 'DELIVERED - Stockdale Street', 'isCompleted': true},
    ],
    'latestUpdate': {
      'time': '09:24',
      'status': 'Signed by: Bokang Mothomotsoana (Customer)',
      'location': 'Kimberley, Kimberley',
      'courier': 'Shopaholic Delivery Team'
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tracking')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order #${order['id']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Delivered ${order['deliveryDate']}', style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: order['images'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(order['images'][index], width: 80, height: 80, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(
                indicatorTheme: IndicatorThemeData(size: 20, color: AppColors.success),
                connectorTheme: ConnectorThemeData(thickness: 4, color: AppColors.success),
              ),
              builder: TimelineTileBuilder.connected(
                itemCount: order['tracking'].length,
                connectionDirection: ConnectionDirection.after,

                // Left Side (Date)
                oppositeContentsBuilder: (context, index) {
                  var step = order['tracking'][index];
                  return SizedBox(
                    height: 100, // Ensures both sides have equal height
                    child: Align(
                      alignment: Alignment.centerRight, // Aligns text properly
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          step['date'],
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },

                // Right Side (Status)
                contentsBuilder: (context, index) {
                  var step = order['tracking'][index];
                  return SizedBox(
                    height: 100, // Matches the height of the opposite side
                    child: Align(
                      alignment: Alignment.centerLeft, // Aligns text properly
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          step['status'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },

                // Indicator (Middle)
                indicatorBuilder: (context, index) {
                  return order['tracking'][index]['isCompleted']
                      ? Icon(Icons.check_circle, color: AppColors.success, size: 24)
                      : Icon(Icons.radio_button_unchecked, color: AppColors.textSecondary, size: 24);
                },

                // Connector (Line between indicators)
                connectorBuilder: (_, index, __) => SolidLineConnector(),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(order['latestUpdate']['status'], style: TextStyle(fontSize: 14)),
                Text(order['latestUpdate']['location'], style: TextStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.0), // Padding inside the container
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.3), // Background color
                          border: Border.all(
                            color: AppColors.success.withOpacity(0.7), // Border color
                            width: 2.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(10.0), // Rounded corners
                        ),
                        child: Center(
                          child: Text('COURIER: ${order['latestUpdate']['courier']}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}