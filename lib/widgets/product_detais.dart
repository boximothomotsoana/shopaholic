import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  void _showProductDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ProductDetails();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showProductDetails(context),
          child: Text('Show Product Details'),
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            controller: scrollController,
            children: [
              Image.network('https://via.placeholder.com/300'),
              SizedBox(height: 16.0),
              Text(
                'Product Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'This is the product description. It provides detailed information about the product features, specifications, and other relevant details.',
              ),
              SizedBox(height: 16.0),
              QuantitySelector(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).addToCart();
                  Navigator.pop(context);
                },
                child: Text('Add to Cart'),
              ),
              SizedBox(height: 16.0),
              Divider(),
              Text(
                'Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ReviewSection(),
            ],
          ),
        );
      },
    );
  }
}

class QuantitySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Quantity'),
        Row(
          children: [
            IconButton(
              onPressed: cart.decreaseQuantity,
              icon: Icon(Icons.remove),
            ),
            Text(cart.quantity.toString()),
            IconButton(
              onPressed: cart.increaseQuantity,
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

class ReviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Review(
          rating: 4.5,
          comment: 'Great product! Highly recommend it.',
        ),
        Review(
          rating: 3.0,
          comment: 'Good, but could be better.',
        ),
      ],
    );
  }
}

class Review extends StatelessWidget {
  final double rating;
  final String comment;

  Review({required this.rating, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 20.0,
        ),
        SizedBox(height: 4.0),
        Text(comment),
        SizedBox(height: 16.0),
      ],
    );
  }
}

class CartProvider with ChangeNotifier {
  int quantity = 1;

  void increaseQuantity() {
    quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
    notifyListeners();
  }

  void addToCart() {
    // Implement add to cart logic here
  }
}
