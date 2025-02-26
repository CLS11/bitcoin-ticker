import 'dart:io' show Platform;
import 'package:bitcoin/coin.dart';
import 'package:bitcoin/crypto_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'CNY';
  Map<String, String> coinValues = {'BTC': '?', 'ETH': '?', 'LTC': '?'};
  bool isWaiting = false;

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList
          .map((currency) => DropdownMenuItem(
            value: currency, 
            child: Text(currency),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: currenciesList.map((currency) => Text(currency)).toList(),
    );
  }

  void getData() async {
  setState(() {
    isWaiting = true;
  });
  
  try {
    var data = await CoinData().getCoin(selectedCurrency);
    setState(() {
      coinValues = Map<String, String>.from(data);
      isWaiting = false;
    });
  } catch (e) {
    print('Error fetching data: $e');
    setState(() {
      isWaiting = false;
    });
  }
}


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 186, 188),
      appBar: AppBar(title: const Center(child: Text('C O I N   T I C K E R'))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CryptoCard(
            value: isWaiting ? '?' : (coinValues['BTC'] ?? '?'),
            selectedCurrency: selectedCurrency,
            cryptoCurrency: 'BTC',
          ),
          CryptoCard(
            value: isWaiting ? '?' : (coinValues['ETH'] ?? '?'),
            selectedCurrency: selectedCurrency,
            cryptoCurrency: 'ETH',
          ),
          CryptoCard(
            value: isWaiting ? '?' : (coinValues['LTC'] ?? '?'),
            selectedCurrency: selectedCurrency,
            cryptoCurrency: 'LTC',
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30),
            color: const Color.fromARGB(255, 122, 121, 133),
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
