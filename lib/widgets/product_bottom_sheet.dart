import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductBottomSheet {
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
                          if (isLargeScreen)
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
}