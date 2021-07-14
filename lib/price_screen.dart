import 'package:bitcoin_ticker_flutter_project/price_field.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_flutter_project/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late CoinData coinData;

  late String selectedValue = 'USD';
  late String rateValueBTC = 'undefined';
  late String rateValueETH = 'undefined';
  late String rateValueLTE = 'undefined';

  DropdownButton<String> androidPickerItem() {
    List<DropdownMenuItem<String>> dropMenuItems = [];
    for (String item in currenciesList) {
      DropdownMenuItem<String> dropdownMenuItem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      dropMenuItems.add(dropdownMenuItem);
    }
    return DropdownButton<String>(
      value: selectedValue,
      items: dropMenuItems,
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
          exchangeRates();
        });
      },
    );
  }

  CupertinoPicker iosPickerItem() {
    List<Widget> dropMenuItems = [];
    for (String item in currenciesList) {
      Text text = Text(
        item,
        style: TextStyle(color: Colors.white),
      );
      dropMenuItems.add(text);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedValue = currenciesList[selectedIndex];
          exchangeRates();
        });
      },
      children: dropMenuItems,
    );
  }

  @override
  void initState() {
    super.initState();
    coinData = CoinData();
    exchangeRates();
  }

  void exchangeRates() async {
    coinData.setAssetIdQuote(selectedValue);
    for (String baseValue in cryptoList) {
      coinData.setAssetIdBase(baseValue);
      dynamic response = await coinData.getExchangeRates();
      if (response != null) {
        double rate = response['rate'];
        setState(() {
          switch (baseValue) {
            case baseValueBTC:
              {
                rateValueBTC = rate.toStringAsFixed(1);
                break;
              }
            case baseValueETH:
              {
                rateValueETH = rate.toStringAsFixed(1);
                break;
              }
            case baseValueLTE:
              {
                rateValueLTE = rate.toStringAsFixed(1);
                break;
              }
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                PriceField(
                    baseValue: baseValueBTC,
                    selectedValue: selectedValue,
                    rateValue: rateValueBTC),
                PriceField(
                    baseValue: baseValueETH,
                    selectedValue: selectedValue,
                    rateValue: rateValueETH),
                PriceField(
                    baseValue: baseValueLTE,
                    selectedValue: selectedValue,
                    rateValue: rateValueLTE),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iosPickerItem(),
          ),
        ],
      ),
    );
  }
}
//===============Style Drop Down Android=================
// DropdownButton<String>(
// value: selectedValue,
// items: getDropdownMenuItem(),
// onChanged: (value) {
// setState(() {
// selectedValue = value!;
// });
// },
// ),

//================Style Dropdown IOS(Cuoertino)=============
// CupertinoPicker(
// itemExtent: 32.0,
// onSelectedItemChanged: (selectedIndex) {
// },
// children: getListItemWithCupertino(),
// ),

//===============Get Platform Current=========
//Platform.isIOS ? iosPickerItem() : androidPickerItem(),
