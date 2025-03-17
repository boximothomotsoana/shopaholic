import 'package:auth/widgets/notifications.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/app_colors.dart';
import 'package:auth/widgets/menus.dart';

import '../providers/paypal_transaction.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/cart_screen.dart';
import '../widgets/category_scroll.dart';
import '../widgets/filter.dart';
import '../widgets/multi_level_menu.dart';
import '../widgets/orders.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_scroll.dart';
import '../widgets/shops_scroll.dart';
import 'all_products.dart'; // Import the menu components


class Dashboard extends StatefulWidget {
  final Color titleColor;
  const Dashboard({super.key, this.titleColor = Colors.white});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int cartItemCount = 0;
  int favoriteItemCount = 0;
  int orderItemCount = 0;
  int _selectedIndex = 0;
  bool _showLeftSidebar = false;
  bool _showRightSidebar = true;

  // Handle item tap and navigate to respective screens
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the selected screen
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductScreen()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, spreadRadius: 2, offset: Offset(0, 4)),
          ]),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: TopBar(cartItemCount: cartItemCount, onSearchTap: () {}, onTap: () { },),
            actions: [
              if (!isMobile)
                IconButton(
                  icon: Icon(Icons.filter_list_sharp),
                  onPressed: () {
                    setState(() {
                      if (_showLeftSidebar) {
                        _showLeftSidebar = false; // Hide left sidebar
                        _showRightSidebar = true;
                      } else {
                        _showLeftSidebar = true; // Show left sidebar
                        _showRightSidebar = false; // Hide right sidebar if left sidebar is shown
                      }
                    });
                  },
                ),
              if (isMobile)
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: Icon(Icons.filter_list_sharp),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();  // Open the drawer using the correct context
                      },
                    );
                  },
                ),
            ],

          ),
        ),
      ),
      drawer: isMobile ? RestaurantFilter() : null,
      endDrawer: LeftSideBarMenu(),
      body: LayoutBuilder(

        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 900;
          bool isDesktop = MediaQuery.of(context).size.width > 900;

          print("isDesktop: $isDesktop, _showSidebar: $_showLeftSidebar"); // Debugging log


          return Row(
            children: [
              if (isDesktop && _showLeftSidebar) ...[
                SizedBox(
                  child: RestaurantFilter(), // Sidebar filter on desktop
                ),
              ],
              Expanded(
                child: Center(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CategoryScrollView(),
                          CustomCarousel(),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Hot Deals For You"),
                            MouseRegion(
                              cursor: SystemMouseCursors.click, // Changes the cursor when hovering
                              child:GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProductScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Load more",
                                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          RestaurantScrollView(),
                          SizedBox(height: 20,),
                          ProductScrollView(),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("New from Us"),
                            MouseRegion(
                              cursor: SystemMouseCursors.click, // Changes the cursor when hovering
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProductScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Load more",
                                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ProductScrollView(),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Suggested For You"),
                            MouseRegion(
                              cursor: SystemMouseCursors.click, // Changes the cursor when hovering
                              child:GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProductScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Load more",
                                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          ResponsiveProductGrid(),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Right Sidebar
              if (isDesktop && _showRightSidebar == true) ...[
                SizedBox(// Right sidebar width
                  child: SidebarMenu(
                    title: "Explore different styles",
                    titleColor: Colors.red,
                    color: AppColors.light,
                  ), // Your right sidebar content
                ),
              ],
            ],
          );
        },
      ),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.textPrimary,
        unselectedItemColor: AppColors.warning,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.home),
              ],
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                _buildBadge(cartItemCount),  // Cart badge
              ],
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.notifications),
                _buildBadge(favoriteItemCount),  // Favorites badge
              ],
            ),
            label: "Updates",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.receipt_long),
                _buildBadge(orderItemCount),  // Orders badge
              ],
            ),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
        ],
      )
          : null,
    );
  }
  Widget _buildBadge(int count) {
    if (count >= 0) {
      return  Positioned(
        right: 0,
        top: 0,
        child: CircleAvatar(
          radius: 8,
          backgroundColor: Colors.red,
          child: Text("$count", style: TextStyle(fontSize: 12, color: Colors.white)),
        ),
      );
    }
    return Container();
  }
}
