import 'package:flutter/material.dart';

class UsersDataTable extends StatefulWidget {
  @override
  _UsersDataTableState createState() => _UsersDataTableState();
}

class _UsersDataTableState extends State<UsersDataTable> {
  final List<Map<String, String>> data = [
    {"name": "John Doe", "email": "john@example.com", "phone": "087 501 6037", "bio": "Testing application"},
    {"name": "Jane Smith", "email": "jane@example.com", "phone": "087 501 6038", "bio": "Testing application"},
    {"name": "Michael Brown", "email": "michael@example.com", "phone": "087 501 6039", "bio": "Testing application"},
    {"name": "Laura Jones", "email": "laura@example.com", "phone": "087 501 6040", "bio": "Testing application"},
    {"name": "Peter White", "email": "peter@example.com", "phone": "087 501 6041", "bio": "Testing application"},
    {"name": "Sarah Green", "email": "sarah@example.com", "phone": "087 501 6042", "bio": "Testing application"},
    // Add more rows to simulate large data
  ];

  String searchQuery = "";
  int rowsPerPage = 5; // Number of rows per page
  int currentPage = 0; // Current page number
  String sortColumn = "name";
  bool isAscending = true;

  List<Map<String, String>> get filteredData {
    final filtered = data
        .where((row) => row.values.any(
            (value) => value.toLowerCase().contains(searchQuery.toLowerCase())))
        .toList();

    filtered.sort((a, b) {
      if (isAscending) {
        return a[sortColumn]!.compareTo(b[sortColumn]!);
      } else {
        return b[sortColumn]!.compareTo(a[sortColumn]!);
      }
    });

    return filtered;
  }

  List<Map<String, String>> get paginatedData {
    final startIndex = currentPage * rowsPerPage;
    final endIndex =
    (startIndex + rowsPerPage).clamp(0, filteredData.length);
    return filteredData.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users Data Table")),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    currentPage = 0; // Reset to first page on search
                  });
                },
              ),
            ),

            // Data Table or List View
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    // Large screens: Paginated DataTable
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        sortColumnIndex:
                        ["name", "email", "phone", "bio"].indexOf(sortColumn),
                        sortAscending: isAscending,
                        columns: [
                          DataColumn(
                            label: Text("Name"),
                            onSort: (index, _) => _onSort("name"),
                          ),
                          DataColumn(
                            label: Text("Email"),
                            onSort: (index, _) => _onSort("email"),
                          ),
                          DataColumn(
                            label: Text("Phone"),
                            onSort: (index, _) => _onSort("phone"),
                          ),
                          DataColumn(
                            label: Text("Bio"),
                            onSort: (index, _) => _onSort("bio"),
                          ),
                          DataColumn(
                            label: Text("Actions"),
                          ),
                        ],
                        rows: paginatedData.map((row) {
                          return DataRow(cells: [
                            DataCell(Text(row["name"]!)),
                            DataCell(Text(row["email"]!)),
                            DataCell(Text(row["phone"]!)),
                            DataCell(Text(row["bio"]!)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: () =>
                                        _onActionPressed("View", row),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () =>
                                        _onActionPressed("Edit", row),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.block),
                                    onPressed: () =>
                                        _onActionPressed("Block", row),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () =>
                                        _onActionPressed("Delete", row),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    );
                  } else {
                    // Small screens: List View
                    return ListView(
                      children: paginatedData.map((row) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${row["name"]}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold)),
                                Text("Email: ${row["email"]}"),
                                Text("Phone: ${row["phone"]}"),
                                Text("Bio: ${row["bio"]}"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () =>
                                          _onActionPressed("View", row),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () =>
                                          _onActionPressed("Edit", row),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.block),
                                      onPressed: () =>
                                          _onActionPressed("Block", row),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () =>
                                          _onActionPressed("Delete", row),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),

            // Pagination Controls
            if (filteredData.length > rowsPerPage)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: currentPage > 0
                        ? () {
                      setState(() {
                        currentPage--;
                      });
                    }
                        : null,
                  ),
                  Text("Page ${currentPage + 1} of ${(filteredData.length / rowsPerPage).ceil()}"),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: currentPage < (filteredData.length / rowsPerPage).ceil() - 1
                        ? () {
                      setState(() {
                        currentPage++;
                      });
                    }
                        : null,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _onSort(String column) {
    setState(() {
      if (sortColumn == column) {
        isAscending = !isAscending;
      } else {
        sortColumn = column;
        isAscending = true;
      }
    });
  }

  void _onActionPressed(String action, Map<String, String> row) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$action pressed for ${row['name']}")),
    );
  }
}
