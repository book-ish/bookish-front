import 'package:flutter/material.dart';

class MemoScreen extends StatelessWidget {
  MemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _memoController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "title 입력",
            ),
          ),
          TextField(
            controller: _memoController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "memo 입력"),
          ),
          TextButton(
              onPressed: () {
                var sendTitle = _titleController.text;
                var sendMeme = _memoController.text;
                Navigator.pop(context, [
                  {"title": sendTitle, "memo": sendMeme}
                ]);
              },
              child: const Text("전달하기"))
        ],
      ),
    );
  }
}
