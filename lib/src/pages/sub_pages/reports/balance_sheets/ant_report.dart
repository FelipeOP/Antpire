import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AntSpending {
  AntSpending(this.name, this.frequency, this.average, this.maximum,
      this.minimum, this.color);
  final String name;
  final int frequency;
  final int average;
  final int maximum;
  final int minimum;
  final Color color;
}

class AntExpensesReport extends StatefulWidget {
  const AntExpensesReport({
    Key? key,
  }) : super(key: key);
  static final GlobalKey<SfPyramidChartState> pyramidChartKey =
      GlobalKey<SfPyramidChartState>();
  static final GlobalKey<SfDataGridState> pyramidGridKey =
      GlobalKey<SfDataGridState>();

  @override
  State<AntExpensesReport> createState() => _PireExpenseReportState();
}

class _PireExpenseReportState extends State<AntExpensesReport> {
  static List<AntSpending> getAntSpendingsData() {
    return [
      AntSpending('Cafe', 12, 3200, 3800, 700, const Color(0x00ffbfaa)),
      AntSpending('Empanada', 15, 3500, 3700, 1200, const Color(0x00ff7b5a)),
      AntSpending('Cerveza', 10, 3000, 3500, 2800, const Color(0x00ff5232)),
      AntSpending('Tamal', 5, 5200, 5500, 4200, const Color(0x00d11507))
    ];
  }

  final TextStyle textStyle =
      GoogleFonts.josefinSans(fontSize: 12, fontWeight: FontWeight.bold);

  late AntSpendingDataSource _antDataSource;

  List<AntSpending> _antSpendings = <AntSpending>[];

  @override
  void initState() {
    super.initState();
    _antSpendings = getAntSpendingsData();
    _antDataSource = AntSpendingDataSource(antData: _antSpendings);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _pyramidChart(),
        _dataGrid(),
      ],
    );
  }

  SfDataGrid _dataGrid() {
    return SfDataGrid(
      key: AntExpensesReport.pyramidGridKey,
      source: _antDataSource,
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      // frozenColumnsCount: 1,
      tableSummaryRows: [
        GridTableSummaryRow(
            color: Colors.red[300],
            showSummaryInRow: true,
            title: 'Total promedio gastos hormiga: {Sum}',
            columns: [
              const GridSummaryColumn(
                  name: 'Sum',
                  columnName: 'Promedio',
                  summaryType: GridSummaryType.sum)
            ],
            position: GridTableSummaryRowPosition.bottom),
      ],
      columns: [
        GridColumn(
            columnName: 'Nombre',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'Nombre',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'Frecuencia',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Frecuencia',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'Promedio',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Promedio',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'Maximo',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'Mayor',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'Minimo',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'Menor',
                  overflow: TextOverflow.ellipsis,
                ))),
      ],
    );
  }

  SfPyramidChart _pyramidChart() {
    return SfPyramidChart(
        key: AntExpensesReport.pyramidChartKey,
        title: ChartTitle(text: 'Resumen gastos hormiga', textStyle: textStyle),
        legend: Legend(isVisible: true, textStyle: textStyle),
        series: PyramidSeries<AntSpending, String>(
          dataSource: _PireExpenseReportState.getAntSpendingsData(),
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
              useSeriesColor: true),
          pointColorMapper: (AntSpending spending, _) => spending.color,
          xValueMapper: (AntSpending data, _) => data.name,
          yValueMapper: (AntSpending data, _) => data.frequency,
        ));
  }
}

class AntSpendingDataSource extends DataGridSource {
  AntSpendingDataSource({required List<AntSpending> antData}) {
    _antSpedings = antData
        .map<DataGridRow>((s) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Nombre', value: s.name),
              DataGridCell<int>(columnName: 'Frecuencia', value: s.frequency),
              DataGridCell<int>(columnName: 'Promedio', value: s.average),
              DataGridCell<int>(columnName: 'Maximo', value: s.maximum),
              DataGridCell<int>(columnName: 'Minimo', value: s.minimum),
            ]))
        .toList();
  }

  List<DataGridRow> _antSpedings = [];

  @override
  List<DataGridRow> get rows => _antSpedings;

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(summaryValue),
    );
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
