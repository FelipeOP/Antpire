// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:antpire/src/pages/sub_pages/reports/product_prov.dart';

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  final String title = "Historial de gastos";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  late List<Product_prov> products;
  late List<Product_prov> selectedProduct;
  late bool sort;

  @override
  void initState() {
    sort = false;
    selectedProduct = [];
    products = Product_prov.getUsers();
    super.initState();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        products.sort((a, b) => a.nameProduct.compareTo(b.nameProduct));
      } else {
        products.sort((a, b) => b.nameProduct.compareTo(a.nameProduct));
      }
    }
  }

  onSelectedRow(bool selected, Product_prov product) async {
    setState(() {
      if (selected) {
        selectedProduct.add(product);
      } else {
        selectedProduct.remove(product);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedProduct.isNotEmpty) {
        List<Product_prov> temp = [];
        temp.addAll(selectedProduct);
        for (Product_prov product in temp) {
          products.remove(product);
          selectedProduct.remove(product);
        }
      }
    });
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dataTextStyle: GoogleFonts.josefinSans(color: Colors.black),
        dataRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return Colors.white;
        }),
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("Descripción",
                  style: GoogleFonts.josefinSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              numeric: false,
              tooltip: "This is product name",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColum(columnIndex, ascending);
              }),
          DataColumn(
            label: Text(
              "Precio",
              style: GoogleFonts.josefinSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            numeric: true,
            tooltip: "This is the price of the product",
          ),
          DataColumn(
              label: Text(
                "Prioridad",
                style: GoogleFonts.josefinSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              numeric: false,
              tooltip: "This is the priority of the product",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColum(columnIndex, ascending);
              })
        ],
        rows: products
            .map(
              (product) => DataRow(
                  selected: selectedProduct.contains(product),
                  onSelectChanged: (b) {
                    print("Onselect");
                    onSelectedRow(b!, product);
                  },
                  cells: [
                    DataCell(
                      Text(product.nameProduct),
                      onTap: () {
                        print('Selected ${product.nameProduct}');
                      },
                    ),
                    DataCell(
                      Text(product.price.toString()),
                    ),
                    DataCell(
                      Text(product.priority),
                      /*  onTap: () {
                        print('Selected ${product.priority}'); */
                      // },
                    ),
                  ]),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 10),
                      primary: Colors.red,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)))),
                  label: Text('Seleccionar ${selectedProduct.length}'),
                  icon: const Icon(Icons.select_all_rounded),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(130, 20),
                      primary: Colors.red,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)))),
                  icon: const Icon(Icons.delete_rounded),
                  label: Text('Eliminar'),
                  onPressed: selectedProduct.isEmpty
                      ? null
                      : () {
                          deleteSelected();
                        },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
