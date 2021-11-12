import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:antpire/config.dart';
import 'package:antpire/src/pages/sub_pages/reports/balance_sheets/pire_report.dart';
import 'package:antpire/src/pages/sub_pages/reports/balance_sheets/ant_report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class BalanceSheet extends StatefulWidget {
  const BalanceSheet({Key? key}) : super(key: key);

  @override
  State<BalanceSheet> createState() => _BalanceSheetState();
}

class _BalanceSheetState extends State<BalanceSheet> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: <Widget>[
          _balanceText(),
          _balanceImage(),
          _antExpenses(),
          _pireExpenses(),
          _results(),
        ],
      ),
    );
  }

  Padding _balanceText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text('¡Ahora ese dinero es mio!',
          style: GoogleFonts.josefinSans(
              textStyle:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
    );
  }

  Image _balanceImage() {
    return Image(
      image: const AssetImage('images/money.jpeg'),
      width: Config.screenWidth! * 0.4,
      height: Config.screenHeight! * 0.4,
    );
  }

  Container _antExpenses() {
    return Container(
      // width: Config.screenWidth! - 1,
      // height: Config.screenHeight! * 0.30,
      color: Colors.white,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Gastos hormiga',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const AntExpensesReport(),
      ),
    );
  }

  Widget _pireExpenses() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        // width: Config.screenWidth! - 1,
        // height: Config.screenHeight! * 0.30,
        color: Colors.white,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Gastos vampiro',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const PireExpensesReport(),
        ),
      ),
    );
  }

  Widget _results() {
    return Container(
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
            child: _exportToPdf()));
  }

  Widget _exportToPdf() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12.5)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.black),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.red.shade800),
        ),
        onPressed: () {
          _renderPyramidPDF();
        },
        child: const Text('Exportar a PDF',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> _renderPyramidPDF() async {
    Directory? directory = await getExternalStorageDirectory();
    String path = directory!.path;
    File file = File('$path/report.pdf');
    PdfDocument document = PdfDocument();
    //PdfPage page = document.pages.insert(0);

    var pyramidChartKey = AntExpensesReport.pyramidChartKey;
    var pyramidGridKey = AntExpensesReport.pyramidGridKey;
    var funnelChartKey = PireExpensesReport.funnelChartKey;
    var funnelGridKey = PireExpensesReport.funnelGridKey;

    // PdfDocument document = pyramidGridKey.currentState!.exportToPdfDocument();
    PdfPage page1 = document.pages.add();
    PdfPage page2 = document.pages.add();

    ui.Image data =
        await pyramidChartKey.currentState!.toImage(pixelRatio: 4.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    page1.graphics.drawImage(
        PdfBitmap(imageBytes), const Rect.fromLTWH(100, 0, 300, 300));

    PdfGrid pdfGrid = pyramidGridKey.currentState!.exportToPdfGrid();
    pdfGrid.draw(
      page: page1,
      bounds: const Rect.fromLTWH(100, 300, 500, 500),
    );

    ui.Image data2 =
        await funnelChartKey.currentState!.toImage(pixelRatio: 4.0);
    final bytes2 = await data2.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes2 =
        bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);
    page2.graphics.drawImage(
        PdfBitmap(imageBytes2), const Rect.fromLTWH(100, 0, 300, 300));

    PdfGrid pdfGrid2 = funnelGridKey.currentState!.exportToPdfGrid();
    pdfGrid2.draw(
      page: page2,
      bounds: const Rect.fromLTWH(100, 300, 0, 0),
    );

    await file.writeAsBytes(document.save());
    document.dispose();
    OpenFile.open('$path/report.pdf');
  }
}
