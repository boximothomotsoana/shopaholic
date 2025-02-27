import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedSort = 'Best Sellers';
  RangeValues priceRange = RangeValues(10, 1000);
  List<String> selectedCategories = [];
  List<String> selectedColors = [];
  TextEditingController searchController = TextEditingController();
  bool showSearch = false;

  final List<String> categories = ['Electronics', 'Clothing', 'Shoes', 'Accessories'];
  final List<String> colors = ['Red', 'Blue', 'Green', 'Black', 'White'];
  final List<String> sortOptions = ['Best Sellers', 'Sales', 'New Arrivals', 'Limited Offers', 'Exclusive Deals'];

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        actions: [
          if (isDesktop)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 200,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            )
          else
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Search Products'),
                    content: TextField(
                      controller: searchController,
                      decoration: InputDecoration(hintText: 'Enter product name'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Text('Search'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              if (isDesktop)
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: _buildFilters(),
                  ),
                ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    if (!isDesktop)
                      ExpansionTile(
                        title: Text('Filters'),
                        children: [_buildFilters()],
                      ),
                    Expanded(
                      child: _buildProductGrid(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sort by', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton(
            value: selectedSort,
            items: sortOptions.map((option) {
              return DropdownMenuItem(value: option, child: Text(option));
            }).toList(),
            onChanged: (value) {
              setState(() => selectedSort = value!);
            },
          ),
          Divider(),
          Text('Price Range', style: TextStyle(fontWeight: FontWeight.bold)),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 2000,
            divisions: 20,
            labels: RangeLabels('\$${priceRange.start.toStringAsFixed(0)}', '\$${priceRange.end.toStringAsFixed(0)}'),
            onChanged: (RangeValues values) {
              setState(() => priceRange = values);
            },
          ),
          Divider(),
          Text('Categories', style: TextStyle(fontWeight: FontWeight.bold)),
          Column(
            children: categories.map((category) {
              return CheckboxListTile(
                title: Text(category),
                value: selectedCategories.contains(category),
                onChanged: (bool? value) {
                  setState(() {
                    value == true ? selectedCategories.add(category) : selectedCategories.remove(category);
                  });
                },
              );
            }).toList(),
          ),
          Divider(),
          Text('Colors', style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            children: colors.map((color) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: FilterChip(
                  label: Text(color),
                  selected: selectedColors.contains(color),
                  onSelected: (bool selected) {
                    setState(() {
                      selected ? selectedColors.add(color) : selectedColors.remove(color);
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Icon(Icons.image, size: 50)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('\$99.99', style: TextStyle(color: Colors.green)),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Add to Cart'),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
