import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = [
   // {'title': 'New Appointment', 'message': 'Your appointment is confirmed.', 'isRead': false},
    //{'title': 'Reminder', 'message': 'You have a session tomorrow.', 'isRead': false},
    //{'title': 'Offer', 'message': 'Get 20% off on your next booking!', 'isRead': true},
  ];

  late List<Map<String, dynamic>> filteredNotifications;

  @override
  void initState() {
    super.initState();
    filteredNotifications = notifications;
  }

  void markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
      filteredNotifications = notifications;
    });
  }

  void filterNotifications(String query) {
    setState(() {
      filteredNotifications = notifications.where((notification) {
        return notification['title'].toLowerCase().contains(query.toLowerCase()) ||
            notification['message'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          if (notifications.any((n) => !n['isRead']))
            TextButton(
              onPressed: markAllAsRead,
              child: Text('Mark All as Read', style: TextStyle(color: Colors.white)),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterNotifications,
              decoration: InputDecoration(
                hintText: 'Search notifications...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: filteredNotifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/no_data.json', width: 200, height: 200),
            SizedBox(height: 20),
            Text('No new notifications', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      )
          : ListView.builder(
        itemCount: filteredNotifications.length,
        itemBuilder: (context, index) {
          final notification = filteredNotifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) => deleteNotification(index),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                leading: Icon(
                  notification['isRead'] ? Icons.notifications_none : Icons.notifications_active,
                  color: notification['isRead'] ? Colors.grey : Colors.blue,
                ),
                title: Text(
                  notification['title'],
                  style: TextStyle(
                    fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                subtitle: Text(notification['message']),
                tileColor: notification['isRead'] ? Colors.grey[200] : Colors.blue[50],
                onTap: () {
                  setState(() {
                    notification['isRead'] = true;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
