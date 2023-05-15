import 'dart:convert';
import 'dart:io';

import 'package:bookish_front/domain/history_item.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static final List<String> entries = ["a", "b"];
  final List<int> colorCodes = <int>[600, 500, 100];

  List<HistoryItem> items = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    List<HistoryItem> items = await getHistoryItems();
    setState(() {
      this.items = items;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        bottom: false,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return buildListItem(context, index);
            }
        )
      ),
    );
  }

  Container buildListItem(BuildContext context, int index) {
    File? image;
    List<HistoryItem> items = this.items;

    if (items.isEmpty) {
      return Container(
        color: Colors.redAccent,
        child: const Text("아무것도 없음"),
      );
    }
    HistoryItem item = items[index];
    var title = item.title;
    var memo = item.memo;
    var hashtags = item.hashTags.toString();
    var imageUrl = item.imageUrl;
    return Container(
      color: Colors.white70,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImageContainer(context, imageUrl),
          buildTextColumn(title, memo, hashtags)
        ],
      ),
    );
  }

  Column buildTextColumn(String title, String memo, String hashtags) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(memo),
            HashTagText(
              text: hashtags,
              decoratedStyle: const TextStyle(fontSize: 8, color: Colors.red),
              basicStyle: const TextStyle(fontSize: 8, color: Colors.black),
              onTap: (text) {
              },
            ),
          ],
        );
  }

  Container buildImageContainer(BuildContext context, String imageString) {
    var image = Image.network('http://localhost:8080/image/$imageString');
    return Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          height: 50,
          child: image
        );
  }

  Future<List<HistoryItem>> getHistoryItems() async {
    var uri = Uri.parse('http://localhost:8080/boards');
    var response = await http.get(uri);

    if (response.statusCode != 200) {
      print("잘못 된 결과가 나옴");
    }

    var jsonList = jsonDecode(response.body) as List;
    var xxx = jsonList.map((e) {
      var id = e['id'] as int;
      var title = e['title'] as String;
      var memo = e['memo'] as String;
      var imageUrl = e['imageUrl'] as String;
      dynamic hashTags = e['hashTags'];
      var hashTag = List<String>.from(hashTags['value'] as List);
      return HistoryItem(title, memo, hashTag, imageUrl);
    }).toList();
    return xxx;
  }

  File? getImageFromurl(String imageString) {
    ;
    return null;


  }
}
