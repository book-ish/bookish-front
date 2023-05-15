import 'package:bookish_front/util/ImageUtil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed:  () async {
                      var image = await ImageUtil.getImage(ImageSource.gallery);
                      Navigator.pushNamed(context, '/input',
                          arguments: {"targetImage": image});
                    },
                    child: const Text("갤러리"),
                    style: ElevatedButton.styleFrom(
                        elevation: 12.0,
                        textStyle: const TextStyle(color: Colors.white),
                        backgroundColor: const Color.fromRGBO(103, 80, 164, 1)),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/input')
                    },
                    child: const Text("사진촬영"),
                    style: ElevatedButton.styleFrom(
                        elevation: 12.0,
                        textStyle: TextStyle(color: Colors.white),
                        backgroundColor: Color.fromRGBO(103, 80, 164, 1)),
                  ),
                ],
              ),
              SizedBox.fromSize(
                size: const Size(10, 40),
              ),
              ElevatedButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, '/history')
              },
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      textStyle: const TextStyle(color: Colors.white),
                      backgroundColor: const Color.fromRGBO(207, 188, 255, 1)),

                  child: Container(
                    alignment: Alignment.center,
                      width: 200,
                      height: 20,
                      child: const Text("히스토리")
                  )),
              SizedBox.fromSize(size: const Size(10, 50),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                      labelText: "검색",
                      hintText: "찾고자하는 문구를 입력해주세요",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
