import 'package:bitcoin/price_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BitcoinTicker());
}

class BitcoinTicker extends StatelessWidget {
  const BitcoinTicker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white,
      ),
      home: PriceScreen(),
    );
  }
}