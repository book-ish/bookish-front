import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  State<CameraExample> createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  File? _image;
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path);
    });
  }

  // 이미지 보여주는 위젯
  Widget showImage() {
    return Container(
      color: Color(0xFFFFE57F),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Center(
        child: _image == null
            ? Text("No image selected")
            : Image.file(File(_image!.path)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25.0),
          showImage(),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                  child: const Icon(Icons.add_a_photo),
                  tooltip: "pick Image",
                  onPressed: () {
                    getImage(ImageSource.camera);
                  }),

              // 갤러리에서 이미지를 가져오는 버튼
              FloatingActionButton(
                  child: Icon(Icons.wallpaper),
                  tooltip: "pick_Image From galley",
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  }),
              FloatingActionButton(
                  child: Icon(Icons.accessibility),
                  tooltip: "pick_Image From galley",
                  onPressed: () {
                    uploadImage();
                  }),
            ],
          )
        ],
      ),
    );
  }

  void uploadImage() async {
    var image = _image;
    // if (image == null) {
    //   print("XXX");
    //   return;
    // }

    var uri = Uri.parse('http://localhost:8080/upload');
    var request = http.MultipartRequest("POST", uri);

    request.fields["title"] = "zxc";
    print("xxxx");
    request.files
        .add(await http.MultipartFile.fromPath('file', image!.path));

    var response = await request.send();
    print(response);
    print('Response status: ${response.statusCode}');
    print('Response body: $response');
  }
}
