import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  // Example payment methods
  List<Map<String, dynamic>> paymentMethods = [
    {"name": "Credit Card", "isActive": true},
    {"name": "PayPal", "isActive": false},
    {"name": "Bank Transfer", "isActive": true},
  ];

  final TextEditingController _addPaymentController = TextEditingController();

  void _addPaymentMethod(String methodName) {
    if (methodName.isNotEmpty) {
      setState(() {
        paymentMethods.add({"name": methodName, "isActive": false});
      });
      _addPaymentController.clear();
    }
  }

  void _toggleActivation(int index) {
    setState(() {
      paymentMethods[index]["isActive"] = !paymentMethods[index]["isActive"];
    });
  }

  void _deletePaymentMethod(int index) {
    setState(() {
      paymentMethods.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Payment Methods')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add Payment Method Field
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _addPaymentController,
                          decoration: InputDecoration(
                            hintText: "Add new payment method",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          _addPaymentMethod(_addPaymentController.text);
                        },
                        child: Text("Add"),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Responsive Payment Methods List/Table
                  Expanded(
                    child: constraints.maxWidth > 600
                        ? _buildTableView()
                        : _buildListView(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Build Table View for Larger Screens
  Widget _buildTableView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text("Payment Method")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Actions")),
        ],
        rows: paymentMethods.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> method = entry.value;
          return DataRow(cells: [
            DataCell(Text(method["name"])),
            DataCell(
              Switch(
                value: method["isActive"],
                onChanged: (value) => _toggleActivation(index),
              ),
            ),
            DataCell(
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editPaymentMethod(context, index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deletePaymentMethod(index),
                  ),
                ],
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }

  // Build List View for Smaller Screens
  Widget _buildListView() {
    return ListView.builder(
      itemCount: paymentMethods.length,
      itemBuilder: (context, index) {
        final method = paymentMethods[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Payment Method: ${method['name']}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Status: "),
                        Switch(
                          value: method["isActive"],
                          onChanged: (value) => _toggleActivation(index),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editPaymentMethod(context, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deletePaymentMethod(index),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Edit Payment Method
  void _editPaymentMethod(BuildContext context, int index) {
    final TextEditingController _editController =
    TextEditingController(text: paymentMethods[index]["name"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Payment Method"),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(
              hintText: "Enter new name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  paymentMethods[index]["name"] = _editController.text;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
