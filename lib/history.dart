import 'package:flutter/material.dart';

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
          Container(
            height: 50,
            color: Colors.amberAccent,
            child: Center(child: Text('Entry C')),
          ),
          Container(
            height: 50,
            color: Colors.amberAccent,
            child: Center(child: Text('Entry D')),
          ),
        ],
      ),
    );
  }
}

