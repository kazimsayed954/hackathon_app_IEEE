import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TipsPage extends StatefulWidget {
  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: height / 3.5,
            color: Colors.black87,
            child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 30.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Covid Symptoms ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Food',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: ' Suggestions!',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height / 1.4,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(90.0))),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ListItem(index:index),
              ),
            ),
          );
                  }),
            ),
          ),
        )
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  
  final int index;
  ListItem({this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                image: DecorationImage(
                    image: AssetImage('assets/$index.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: Container(
                child: Text(foodList[index],style: TextStyle(fontSize:19.0),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> foodList = ['Fever','Tiredness','dry cough','aches and pains','sore throat','diarrhoea','nasal congestion'];