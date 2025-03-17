import 'package:auth/UI/dashboard.dart';
import 'package:auth/dashboard/category.dart';
import 'package:auth/dashboard/paymentmethods.dart';
import 'package:auth/dashboard/products.dart';
import 'package:auth/dashboard/users.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:table_calendar/table_calendar.dart';

import '../certificate/generator.dart';
import 'add_product.dart';
import 'calendar.dart';

class AdminDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: AdminDashboardAppScreen(),
    );
  }
}

class AdminDashboardAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 1024;

    return Scaffold(
      appBar: TopBar(),
      drawer: isDesktop ? null : SideMenu(), // Hide side menu on tablet & mobile
      body: Row(
        children: [
          if (isDesktop) SideMenu(), // Show side menu only on desktop
          Expanded(child: ResponsiveLayout()),
        ],
      ),
    );
  }
}


class TopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Dashboard'),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: Colors.white24,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/rr.png'),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 768;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Menu', style: TextStyle(fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Text('Users'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UsersDataTable()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Text('Users'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResponsiveDataTable()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exposure_plus_1_rounded),
            title: Text('Add Products'),
            onTap: () {
              if (isDesktop) {
                // Show Modal Bottom Sheet on Web
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Allows full-screen modal
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9, // Almost full screen
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Close Button
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          Expanded(child: AddProductPage()), // Show Add Product Form
                        ],
                      ),
                    );
                  },
                );
              } else {
                // Navigate on Mobile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.category_rounded),
            title: Text('Category'),
            onTap: () {
              if (isDesktop) {
                // Show Modal Bottom Sheet on Web
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Allows full-screen modal
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9, // Almost full screen
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Close Button
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          Expanded(child: ProductCategoryWidget()), // Show Add Product Form
                        ],
                      ),
                    );
                  },
                );
              } else {
                // Navigate on Mobile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductCategoryWidget()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payment Methods'),
            onTap: () {
              if (isDesktop) {
                // Show Modal Bottom Sheet on Web
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Allows full-screen modal
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9, // Almost full screen
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Close Button
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          Expanded(child: PaymentMethodsPage()), // Show Add Product Form
                        ],
                      ),
                    );
                  },
                );
              } else {
                // Navigate on Mobile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentMethodsPage()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Calendar'),
            onTap: () {
              if (isDesktop) {
                // Show Modal Bottom Sheet on Web
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Allows full-screen modal
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9, // Almost full screen
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Close Button
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          Expanded(child: BookingCalendar()), // Show Add Product Form
                        ],
                      ),
                    );
                  },
                );
              } else {
                // Navigate on Mobile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingCalendar()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              if (isDesktop) {
                // Show Modal Bottom Sheet on Web
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Allows full-screen modal
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9, // Almost full screen
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Close Button
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          Expanded(child: CertificateApp()), // Show Add Product Form
                        ],
                      ),
                    );
                  },
                );
              } else {
                // Navigate on Mobile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CertificateApp()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
final List<double> revenueData = [500, 800, 1200, 1400, 900, 1500, 1700, 1800, 1600, 1400, 1300, 1000];
final List<double> appointmentData = [50, 80, 100, 120, 90, 150, 170, 180, 160, 140, 130, 110];

final List<String> monthLabels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];


