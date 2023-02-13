import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main(List<String> args) {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String userInput = '';
  String answer = '00';

  // Array of button
  final List<String> buttons = [
    'C',
    '%',
    'DEL',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blueGrey,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    userInput,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Container(
                  color: Colors.blueGrey,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    answer,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.white60,
                      textColor: Colors.black,
                    );
                  }
                  if (index == 2) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.white60,
                      textColor: Colors.black,
                    );
                  }
                  if (index == 19) {
                    return MyButton(
                      buttontapped: () {
                        equalPressed();
                      },
                      buttonText: buttons[index],
                      color: Colors.white60,
                      textColor: Colors.black,
                    );
                  }
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput = userInput + buttons[index];
                        answer = '0';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.white60,
                    textColor: Colors.black,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  // function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();

    setState(() {
      answer = answer;
    });
  }
}
