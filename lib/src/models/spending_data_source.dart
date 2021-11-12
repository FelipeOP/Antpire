import 'package:antpire/src/models/spending.dart';
import 'package:antpire/src/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

List<Spending> spendings = [];

class SpendingDataSource extends DataGridSource {
  late CollectionReference<Map<String, dynamic>> collection;

  SpendingDataSource() {
    collection = Firestore().getAllSpendings();
    _buildDataRow();
  }

  Stream<QuerySnapshot> getStream() {
    // return collection.snapshots().asBroadcastStream();

    return collection.orderBy('name', descending: false).snapshots();
  }

  Future<void> buildStream(AsyncSnapshot snapShot) async {
    if (snapShot.hasError ||
        snapShot.data == null ||
        snapShot.data.docs.length == 0) {
      return Future<void>.value();
    }

    await Future.forEach(snapShot.data.docs,
        (DocumentSnapshot<Map<String, dynamic>> element) {
      final Spending data = Spending.fromSnapshot(element);
      if (!spendings.any((spending) => spending.name == data.name)) {
        spendings.add(data);
      }
    });

    updateDataGridDataSource();

    return Future<void>.value();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    _buildDataRow();
    notifyListeners();
  }

  void updateDataGridDataSource() {
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    _buildDataRow();
    notifyListeners();
  }

  late List<DataGridRow> spendingDataGridRows = [];

  @override
  List<DataGridRow> get rows => spendingDataGridRows;

  List<Spending> get dataSource => spendings;

  void _buildDataRow() {
    spendingDataGridRows = spendings
        .map<DataGridRow>((s) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: s.name),
              DataGridCell<int>(columnName: 'price', value: s.price),
              DataGridCell<String>(columnName: 'priority', value: s.priority),
              DataGridCell<DateTime>(columnName: 'date', value: s.date),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(
    DataGridRow row,
  ) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((s) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(s.value.toString()),
      );
    }).toList());
  }
}
