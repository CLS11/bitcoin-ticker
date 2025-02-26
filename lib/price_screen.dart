import 'dart:io' show Platform;
import 'package:bitcoin/coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var bitcoinValueInUSD;

  DropdownButton<String> andriodDropdown() {
    final dropdownItems = <DropdownMenuItem<String>>[];
    for (var i = 0; i < currenciesList.length; i++) {
      final currency = currenciesList[i];
      final newItem = DropdownMenuItem(value: currency, child: Text(currency));
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    final pickerItems = <Widget>[];
    for (var i = 0; i < currenciesList.length; i++) {
      final currency = currenciesList[i];
      final newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  void getData() async {
    try {
      var data = await CoinData().getCoin();
      if(data != null){
        setState(() {
        bitcoinValueInUSD = data.toStringAsFixed(0);
         });
      }
    } catch (e) {
      print(e);
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
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Card(
              color: const Color.fromARGB(255, 44, 36, 67),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                child: Text(
                  '1 BTC = $bitcoinValueInUSD USD',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30),
            color: const Color.fromARGB(255, 122, 121, 133),
            child: Platform.isIOS ? iOSPicker() : andriodDropdown(),
          ),
        ],
      ),
    );
  }
}
