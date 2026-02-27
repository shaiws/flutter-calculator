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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _expression = '';
  double _firstOperand = 0;
  String _operator = '';
  bool _shouldResetDisplay = false;

  void _onButton(String label) {
    setState(() {
      if (label == 'C') {
        _display = '0';
        _expression = '';
        _firstOperand = 0;
        _operator = '';
        _shouldResetDisplay = false;
      } else if (label == '⌫') {
        if (_display.length > 1) {
          _display = _display.substring(0, _display.length - 1);
        } else {
          _display = '0';
        }
      } else if (label == '+/-') {
        if (_display != '0') {
          _display = _display.startsWith('-')
              ? _display.substring(1)
              : '-$_display';
        }
      } else if (label == '%') {
        _display = (double.parse(_display) / 100).toString();
        _trimDisplay();
      } else if (['+', '-', '×', '÷'].contains(label)) {
        _firstOperand = double.parse(_display);
        _operator = label;
        _expression = '$_display $label';
        _shouldResetDisplay = true;
      } else if (label == '=') {
        if (_operator.isNotEmpty) {
          final second = double.parse(_display);
          double result;
          switch (_operator) {
            case '+': result = _firstOperand + second; break;
            case '-': result = _firstOperand - second; break;
            case '×': result = _firstOperand * second; break;
            case '÷': result = second != 0 ? _firstOperand / second : double.nan; break;
            default: result = second;
          }
          _expression = '$_expression $_display =';
          _display = result.isNaN ? 'Error' : result.toString();
          _trimDisplay();
          _operator = '';
          _shouldResetDisplay = true;
        }
      } else if (label == '.') {
        if (_shouldResetDisplay) {
          _display = '0.';
          _shouldResetDisplay = false;
        } else if (!_display.contains('.')) {
          _display += '.';
        }
      } else {
        // digit
        if (_shouldResetDisplay || _display == '0') {
          _display = label;
          _shouldResetDisplay = false;
        } else {
          if (_display.length < 15) _display += label;
        }
      }
    });
  }

  void _trimDisplay() {
    if (_display.endsWith('.0')) {
      _display = _display.substring(0, _display.length - 2);
    }
  }

  Widget _buildButton(String label, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () => _onButton(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFF333333),
            foregroundColor: textColor ?? Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          child: Text(label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _expression,
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _display,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Buttons
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(children: [
                    _buildButton('C', color: const Color(0xFFA5A5A5), textColor: Colors.black),
                    _buildButton('+/-', color: const Color(0xFFA5A5A5), textColor: Colors.black),
                    _buildButton('%', color: const Color(0xFFA5A5A5), textColor: Colors.black),
                    _buildButton('÷', color: const Color(0xFFFF9F0A)),
                  ]),
                  Row(children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('×', color: const Color(0xFFFF9F0A)),
                  ]),
                  Row(children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('-', color: const Color(0xFFFF9F0A)),
                  ]),
                  Row(children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('+', color: const Color(0xFFFF9F0A)),
                  ]),
                  Row(children: [
                    _buildButton('⌫', color: const Color(0xFF555555)),
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildButton('=', color: const Color(0xFFFF9F0A)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
