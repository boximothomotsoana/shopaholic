import 'package:auth/widgets/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:auth/utils/app_colors.dart';

import '../popups/personalinfo.dart';
import '../routes.dart';
import 'orders.dart';

// GlobalKey for Scaffold
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
// 🔹 Top Navigation Bar
class TopBar extends StatefulWidget {
  final int cartItemCount;
  final VoidCallback onSearchTap;
  final VoidCallback onTap;

  TopBar({super.key, required this.cartItemCount, required this.onSearchTap, required this.onTap});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int cartItemCount = 3;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    bool showFilter = false;

    return Row(
      key: _scaffoldKey,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            ProfileAvatar(),
            if (isMobile) ...[Center ( child: Image.asset('assets/images/logo.png', width: 200, height: 200),)], // Logo
            SizedBox(width: 10),
            if (!isMobile) ...[
              SizedBox(height: 20, child: VerticalDivider(thickness: 1, width: 10, color: Colors.grey.withOpacity(0.5),),),
              _buildNavMenuItem(context, "Sell With Us", '/login'),
              SizedBox(height: 20, child: VerticalDivider(thickness: 1, width: 10, color: Colors.grey.withOpacity(0.5),),),
              _buildNavMenuItem(context, "About Us", '/register'),
            ]
          ],
        ),
        if (!isMobile)
          Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: SearchBox())),
        Row(
          children: [
            if (!isMobile) ...[
              Builder(builder: (context) {
                return NavMenuItem("Login", onTap: () {
                  Navigator.pushNamed(context, "/login");
                });
              }),
              SizedBox(height: 20, child: VerticalDivider(thickness: 1, width: 10, color: Colors.grey.withOpacity(0.5),),),
              _buildNavMenuItem(context, "Dashboard", "/admin"),

              IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
              Stack(
                children: [
                  IconButton(icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  }),
                  if (cartItemCount > 0)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text("$cartItemCount", style: TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                    ),
                  // Button to toggle filter visibility
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }
  // Helper method to create navigation items
  Widget _buildNavMenuItem(BuildContext context, String title, String route) {
    return NavMenuItem(title, onTap: () {
      Navigator.pushNamed(context, route);
    });
  }
}

class SidebarMenu extends StatelessWidget {
  final String title;
  final Color color;
  final Color titleColor;

  const SidebarMenu({super.key, required this.title, required this.color, this.titleColor = Colors.white,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      color: color,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.white),
          const SizedBox(height: 10),

          /// **Advert Cards Section**
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



// 🔹 Navigation Menu Item
class NavMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap; // Make sure this is included

  const NavMenuItem(this.title, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return   MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
      onTap: onTap, // This must be properly assigned
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
        ),
      ),
    ));
  }
}


class LeftSideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Removes rounded corners
      ),
      backgroundColor: AppColors.light,
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(color: AppColors.primary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Left Sidebar",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          _buildListTileWithTrailing(Icons.person, "Personal Information", "", context),
                          Divider(),
                          _buildListTileWithTrailing(Icons.account_balance_wallet, "Credit Balance" ,"0.00", context),
                          Divider(),
                          _buildListTile(
                              Icons.local_offer,
                              "Orders",
                              onTap: () {
                                if (MediaQuery.of(context).size.width > 600) {
                                  // Desktop: Show as modal sheet
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return FractionallySizedBox(
                                        heightFactor: 0.9, // Adjust modal height
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                          ),
                                          child: OrderScreen(), // Use your existing orders page
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  // Mobile: Navigate to full page
                                  Navigator.pushNamed(context, '/orders');
                                }
                              }
                          ),

                          Divider(),
                          _buildListTileWithTrailing(Icons.payment, "Payment Methods",'', context),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Column(
                        children: [
                          _buildListTile(Icons.info, "About", onTap: () {
                            Navigator.pushNamed(context, AppRoutes.about);
                          }),
                          Divider(),
                          _buildListTile(Icons.help, "Help", onTap: () {
                            Navigator.pushNamed(context, '/help');
                          }),
                          Divider(),
                          _buildListTile(Icons.settings, "Settings", onTap: () {
                            Navigator.pushNamed(context, '/settings');
                          }),
                          Divider(),
                          _buildListTile(Icons.storefront, "Sell With Us", onTap: () {
                            Navigator.pushNamed(context, '/login');
                          }),
                          Divider(),
                          _buildListTile(Icons.delivery_dining, "Be a Deliver", onTap: () {
                            Navigator.pushNamed(context, '/deliver');
                          }),
                          Divider(),
                          _buildListTile(Icons.logout, "Log Out", isLogout: true, onTap: () {
                            // Handle logout
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Log Out"),
                                content: Text("Are you sure you want to log out?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context), // Cancel
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close dialog
                                      Navigator.pushReplacementNamed(context, '/login'); // Redirect to login
                                    },
                                    child: Text("Log Out", style: TextStyle(color: AppColors.danger)),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, {bool isLogout = false, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? AppColors.danger : AppColors.textPrimary),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isLogout ? AppColors.danger : AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
    );
  }
  Widget _buildListTileWithTrailing(IconData icon, String title, String trailingText, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      trailing: Text(
        trailingText,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      onTap: () {
        if (title == "Personal Information") {
          // Close the drawer
          Navigator.pop(context);

          // Ensure context is still valid and show the popup
          Future.delayed(Duration(milliseconds: 200), () {
            if (context.mounted) {  // Make sure context is still mounted
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PersonalInfoPopup();  // Your custom popup
                },
              );
            }
          });
        }
      },
    );
  }

}

// 🔹 Search Box
class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search...",
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// 🔹 Profile Avatar
class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Open Sidebar",
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // ✅ Hand cursor on hover
        child: GestureDetector(
          onTap: () {
            Scaffold.of(context).openEndDrawer(); // ✅ Open Left Sidebar
          },
          child: CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Text('M', style: TextStyle(color: AppColors.light, fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

