import 'package:flutter/material.dart';
import 'package:quotes_application/quotes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: QuotesApp());
  }
}
