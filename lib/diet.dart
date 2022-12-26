//飲食
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/addDietRecord_page.dart';
import 'package:project/main.dart';

class Diet {
  // @override
  // State<Diet> createState() => _DietState();

  List<DietRecord> dietRecordList = [
    DietRecord(
      month: "12",
      day: "10",
      hour: "12",
      minute: "36",
      imagePath: 'assets/images/hamburger.jpg',
    ),
  ];
}


class DietRecord {
  String month = DateTime.now().month.toString();
  String day = DateTime.now().day.toString();
  String hour = DateTime.now().hour.toString();
  String minute = DateTime.now().minute.toString();
  String imagePath = '';
  DietRecord({
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.imagePath,
  });
}

class DietRecordPage extends StatelessWidget {
  Diet diet = new Diet();
  String month = '';
  String day = '';
  String hour = '';
  String minute = '';
  String imagePath = '';
  double _screenWidth = 0;
  DietRecordPage(
      {required this.month,
      required this.day,
      required this.hour,
      required this.minute,
      required this.imagePath,
      required this.diet});
  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
          title: Text('詳細紀錄',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(month + ' 月 ' + day + ' 日 ' + hour + ':' + minute,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 88, 88, 88))),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: _screenWidth / 2 - 20,
                    height: 300,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(0, 255, 255, 255),
                      border: new Border.all(
                          width: 1, color: Color.fromARGB(255, 226, 226, 226)),
                    ),
                    child: Container(
                      width: _screenWidth / 2 - 20,
                      height: 300,
                      child: //Text("null")
                          Image.asset(
                        imagePath,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