class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 768) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: InfoCard(title: "Users", chartData: [60, 40], labels: ["Active", "Inactive"])),
                          Expanded(child: InfoCard(title: "Appointments", chartData: [30, 50, 20], labels: ["Completed", "Cancelled", "In Progress"])),
                          Expanded(child: InfoCard(title: "Visits", chartData: [50, 30, 20], labels: ["Just Visited", "Booked", "Incomplete"])),
                          Expanded(child: InfoCard(title: "Engagements", chartData: [70, 20, 10], labels: ["Likes", "Followers", "Following"])),
                        ],
                      );
                    } else {
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          InfoCard(title: "Users", chartData: [60, 40], labels: ["Active", "Inactive"]),
                          InfoCard(title: "Appointments", chartData: [30, 50, 20], labels: ["Completed", "Cancelled", "In Progress"]),
                          InfoCard(title: "Visits", chartData: [50, 30, 20], labels: ["Just Visited", "Booked", "Incomplete"]),
                          InfoCard(title: "Engagements", chartData: [70, 20, 10], labels: ["Likes", "Followers", "Following"]),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 16),
                // Bar Charts - Inline on Large Screens
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWideScreen = constraints.maxWidth > 900;
                    return isWideScreen
                        ? Row(
                      children: [
                        Expanded(child: BarChartWidget(title: "Revenue Over 12 Months", data: revenueData, months: monthLabels)),
                        SizedBox(width: 16),
                        Expanded(child: BarChartWidget(title: "Appointments Booking Over 12 Months", data: appointmentData, months: monthLabels)),
                      ],
                    )
                        : Column(
                      children: [
                        BarChartWidget(title: "Revenue Over 12 Months", data: revenueData, months: monthLabels),
                        SizedBox(height: 16),
                        BarChartWidget(title: "Appointments Booking Over 12 Months", data: appointmentData, months: monthLabels),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  final String title;
  final List<double> data;
  final List<String> months;

  BarChartWidget({required this.title, required this.data, required this.months});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double chartWidth = constraints.maxWidth > 1024 ? 600 : constraints.maxWidth; // Limit width on large screens

        return Center(
          child: SizedBox(
            width: chartWidth, // Restrict max width
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    AspectRatio(
                      aspectRatio: 1.8, // Ensures it doesn't take too much height
                      child: BarChart(
                        BarChartData(
                          barGroups: List.generate(data.length, (index) =>
                              BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(toY: data[index], color: Colors.blue, width: 16),
                                ],
                              ),
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 200,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(value.toInt().toString(), style: TextStyle(fontSize: 10)),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() >= 0 && value.toInt() < months.length) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(months[value.toInt()], style: TextStyle(fontSize: 10)),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final List<double> chartData;
  final List<String> labels;

  InfoCard({required this.title, required this.chartData, required this.labels});

  @override
  Widget build(BuildContext context) {
    double total = chartData.fold(0, (prev, element) => prev + element);
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth > 900 ? 350 : constraints.maxWidth * 0.9;

        return Center(
          child: SizedBox(
            width: cardWidth,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ensures Column doesn't expand unnecessarily
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(height: 30),
                    // ✅ Wrap PieChart inside Flexible to prevent layout errors
                    Flexible(
                      fit: FlexFit.loose,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double availableWidth = constraints.maxWidth;
                          double pieRadius = availableWidth * 0.3;  // Adjust radius proportionally
                          double centerSpace = availableWidth * 0.08; // Adjust center space proportionally
                          double fontSize = availableWidth * 0.08; // Dynamically scale font size

                          return AspectRatio(
                            aspectRatio: isMobile ? 1.4 : 1.6,
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 2,
                                centerSpaceRadius: centerSpace, // Center space scales dynamically
                                sections: List.generate(chartData.length, (index) {
                                  double percentage = (chartData[index] / total) * 100;
                                  return PieChartSectionData(
                                    value: chartData[index],
                                    title: "${percentage.toStringAsFixed(1)}%",
                                    color: _getColor(index),
                                    radius: pieRadius, // Dynamic radius
                                    titleStyle: TextStyle(
                                      fontSize: fontSize, // Dynamic font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Wrap(
                      spacing: 10,
                      children: List.generate(labels.length, (index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(width: 12, height: 12, color: _getColor(index)),
                            SizedBox(width: 5),
                            Text(labels[index], style: TextStyle(fontSize: isMobile ? 10 : 12)),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getColor(int index) {
    List<Color> colors = [Colors.blue, Colors.green, Colors.orange, Colors.red, Colors.purple, Colors.yellow];
    return colors[index % colors.length];
  }
}







