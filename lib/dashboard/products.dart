import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

void main() {
  runApp(MaterialApp(
    home: ResponsiveDataTable(),
    debugShowCheckedModeBanner: false,
  ));
}

class ResponsiveDataTable extends StatefulWidget {
  @override
  _ResponsiveDataTableState createState() => _ResponsiveDataTableState();
}

class _ResponsiveDataTableState extends State<ResponsiveDataTable> {
  final List<Map<String, dynamic>> _data = [
    {"id": 1, "name": "Alice", "email": "alice@example.com", "role": "Admin"},
    {"id": 2, "name": "Bob", "email": "bob@example.com", "role": "User"},
    {"id": 3, "name": "Charlie", "email": "charlie@example.com", "role": "Editor"},
    {"id": 1, "name": "Alice", "email": "alice@example.com", "role": "Admin"},
    {"id": 2, "name": "Bob", "email": "bob@example.com", "role": "User"},
    {"id": 3, "name": "Charlie", "email": "charlie@example.com", "role": "Editor"},
    {"id": 1, "name": "Alice", "email": "alice@example.com", "role": "Admin"},
    {"id": 2, "name": "Bob", "email": "bob@example.com", "role": "User"},
    {"id": 3, "name": "Charlie", "email": "charlie@example.com", "role": "Editor"},
    {"id": 1, "name": "Alice", "email": "alice@example.com", "role": "Admin"},
    {"id": 2, "name": "Bob", "email": "bob@example.com", "role": "User"},
    {"id": 3, "name": "Charlie", "email": "charlie@example.com", "role": "Editor"},
    {"id": 1, "name": "Alice", "email": "alice@example.com", "role": "Admin"},
    {"id": 2, "name": "Bob", "email": "bob@example.com", "role": "User"},
    {"id": 3, "name": "Charlie", "email": "charlie@example.com", "role": "Editor"},
  ];

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _deleteItem(int id) {
    setState(() {
      _data.removeWhere((item) => item["id"] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    // Filter data based on search query
    List<Map<String, dynamic>> filteredData = _data
        .where((item) => item["name"].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Responsive Data Table")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: isSmallScreen ? _buildListView(filteredData) : _buildDataTable(filteredData),
            ),
          ],
        ),
      ),
    );
  }

  /// 📌 **ListView for Small Screens**
  Widget _buildListView(List<Map<String, dynamic>> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        var item = data[index];
        return Card(
          child: ListTile(
            title: Text(item["name"], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item["email"]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () {}),
                IconButton(icon: Icon(Icons.block, color: Colors.grey), onPressed: () {}),
                IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteItem(item["id"])),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 📌 **DataTable for Large Screens**
  Widget _buildDataTable(List<Map<String, dynamic>> data) {
    return PaginatedDataTable2(
      columns: [
        DataColumn(label: Text("ID"), numeric: true),
        DataColumn(label: Text("Name"), onSort: (index, _) {
          setState(() {
            data.sort((a, b) => a["name"].compareTo(b["name"]));
          });
        }),
        DataColumn(label: Text("Email")),
        DataColumn(label: Text("Role")),
        DataColumn(label: Text("Actions")),
      ],
      source: _DataTableSource(data, _deleteItem),
      rowsPerPage: 10, // Number of rows per page
      sortAscending: true,
    );
  }
}

/// 📌 **Custom Data Table Source for Pagination**
class _DataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final Function(int) onDelete;

  _DataTableSource(this.data, this.onDelete);

  @override
  DataRow getRow(int index) {
    final item = data[index];
    return DataRow(cells: [
      DataCell(Text(item["id"].toString())),
      DataCell(Text(item["name"])),
      DataCell(Text(item["email"])),
      DataCell(Text(item["role"])),
      DataCell(Row(
        children: [
          IconButton(icon: Icon(Icons.edit, color: Colors.green), onPressed: () {}),
          IconButton(icon: Icon(Icons.block, color: Colors.grey), onPressed: () {}),
          IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => onDelete(item["id"])),
        ],
      )),
    ]);
  }

  @override
  int get rowCount => data.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => 0;
}
