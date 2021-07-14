import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceField extends StatefulWidget {
  PriceField(
      {required this.baseValue,
      required this.selectedValue,
      required this.rateValue});
  final String baseValue;
  final String selectedValue;
  final String rateValue;
  @override
  _PriceFieldState createState() => _PriceFieldState();
}

class _PriceFieldState extends State<PriceField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${widget.baseValue} = ${widget.rateValue}  ${widget.selectedValue}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
