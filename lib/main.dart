
import 'package:app/src/pages/index.dart';
import 'package:app/tipsPage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

void main() => runApp(MaterialApp(home: MyApp()));

List<Widget> columnList = [
  ColumnListItem(
    bpm: 'BPM',
    name: 'Rajendran',
  ),
  ColumnListItem(
    bpm: 'BPM1',
    name: 'Mahesh',
  ),
  ColumnListItem(
    bpm: 'BPM2',
    name: 'lakshmiPriya',
  ),
];

List<Widget> pages = [Body(),IndexPage(),TipsPage()];
Widget widget = Body();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffFCDB00),
              title: Text('HackCrisis',style: TextStyle(color: Colors.black),),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.add,color: Colors.black,),
                    onPressed: () async {
                      final String name =
                          await _asyncInputDialog(context);
                      print("Current team name is $name");
                      if(name!=null){
                        setState(() {
                        print(columnList.length);
                        columnList.add(
                          ColumnListItem(
                            bpm: 'BPM${columnList.length}',
                            name: name,
                          ),
                        );
                      });

                      }
                    },
                  ),
                )
              ],
            ),
            body: widget,
            bottomNavigationBar: FancyBottomNavigation(
              barBackgroundColor: Colors.black87,
              inactiveIconColor: Color(0xffFCDB00),
              circleColor: Color(0xffFCDB00),
              activeIconColor: Colors.black,
              textColor: Colors.white,
              onTabChangedListener: (position) {
                setState(() {
                  widget = pages[position];
                });
              },
              tabs: [
                TabData(iconData: Icons.equalizer, title: "Stats"),
                TabData(iconData: Icons.video_call, title: "Call doctor"),
                TabData(iconData: Icons.fastfood, title: 'tips'),
              ],
            ),),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        child: Wrap(
          children: columnList,
        ),
      ),
    );
  }

  // void getData() {
  //   ref.once().then((DataSnapshot snapshot) {
  //     print('Data : ${snapshot.value.toString()}');
  //   });
  // }

}

class ColumnListItem extends StatelessWidget {
  ColumnListItem({this.bpm,this.name});
  final String bpm;
  final String name;

  @override
  Widget build(BuildContext context) {
    print(bpm);
    return StreamBuilder(
      stream: FirebaseDatabase.instance.reference().child(bpm).onValue,
      builder: (context, snap) {
        print(snap.connectionState);
        if (snap.hasData &&
            !snap.hasError &&
            snap.data.snapshot.value != null) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(30.0)),
              height: 200.0,
              width: 170.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/0.png'), fit: BoxFit.cover),
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    height: 110.0,
                    width: 170.0,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0,),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 24.0, color: Colors.white),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'BPM: ${snap.data.snapshot.value.toString()}',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future<String> _asyncInputDialog(BuildContext context) async {
  String teamName = '';
  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter the Name'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Name', hintText: 'eg. Juventus F.C.'),
              onChanged: (value) {
                teamName = value;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );
}


