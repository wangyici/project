import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'package:project/addDietRecord_page.dart';
import 'package:project/diet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  Diet diet = new Diet();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '飲食紀錄',
      theme: ThemeData(
        backgroundColor: Colors.grey,
        primarySwatch: Colors.grey,
      ),
      home: StartPage(
        diet: diet,
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  Diet diet = new Diet();
  StartPage({required this.diet});
  @override
  State<StartPage> createState() => _StartPageState(diet: diet);
}

class _StartPageState extends State<StartPage> {
  Diet diet = new Diet();
  _StartPageState({required this.diet});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
            builder: ((context) {
              return IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                color: Color.fromARGB(255, 88, 88, 88),
                iconSize: 30,
                onPressed: () {},
              );
            }),
          ),
          title: Text(
            "飲食紀錄小幫手",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddDietRecordPage(
                            diet: diet,
                          )));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height / 4 * 3,
                child: Column(children: <Widget>[
                  ...loadingListTile(),
                ]
                    // child: AnimatedList(
                    //     initialItemCount: 5,
                    //     itemBuilder: (context, index, animation) {
                    //       final _dietRecordList = diet.dietRecordList[index];
                    //       return Card(
                    //         child: ListTile(
                    //           leading: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: <Widget>[
                    //               Text(
                    //                 diet.dietRecordList[index].month +
                    //                     "/" +
                    //                     diet.dietRecordList[index].day,
                    //                 style: TextStyle(fontSize: 15),
                    //               )
                    //             ],
                    //           ),
                    //           title: Text(
                    //             diet.dietRecordList[index].hour +
                    //                 ":" +
                    //                 diet.dietRecordList[index].minute,
                    //             style: TextStyle(fontSize: 15),
                    //           ),
                    //           trailing: IconButton(
                    //             icon: Icon(Icons.chevron_right),
                    //             color: Color.fromARGB(255, 205, 205, 205),
                    //             onPressed: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => DietRecordPage(
                    //                             month: diet
                    //                                 .dietRecordList[index].month,
                    //                             day: diet
                    //                                 .dietRecordList[index].day,
                    //                             hour: diet
                    //                                 .dietRecordList[index].hour,
                    //                             minute: diet
                    //                                 .dietRecordList[index].minute,
                    //                             imagePath: diet
                    //                                 .dietRecordList[index]
                    //                                 .imagePath,
                    //                             diet: diet,
                    //                           )));
                    //             },
                    //           ),
                    //         ),
                    //       );
                    //     }),
                    ),
              ),
            ],
          ),
        ));
  }

  List<Widget> loadingListTile() {
    List<Card> recordList = List.filled(diet.dietRecordList.length, Card());
    for (int i = 0; i < diet.dietRecordList.length; i++) {
      recordList[i] = Card(
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                diet.dietRecordList[i].month + "/" + diet.dietRecordList[i].day,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          title: Text(
            diet.dietRecordList[i].hour + ":" + diet.dietRecordList[i].minute,
            style: TextStyle(fontSize: 15),
          ),
          trailing: IconButton(
            icon: Icon(Icons.chevron_right),
            color: Color.fromARGB(255, 205, 205, 205),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DietRecordPage(
                            month: diet.dietRecordList[i].month,
                            day: diet.dietRecordList[i].day,
                            hour: diet.dietRecordList[i].hour,
                            minute: diet.dietRecordList[i].minute,
                            imagePath: diet.dietRecordList[i].imagePath,
                            diet: diet,
                          )));
            },
          ),
        ),
      );
    }
    return recordList;
  }
}
