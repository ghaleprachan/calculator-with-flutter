import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = '0';
  String result = '0';
  String expression = "";
  double equationFontSize = 38;
  double resultfontSize = 48;
  final int equationMaxLines = 3;
  final int resultMaxLines = 1;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equationFontSize = 38;
        resultfontSize = 48;
        equation = '0';
        result = '0';
      } else if (buttonText == '⌫') {
        equationFontSize = 48;
        resultfontSize = 38;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        equationFontSize = 38;
        resultfontSize = 48;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression ex = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${ex.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        equationFontSize = 48;
        resultfontSize = 38;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        onPressed: () => {buttonPressed(buttonText)},
        child: Text(
          buttonText,
          maxLines: resultMaxLines,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              maxLines: equationMaxLines,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultfontSize),
            ),
          ),
          // This expanded widges fills the available space between childs in row or column to fill the whole screen
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //This takes 75% of the screen size
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('C', 1.0, Colors.redAccent),
                      buildButton('⌫', 1.0, Colors.blue),
                      buildButton('÷', 1.0, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('7', 1.0, Colors.black54),
                      buildButton('8', 1.0, Colors.black54),
                      buildButton('9', 1.0, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton('4', 1.0, Colors.black54),
                      buildButton('5', 1.0, Colors.black54),
                      buildButton('6', 1.0, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton('1', 1.0, Colors.black54),
                      buildButton('2', 1.0, Colors.black54),
                      buildButton('3', 1.0, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton('.', 1.0, Colors.black54),
                      buildButton('0', 1.0, Colors.black54),
                      buildButton('00', 1.0, Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('×', 1.0, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('-', 1.0, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('+', 1.0, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('=', 2.0, Colors.redAccent),
                    ])
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
