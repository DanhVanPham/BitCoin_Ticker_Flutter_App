import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseValueBTC = 'BTC';
const String baseValueLTE = 'LTC';
const String baseValueETH = 'ETH';

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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String baseUrl = "https://rest.coinapi.io/v1/exchangerate";

class CoinData {
  String _apiKey = "9632D2C9-715B-4BA3-87DC-3C74A19A1EEB";
  late String _assetIdBase;
  late String _assetIdQuote;

  String getAssetIdBase() {
    return this._assetIdBase;
  }

  void setAssetIdBase(String assetIdBase) {
    this._assetIdBase = assetIdBase;
  }

  String getAssetIdQuote() {
    return this._assetIdQuote;
  }

  void setAssetIdQuote(String assetIdQuote) {
    this._assetIdQuote = assetIdQuote;
  }

  dynamic getExchangeRates() async {
    http.Response response = await http.get(Uri.parse(
        '$baseUrl/${this._assetIdBase}/${this._assetIdQuote}?apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
