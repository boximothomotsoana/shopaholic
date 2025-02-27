import 'package:flutter/material.dart';

class ResponsiveProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "title": "Wireless Headphones",
      "image": "assets/images/rr.png",
      "price": 49.99,
      "salePrice": 39.99,
      "isOnSale": true,
      "rating": 4.5,
      "reviewCount": 120,
      "stock": 8,
      "description": "High-quality wireless headphones with noise cancellation.",
      "colors": ["Black", "White", "Blue"],
      "sizes": ["S", "M", "L"]
    },
    {
      "title": "Smart Watch",
      "image": "assets/images/rr.png",
      "price": 99.99,
      "salePrice": null,
      "isOnSale": false,
      "rating": 4.8,
      "reviewCount": 80,
      "stock": 5,
      "description": "A modern smartwatch with fitness tracking features.",
      "colors": ["Black", "Silver", "Gold"],
      "sizes": ["One Size"]
    },
    {
      "title": "Gaming Mouse",
      "image": "assets/images/rr.png",
      "price": 29.99,
      "salePrice": 24.99,
      "isOnSale": true,
      "rating": 4.3,
      "reviewCount": 50,
      "stock": 15,
      "description": "Ergonomic gaming mouse with RGB lighting.",
      "colors": ["Black", "Red", "Blue"],
      "sizes": ["One Size"]
    },
    {
      "title": "Bluetooth Speaker",
      "image": "assets/images/rr.png",
      "price": 59.99,
      "salePrice": null,
      "isOnSale": false,
      "rating": 4.6,
      "reviewCount": 200,
      "stock": 12,
      "description": "Portable Bluetooth speaker with powerful bass.",
      "colors": ["Black", "White"],
      "sizes": ["One Size"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      height: isMobile ? 400 : 550,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: isMobile ? 1.0 : 1.5,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () => showProductBottomSheet(context, product),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Stack(
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      product["image"],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Sale Badge
                  if (product["isOnSale"])
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'SALE NOW R ${product["salePrice"]}',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                  // Product Info Overlay
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["title"],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              if (index + 1 <= product["rating"]) {
                                return Icon(Icons.star, color: Colors.orange, size: 14);
                              } else if (index + 0.5 <= product["rating"]) {
                                return Icon(Icons.star_half, color: Colors.orange, size: 14);
                              } else {
                                return Icon(Icons.star_border, color: Colors.grey[300], size: 14);
                              }
                            }),
                          ),
                         if (product["isOnSale"]) ...[
                          Text(
                              'Was ${product["price"]?.toStringAsFixed(2) ?? "N/A"}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: product["isOnSale"] ? TextDecoration.lineThrough : TextDecoration.none,
                              color: product["isOnSale"] ? Colors.white60 : Colors.white,
                            )
                          )
                         ],
                          if (!product["isOnSale"]) ...[
                            SizedBox(width: 8), // Space between prices
                            // New Price (Sale Price)
                            Text(
                              product["price"]?.toStringAsFixed(2) ?? "N/A",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  decoration: product["isOnSale"] ? TextDecoration.lineThrough : TextDecoration.none,
                                  color: product["isOnSale"] ? Colors.white60 : Colors.white,
                                )
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showProductBottomSheet(BuildContext context, Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            bool isLargeScreen = constraints.maxWidth > 600; // Adjust the breakpoint as needed
            final PageController pageController = PageController();

            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          // Small image slider with controls
                          SizedBox(
                            height: 150,
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: 4, // Replace with the number of images you have
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  //child: Image.asset('assets/images/image${index + 1}.png', height: 150),
                                  child: Image.asset('assets/images/rr.png', height: 150, fit: BoxFit.cover,),
                                );
                              },
                            ),
                          ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    if (pageController.hasClients) {
                                      pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    if (pageController.hasClients) {
                                      pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          SizedBox(height: 10),
                          Text(product["title"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Row(
                            children: List.generate(5, (index) =>
                                Icon(Icons.star, color: index < product["rating"] ? Colors.orange : Colors.grey, size: 16)),
                          ),
                          SizedBox(height: 5),
                          Text(product["description"], style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Price: \$${product["salePrice"] ?? product["price"]}",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                              if (product["isOnSale"])
                                Text("Original: \$${product["price"]}",
                                    style: TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            children: product["colors"].map<Widget>((color) => Chip(label: Text(color))).toList(),
                          ),
                          SizedBox(height: 10),
                          // Dropdown for selecting size
                          DropdownButton<String>(
                            hint: Text("Select Size"),
                            items: product["sizes"].map<DropdownMenuItem<String>>((String size) {
                              return DropdownMenuItem<String>(
                                value: size,
                                child: Text(size),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 10),
                          // Quantity controls
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(icon: Icon(Icons.remove), onPressed: () {}),
                              Text("1"), // Replace with the quantity variable
                              IconButton(icon: Icon(Icons.add), onPressed: () {}),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
                              ElevatedButton(onPressed: () {}, child: Text("Add to Cart")),
                            ],
                          ),
                        ],
                      ),
                      // X cancel button
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
