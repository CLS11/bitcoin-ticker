import 'dart:convert';
import 'package:bitcoin/api_key.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';


class CoinData {
  CoinData({this.selectedCurrency});
  String? selectedCurrency;
  Future<Map<String, String>> getCoin(String selectedCurrency) async  {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      final requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$APIKey';
      final response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final double lastPrice = (decodedData['rate'] as num).toDouble();
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem';
      }
    }
    return cryptoPrices;
  }
}
