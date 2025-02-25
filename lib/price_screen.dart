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

  List<DropdownMenuItem<String>> getCurrencies() {
    final dropdownItems = <DropdownMenuItem<String>>[];
    for (var i = 0; i < currenciesList.length; i++) {
      final currency = currenciesList[i];
      final newItem = DropdownMenuItem(
        value: currency, 
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  List<Widget> getPickerItems(){
    final pickerItems = <Widget>[];
    for (var i = 0; i < currenciesList.length; i++){
      final currency = currenciesList[i];
      final newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return pickerItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 186, 188),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'C O I N   T I C K E R',
            ),
          ),
        ),
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
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30),
            color: const Color.fromARGB(255, 122, 121, 133),
            child: CupertinoPicker(
              itemExtent: 32,
              onSelectedItemChanged: (selectedIndex) {
                print(selectedIndex);
              },
              children: getPickerItems(),
            ),
          ),
        ],
      ),
    );
  }
}

// DropdownButton<String>(
//               value: selectedCurrency,
//               items: getCurrencies(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedCurrency = value!;
//                 });
//               },
//             ),