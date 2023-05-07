import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('history'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        children: [
          Container(
            height: 50,
            color: Colors.amberAccent,
            child: Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amberAccent,
            child: Center(child: Text('Entry B')),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    var uri = Uri.parse('http://localhost:8080/boards');
    var response = await http.get(uri);

    if (response.statusCode != 200) {
      print("잘못 된 결과가 나옴");
    }

    var jsonDecode2 = jsonDecode(response.body);
    print(jsonDecode2);
  }
}

