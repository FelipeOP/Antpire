import 'package:antpire/config.dart';
import 'package:antpire/src/pages/sub_pages/reports/balance_sheets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history_expenses.dart';

class SpendingPage extends StatelessWidget {
  const SpendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage('images/engineer.jpeg'),
          width: Config.screenWidth! * 0.75,
          height: Config.screenHeight! * 0.40,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('¿Cómo va todo?',
              style: GoogleFonts.josefinSans(
                  textStyle: const TextStyle(
                      fontSize: 31, fontWeight: FontWeight.bold))),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(550, 10),
                  primary: Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
              icon: const Icon(Icons.arrow_right),
              label: const Text('Historial de gastos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onPressed: () {
                Get.to(() => const GridTable());
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(550, 10),
                  primary: Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
              icon: const Icon(Icons.arrow_right),
              label: const Text('Reporte de gastos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onPressed: () {
                // Firestore().getAllSpendings();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(550, 10),
                  primary: Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
              icon: const Icon(Icons.arrow_right),
              label: const Text('Balances',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onPressed: () {
                Get.to(() => const BalanceSheet());
              }),
        ),
      ],
    );
  }
}
