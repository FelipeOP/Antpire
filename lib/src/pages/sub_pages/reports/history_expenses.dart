import 'package:antpire/config.dart';
import 'package:antpire/src/models/spending.dart';
import 'package:antpire/src/models/spending_data_source.dart';
import 'package:antpire/src/pages/sub_pages/expenses/register_expenses_page.dart';
import 'package:antpire/src/pages/sub_pages/reports/update_expense.dart';
import 'package:antpire/src/services/firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GridTable extends StatefulWidget {
  const GridTable({Key? key}) : super(key: key);

  @override
  _GridTableState createState() => _GridTableState();
}

class _GridTableState extends State<GridTable> {
  late SpendingDataSource _spendingDataSource;
  late DataGridController _dataGridController;
  @override
  void initState() {
    super.initState();
    _spendingDataSource = SpendingDataSource();
    _spendingDataSource.refresh();
    _dataGridController = DataGridController();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Historial',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            toolbarHeight: 50,
            backgroundColor: Colors.red[400],
            centerTitle: true,
          ),
          body: _buildDataGrid()),
    );
  }

  Widget _buildDataGrid() {
    Config().init(context);
    return StreamBuilder<QuerySnapshot>(
        stream: _spendingDataSource.getStream(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          _spendingDataSource.buildStream(snapshot);
          if (snapshot.hasData) {
            return SfDataGrid(
              controller: _dataGridController,
              startSwipeActionsBuilder: startSwipeActions,
              endSwipeActionsBuilder: endSwipeActions,
              allowSwiping: true,
              swipeMaxOffset: 150,
              source: _spendingDataSource,
              allowSorting: true,
              allowPullToRefresh: true,
              columnWidthMode: ColumnWidthMode.fill,
              columns: _gridColumns,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  int __spendingIndex(int rowIndex) {
    int spendingIndex = spendings.indexWhere((spending) =>
        spending.name ==
        _spendingDataSource.spendingDataGridRows
            .elementAt(rowIndex)
            .getCells()
            .elementAt(0)
            .value);
    return spendingIndex;
  }

  Future<void> deleteSpending(int rowIndex) async {
    // Remove table row locally
    int spendingIndex = __spendingIndex(rowIndex);
    _spendingDataSource.spendingDataGridRows.removeAt(rowIndex);
    if (!spendingIndex.isNegative) {
      Firestore().deleteSpending(spendings.elementAt(spendingIndex));
      // Remove Spending Object locally
      spendings.removeAt(spendingIndex);
      _spendingDataSource.updateDataGridDataSource();
    }
  }

  AwesomeDialog editSpendingData(Spending spending) {
    return AwesomeDialog(
      // customHeader: CircleAvatar(
      //     radius: Config.screenHeight! * 0.1,
      //     backgroundImage: const AssetImage('images/yo.jpeg'),
      //     backgroundColor: Colors.white),
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO_REVERSED,
      body: UpdateExpensesPage(spending: spending),
      showCloseIcon: true,
      title: 'This is Ignored',
      desc: 'This is also Ignored',
    )..show();
  }

  Widget startSwipeActions(BuildContext context, DataGridRow row, int index) {
    return GestureDetector(
        onTap: () {
          int spendingIndex = __spendingIndex(index);
          editSpendingData(spendings.elementAt(spendingIndex));
          _spendingDataSource.updateDataGridDataSource();
        },
        child: Container(
            color: Colors.green,
            padding: const EdgeInsets.only(left: 30.0),
            alignment: Alignment.centerLeft,
            child: const Text('Editar',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))));
  }

  Widget endSwipeActions(BuildContext context, DataGridRow row, int index) {
    return GestureDetector(
        onTap: () {
          deleteSpending(index);
        },
        child: Container(
            color: Colors.red,
            padding: const EdgeInsets.only(left: 30.0),
            alignment: Alignment.centerLeft,
            child: const Text('Eliminar',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))));
  }

  List<GridColumn> get _gridColumns {
    return <GridColumn>[
      GridColumn(
          columnName: 'name',
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text('Nombre', overflow: TextOverflow.ellipsis
                  //style: TextStyle(color: red, fontSize: 20),
                  ))),
      GridColumn(
          columnName: 'price',
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text('Precio', overflow: TextOverflow.ellipsis
                  //style: TextStyle(color: red, fontSize: 20),
                  ))),
      GridColumn(
          columnName: 'priority',
          label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text('Prioridad', overflow: TextOverflow.ellipsis
                  //style: TextStyle(color: red, fontSize: 20),
                  )))
    ];
  }
}
