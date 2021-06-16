import "package:flutter/material.dart";
import "dart:math";
import 'package:easy_localization/easy_localization.dart';

class EMIScreen extends StatefulWidget {
  @override
  EMIScreenState createState() => EMIScreenState();
}

class EMIScreenState extends State<EMIScreen> {
  List _tenureTypes = ['Month(s)', 'Year(s)'];
  String _tenureType = "Year(s)";
  String _emiResult = "";
  String _total = "";

  final TextEditingController _principalAmount = TextEditingController();
  final TextEditingController _interestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();

  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("EMI Calculator".tr()), elevation: 0.0),
        body: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _principalAmount,
                  decoration:
                      InputDecoration(labelText: "Enter Principal Amount".tr()),
                  keyboardType: TextInputType.number,
                )),
            Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _interestRate,
                  decoration: InputDecoration(labelText: "Interest Rate".tr()),
                  keyboardType: TextInputType.number,
                )),
            Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: TextField(
                          controller: _tenure,
                          decoration: InputDecoration(
                              labelText: "Tenure (in months)".tr()),
                          keyboardType: TextInputType.number,
                        )),
                    // Flexible(
                    //   flex: 1,
                    //   child: Column(
                    //     children: [
                    //       Text(_tenureType,
                    //           style: TextStyle(fontWeight: FontWeight.bold)),
                    //       Switch(
                    //           value: _switchValue,
                    //           onChanged: (bool value) {
                    //             print(value);

                    //             if (value) {
                    //               _tenureType = _tenureTypes[1];
                    //             } else {
                    //               _tenureType = _tenureTypes[0];
                    //             }

                    //             setState(() {
                    //               _switchValue = value;
                    //             });
                    //           })
                    //     ],
                    //   ),
                    // )
                  ],
                )),
            FlatButton(
                onPressed: _handleCalculation,
                child: Text(
                  "Calculate".tr(),
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Color.fromRGBO(89, 87, 117, 1.0),
                textColor: Colors.white,
                padding: EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 30.0, right: 30.0)),
            emiResultsWidget(_emiResult)
          ],
        ));
  }

  void _handleCalculation() async {
    //  Amortization
    //  A = Payemtn amount per period
    //  P = Initial Printical (loan amount)
    //  r = interest rate
    //  n = total number of payments or periods
    await Future.delayed(Duration(milliseconds: 500));
    FocusScope.of(context).unfocus();
    double A = 0.0;
    int P = int.parse(_principalAmount.text);
    double r = int.parse(_interestRate.text) / 12 / 100;
    int n = int.parse(_tenure.text);

    A = (P * r * pow((1 + r), n) / (pow((1 + r), n) - 1));

    _emiResult = A.toStringAsFixed(2);

    _total = (A * n).toStringAsFixed(2);

    setState(() {});
  }

  Widget emiResultsWidget(emiResult) {
    bool canShow = false;
    String _emiResult = emiResult;

    if (_emiResult.length > 0) {
      canShow = true;
    }
    return Container(
        margin: EdgeInsets.only(top: 40.0),
        child: canShow
            ? Column(
                children: [
                  Text("Your Monthly EMI is".tr(),
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Container(
                    child: Text(_emiResult,
                        style: TextStyle(
                            fontSize: 50.0, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 15.0),
                  Text("Total Payment is".tr(),
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Container(
                    child: Text(_total,
                        style: TextStyle(
                            fontSize: 50.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            : Container());
  }
}
