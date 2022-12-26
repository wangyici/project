import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:image/image.dart' as imageLib;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/diet.dart';
import 'package:project/main.dart';

class AddDietRecordPage extends StatefulWidget {
  Diet diet = new Diet();
  AddDietRecordPage({required this.diet});
  @override
  State<AddDietRecordPage> createState() => _AddDietRecordPageState(diet: diet);
}

class _AddDietRecordPageState extends State<AddDietRecordPage> {
  Diet diet = new Diet();
  _AddDietRecordPageState({required this.diet});
  String month = DateTime.now().month.toString();
  String day = DateTime.now().day.toString();
  String hour = DateTime.now().hour.toString();
  String minute = DateTime.now().minute.toString();
  String imagePath = '';
  double _screenWidth = 0;
  final NoteController = TextEditingController();

  //File imageFile = new File('');
  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                      icon: const Icon(Icons.chevron_left),
                      color: Colors.white,
                      iconSize: 20,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartPage(
                                      diet: diet,
                                    )));
                      });
                },
              ),
              title: Text('紀錄', //改字
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              backgroundColor: Colors.grey,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, //置中
                    children: [
                      Text(month + ' 月 ' + day + ' 日',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 1),
                      Text(
                        '今天吃了什麼呀！',
                        style: TextStyle(fontSize: 15),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.photo_library,
                          color: Colors.grey,
                          size: 40,
                        ),
                        onPressed: () async {
                          try {
                            _getFromGallery();
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      imagePath == ""
                          ? Container(
                              width: 300,
                              height: 300,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(100, 215, 215, 215),
                                border: new Border.all(
                                    width: 1,
                                    color: Color.fromARGB(255, 226, 226, 226)),
                              ),
                              // child: Container(
                              //   width: 300,
                              //   height: 300,
                              //   child: //Text("null")
                              //   Image.file(
                              //     File(imagePath),
                              //     fit: BoxFit.fill,
                              //   ),
                              // ),
                            )
                          : Container(
                              width: 300,
                              height: 300,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(0, 255, 255, 255),
                                border: new Border.all(
                                    width: 3,
                                    color: Color.fromARGB(255, 226, 226, 226)),
                              ),
                              child: Container(
                                width: 250,
                                height: 200,
                                child: //Text("null")
                                    Image.file(
                                  File(imagePath),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child:
                            Text('確認', style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          try {
                            diet.dietRecordList.insert(
                                0,
                                DietRecord(
                                  month: month,
                                  day: day,
                                  hour: hour,
                                  minute: minute,
                                  imagePath: imagePath,
                                ));
                            // getting a directory path for saving
                            // Directory path =
                            //     await getApplicationDocumentsDirectory();
                            // String tempPath = path.path;
                            // copy the file to a new path
                            // final File newImage = await File(imagePath)
                            //     .copy('$tempPath/image1.jpg');
                            // debugPrint("path: " + tempPath);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartPage(
                                          diet: diet,
                                        )));
                          } catch (e) {
                            print(e);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shadowColor: Color.fromARGB(255, 215, 215, 215),
                            fixedSize: Size(120, 45),
                            primary: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 100,
        maxWidth: _screenWidth / 2 - 20);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
      debugPrint("image path: " + imagePath);
    }
  }

  Future<Uint8List> downloadImage() async {
    //String dir = (await getApplicationDocumentsDirectory()).path;

    File file = new File('$imagePath');
    var image = await file.readAsBytes();
    print("downloadImage() run successfully");
    return image;
  }
}
