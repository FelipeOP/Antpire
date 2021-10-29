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
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<int>(columnName: 'price', value: e.price),
              DataGridCell<String>(columnName: 'priority', value: e.priority),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(
    DataGridRow row,
  ) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  dynamic newCellValue;

  @override
  bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    // Return false, to retain in edit mode.
    return true; // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value ??
        '';

    final int dataRowIndex = spendingDataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'name') {
      spendingDataGridRows[dataRowIndex]
              .getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'name', value: newCellValue);
      spendings[dataRowIndex].price = newCellValue as int;
    } else if (column.columnName == 'price') {
      spendingDataGridRows[dataRowIndex]
              .getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'price', value: newCellValue);
      spendings[dataRowIndex].name = newCellValue.toString();
    } else if (column.columnName == 'priority') {
      spendingDataGridRows[dataRowIndex]
              .getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'priority', value: newCellValue);
      spendings[dataRowIndex].priority = newCellValue.toString();
    }
  }

  TextEditingController editingController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget

    final String displayText = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value
            ?.toString() ??
        '';

    newCellValue = null;

    final bool isNumericKeyBoardType = column.columnName == 'price';

    return Form(
      key: _formKey,
      child: TextFormField(
        autofocus: true,
        controller: editingController..text = displayText.toString(),
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
        keyboardType:
            isNumericKeyBoardType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericKeyBoardType) {
              newCellValue = int.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onFieldSubmitted: (String value) {
          // In Mobile Platform.
          // Call [CellSubmit] callback to fire the canSubmitCell and
          // onCellSubmit to commit the new value in single place.
          // submitCell();
        },
      ),
    );
  }
}
