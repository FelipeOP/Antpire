import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PireSpending {
  PireSpending(this.name, this.percentage, this.price, this.salary, this.color);
  final String name;
  final double percentage;
  final int price;
  final int salary;
  final Color color;
}

class PireExpensesReport extends StatefulWidget {
  const PireExpensesReport({
    Key? key,
  }) : super(key: key);

  static final GlobalKey<SfFunnelChartState> funnelChartKey =
      GlobalKey<SfFunnelChartState>();

  static final GlobalKey<SfDataGridState> funnelGridKey =
      GlobalKey<SfDataGridState>();

  @override
  State<PireExpensesReport> createState() => _PireExpensesReportState();
}

class _PireExpensesReportState extends State<PireExpensesReport> {
  static List<PireSpending> getPireSpendingData() => [
        PireSpending(
            'Spotify',
            double.parse((30000 * 100 / 900000).toStringAsFixed(2)),
            30000,
            900000,
            const Color(0x00ffbfaa)),
        PireSpending(
            'Netflix',
            double.parse((18000 * 100 / 900000).toStringAsFixed(2)),
            18000,
            900000,
            const Color(0x00ff7b5a)),
        PireSpending(
            'GamePass',
            double.parse((48000 * 100 / 900000).toStringAsFixed(2)),
            48000,
            900000,
            const Color(0x00ff5232)),
        PireSpending(
            'KFC',
            double.parse((42000 * 100 / 900000).toStringAsFixed(2)),
            42000,
            900000,
            const Color(0x00d11507))
      ];

  final TextStyle textStyle =
      GoogleFonts.josefinSans(fontSize: 12, fontWeight: FontWeight.bold);

  late PireSpendingDataSource _antDataSource;

  List<PireSpending> _pireSpengings = <PireSpending>[];

  @override
  void initState() {
    super.initState();
    _pireSpengings = getPireSpendingData();
    _antDataSource = PireSpendingDataSource(pireData: _pireSpengings);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_funnelChart(), _dataGrid()],
    );
  }

  SfFunnelChart _funnelChart() {
    return SfFunnelChart(
        key: PireExpensesReport.funnelChartKey,
        title: ChartTitle(
            text: 'Resumen gastos vampiro (%)', textStyle: textStyle),
        legend: Legend(
            isVisible: true,
            textStyle: textStyle,
            position: LegendPosition.right,
            isResponsive: true),
        series: FunnelSeries<PireSpending, String>(
            dataSource: _PireExpensesReportState.getPireSpendingData(),
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.inside,
                useSeriesColor: true),
            pointColorMapper: (PireSpending spending, _) => spending.color,
            xValueMapper: (PireSpending data, _) => data.name,
            yValueMapper: (PireSpending data, _) => data.percentage));
  }

  SfDataGrid _dataGrid() {
    return SfDataGrid(
      key: PireExpensesReport.funnelGridKey,
      source: _antDataSource,
      columnWidthMode: ColumnWidthMode.fitByColumnName,
      // frozenColumnsCount: 1,
      tableSummaryRows: [
        GridTableSummaryRow(
            color: Colors.red[300],
            showSummaryInRow: true,
            title: 'Total gastos vampiro: {sum}',
            columns: [
              const GridSummaryColumn(
                  name: 'sum',
                  columnName: 'Precio',
                  summaryType: GridSummaryType.sum)
            ],
            position: GridTableSummaryRowPosition.bottom),
        GridTableSummaryRow(
            color: Colors.red[300],
            showSummaryInRow: true,
            title: "Estimación anual de gastos vampiro: ${r"$1'656.000"}",
            columns: [
              const GridSummaryColumn(
                  name: 'sum',
                  columnName: 'total',
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
            columnName: 'Precio',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Precio',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'Sueldo',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Sueldo',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'Porcentaje',
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center,
                child: const Text(
                  'Porcentaje',
                  overflow: TextOverflow.ellipsis,
                )))
      ],
    );
  }
}

class PireSpendingDataSource extends DataGridSource {
  PireSpendingDataSource({required List<PireSpending> pireData}) {
    _pireSpendings = pireData
        .map<DataGridRow>((s) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Nombre', value: s.name),
              DataGridCell<int>(columnName: 'Precio', value: s.price),
              DataGridCell<int>(columnName: 'Sueldo', value: s.salary),
              DataGridCell<double>(
                  columnName: 'Porcentaje', value: s.percentage),
            ]))
        .toList();
  }

  List<DataGridRow> _pireSpendings = [];

  @override
  List<DataGridRow> get rows => _pireSpendings;

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
