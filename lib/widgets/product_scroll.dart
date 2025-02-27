import 'package:auth/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProductScrollView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/rr.png",
      "name": "Wireless Headphones",
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
      "image": "assets/images/rr.png",
      "name": "Wireless Headphones",
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
      "image": "assets/images/rr.png",
      "name": "Wireless Headphones",
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
      "image": "assets/images/rr.png",
      "name": "Wireless Headphones",
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
      "image": "assets/images/rr.png",
      "name": "Wireless Headphones",
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
  ];

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
                          Text(product["name"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

  //centers header
  Widget centersHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 2, right: 16, left: 16, bottom: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Health Centers In Lesotho"),
          Text(
            "Load more",
            style: TextStyle(color: Colors.redAccent),
          )
        ],
      ),
    );
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return Row(
      children: [
        if (!isMobile) IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: _scrollLeft,
        ),
        Expanded(
          child: Container(
            height: 250,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () => showProductBottomSheet(context, product),
                  child: Container(
                    width: 180,
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.light,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.asset(
                                product["image"],
                                width: 180,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
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
                                    "SALE",
                                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product["name"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  for (int i = 1; i <= 5; i++)
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: i <= product["rating"] ? Colors.orange : Colors.grey[300],
                                    ),
                                  SizedBox(width: 4),
                                  Text(
                                    "(${product["reviewCount"]})",
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  if (product["isOnSale"])
                                    Text(
                                      "\$${product["price"].toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  SizedBox(width: 6),
                                  Text(
                                    "\$${(product["salePrice"] ?? product["price"]).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: product["isOnSale"] ? Colors.red : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                product["stock"] > 0
                                    ? "In stock: ${product["stock"]}"
                                    : "Out of stock",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: product["stock"] > 0 ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
       if (!isMobile) IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: _scrollRight,
        ),
      ],
    );
  }
}
