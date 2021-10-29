import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:antpire/config.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BalanceSheet extends StatefulWidget {
  const BalanceSheet({Key? key}) : super(key: key);

  @override
  State<BalanceSheet> createState() => _BalanceSheetState();
}

class Sales {
  String year;
  int sales;
  Sales(this.year, this.sales);
}

class _BalanceSheetState extends State<BalanceSheet> {
  late List<Sales> _data;
  late List<charts.Series<Sales, String>> _chartdata;

  void _makeData() {
    _data = <Sales>[];
    _chartdata = <charts.Series<Sales, String>>[];

    final rnd = Random();
    for (int i = 1; i < 5; i++) {
      _data.add(Sales(i.toString(), rnd.nextInt(1000)));
    }

    _chartdata.add(charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        data: _data,
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        displayName: 'sales'));
  }

  @override
  void initState() {
    _makeData();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Balances",
            style: GoogleFonts.josefinSans(
                textStyle: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold))),
        toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: Colors.red[400],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('¡Ahora ese dinero es mio!',
                style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold))),
          ),
          Image(
            image: const AssetImage('images/money.jpeg'),
            width: Config.screenWidth! * 0.7,
            height: Config.screenHeight! * 0.4,
          ),
          Container(
            width: Config.screenWidth! - 1,
            height: Config.screenHeight! * 0.1,
            color: Colors.white,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Gastos hormiga',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Container(
            width: Config.screenWidth! - 1,
            height: Config.screenHeight! * 0.10,
            color: Colors.white,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Gastos vampiro',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Container(
            width: Config.screenWidth! - 1,
            height: Config.screenHeight! * 0.30,
            color: Colors.white,
            child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Tus resultados',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Expanded(
                  child: charts.BarChart(_chartdata),
                )),
          ),
        ],
      ),
    );
  }
}
