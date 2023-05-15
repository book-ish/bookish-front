import 'dart:convert';
import 'dart:io';

import 'package:bookish_front/util/ImageUtil.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();


}

class _InputScreenState extends State<InputScreen> {

  static double scaleWidth(BuildContext context) {
    const designGuideWidth = 360;
    final diff = MediaQuery.of(context).size.width / designGuideWidth;
    return diff;
  }

  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _memoController = TextEditingController();
    final _hashTagController = TextEditingController();

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    setState(() {
      _image = arguments['targetImage'];
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  var image = await ImageUtil.getImage(ImageSource.camera);
                  setState(() {
                    _image = image;
                  });
                },
                child: Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: 200 * scaleWidth(context),
                  child: _image == null ? const Text("해당 화면을 클릭해 이미지를 추가해주세요")
                      : Image.file(File(_image!.path)),
                ),
              ),
              SizedBox.fromSize(size: const Size.fromHeight(10)),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showTextBox("제목", true, _titleController),
                    showTextAreaBox("메모", _memoController),
                    showHashTagTextBox("Hashtag", true, _hashTagController),
                    saveButton(_titleController, _memoController, _hashTagController)
                  ],
                ),
              )
            ],
          )),
    );



  }

  Container showTextBox(String title, bool isRequired, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text(title),
                              isRequired == true ? const Text("*", style: TextStyle(color: Colors.red),): const Text("") ,
                            ]
                          ),
                        ),
                        SizedBox.fromSize(size: const Size.fromHeight(10)),
                        TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: title,

                            labelStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.black),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.grey),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
    );
  }

  Container showHashTagTextBox(String title, bool isRequired, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(

        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
                children: [
                  Text(title),
                  isRequired == true ? const Text("*", style: TextStyle(color: Colors.red),): const Text("") ,
                ]
            ),
          ),
          SizedBox.fromSize(size: const Size.fromHeight(10)),
          HashTagTextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: '기억하고 싶은 해시태그를 입력해주세요',
              labelStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            decoratedStyle: const TextStyle(fontSize: 14, color: Colors.blue),
            basicStyle: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
  Column showTextAreaBox(String s, TextEditingController controller) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
              children: [
                Text(s),
              ]
          ),
        ),
        SizedBox.fromSize(size: const Size.fromHeight(10)),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "함께 남기고 싶은 메모를 적어주세요",
            labelStyle: TextStyle(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          keyboardType: TextInputType.text,
          maxLines: 10,
        ),
      ],
    );
  }

  Container saveButton(TextEditingController title,
      TextEditingController memo,
      TextEditingController hashtag) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(onPressed: () {
        var sendTitle = title.text;
        var sendMeme = memo.text;
        var sendHashtag = hashtag.text;
        var pattern = RegExp("\B#([a-z0-9]{2,})(?![~!@#%^&*()=+_`\-\|\/'\[\]\{\}]|[?.,]*\w)");
        List<String> split = sendHashtag.split(pattern);
        uploadImage(sendTitle, sendMeme, split);
        Navigator.popAndPushNamed(context, '/history');
      },
          child: const Text("저장하기")),
    );

  }

  void uploadImage(String title, String memo, List<String> hashTag) async {
    var image = _image;
    var uri = Uri.parse('http://localhost:8080/upload');
    var request = http.MultipartRequest("POST", uri);

    request.fields["title"] = title;
    request.fields["memo"] = memo;
    request.fields["hashtags"] = json.encode(hashTag);

    request.files.add(await http.MultipartFile.fromPath('file', image!.path));

    await request.send();
  }
}
