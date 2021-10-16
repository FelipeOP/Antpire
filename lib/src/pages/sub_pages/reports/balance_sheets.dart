import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BalanceSheet extends StatelessWidget {
  const BalanceSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('!Ahora ese dinero es mio¡',
                style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          const CircleAvatar(
            radius: 130.0,
            backgroundImage: AssetImage('images/home.jpeg'),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
