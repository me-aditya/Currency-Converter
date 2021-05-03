import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'api_handling.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

ApiHandling apiHandling = new ApiHandling();
var apiData;

String value = "?";

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String element in currenciesList) {
      var list = DropdownMenuItem(
        child: Text(element),
        value: element,
      );

      dropdownItems.add(list);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) async {
        apiData = await apiHandling.getData(selectedCurrency);
        setState(() {
          selectedCurrency = value;

          updateUI(apiData["src_side_base"][0]["rate"]);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> currencies = [];

    for (String currency in currenciesList) {
      currencies.add(Text(currency));
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (onSelectedItemChanged) async {
          apiData = await apiHandling.getData(selectedCurrency);
          setState(()  {
            selectedCurrency = currenciesList[onSelectedItemChanged];
            print(apiData);
            updateUI(apiData["src_side_base"][0]["rate"]);
          });
        },
        children: currencies);
  }

  void updateUI(double price) {
    value = price.toStringAsFixed(1);
  }

  // Widget getPicker() {
  //   if (Platform.isIOS) {
  //     return iOSPicker();
  //   }

  //   return androidDropdownButton();
  // }

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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $value $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iOSPicker(),
          ),
        ],
      ),
    );
  }
}

// Platform.isIOS ? iOSPicker() : androidDropdownButton(),
