import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String display = '';

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '';
      } else if (value == '=') {
        calculate();
      } else {
        display += value;
      }
    });
  }

  void calculate() {
    if (display.isEmpty) return;

    try {
      final expression = Expression.parse(display);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      display = result.toString();
    } catch (_) {
      display = 'Error';
    }
  }

  Widget calculatorButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Text(
                  display.isEmpty ? '0' : display,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                calculatorButton('7'),
                calculatorButton('8'),
                calculatorButton('9'),
                calculatorButton('/'),
              ],
            ),
            Row(
              children: [
                calculatorButton('4'),
                calculatorButton('5'),
                calculatorButton('6'),
                calculatorButton('*'),
              ],
            ),
            Row(
              children: [
                calculatorButton('1'),
                calculatorButton('2'),
                calculatorButton('3'),
                calculatorButton('-'),
              ],
            ),
            Row(
              children: [
                calculatorButton('0'),
                calculatorButton('C'),
                calculatorButton('='),
                calculatorButton('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
