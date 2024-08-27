import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuotesApp extends StatelessWidget {
  const QuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quotes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomQuote(),
    );
  }
}

class RandomQuote extends StatefulWidget {
  @override
  _RandomQuoteState createState() => _RandomQuoteState();
}

class _RandomQuoteState extends State<RandomQuote> {
  String _quote = 'Push Button for Quote';
  String _author = '';

  Future<void> fetchQuote() async {
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/quotes'),
      headers: {'X-Api-Key': '8MIdt49rvWVzfaln5dlR3nkVwWeZpsW6RKLExz7z'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        setState(() {
          _quote = data[0]['quote'];
          _author = data[0]['author'];
        });
      }
    } else {
      setState(() {
        _quote = 'Error fetching quote';
        _author = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _quote,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              _author.isNotEmpty ? '- $_author' : '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: fetchQuote,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
