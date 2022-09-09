import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "←") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
        equationFontSize = 48.0;
        resultFontSize = 38.0;
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        try {
          equation = expression;
          expression = expression.replaceAll("x", "*");
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          print(e);
          result = "error";
        }
      } else {
        if (equation == "0") {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = buttonText;
        } else {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Simple Calculator"),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: equationFontSize),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize),
              ),
            ),
            const Expanded(
              child: Divider(
                thickness: 1.0,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.black26,
                    ),
                    children: [
                      TableRow(
                        children: [
                          buildButton(context, "C", 1, Colors.redAccent),
                          buildButton(context, "←", 1, Colors.blue),
                          buildButton(context, "/", 1, Colors.blue),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(context, "7", 1, Colors.black45),
                          buildButton(context, "8", 1, Colors.black45),
                          buildButton(context, "9", 1, Colors.black45),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(context, "4", 1, Colors.black45),
                          buildButton(context, "5", 1, Colors.black45),
                          buildButton(context, "6", 1, Colors.black45),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(context, "1", 1, Colors.black45),
                          buildButton(context, "2", 1, Colors.black45),
                          buildButton(context, "3", 1, Colors.black45),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(context, ".", 1, Colors.black45),
                          buildButton(context, "0", 1, Colors.black45),
                          buildButton(context, "00", 1, Colors.black45),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.black26,
                    ),
                    children: [
                      TableRow(
                        children: [
                          buildButton(context, "x", 1, Colors.black45),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(context, "+", 1, Colors.black45),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(context, "-", 1, Colors.black45),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(context, "=", 2, Colors.redAccent),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  Container buildButton(BuildContext context, String buttonText,
      double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromRGBO(100, 100, 100, 0.2)),
            padding: MaterialStateProperty.all(EdgeInsets.all(0.0))),
        onPressed: () {
          buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
