import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class HeroWidget{
  Widget build(){
    return Container(
      child: SourceHeroPage(),
    );
  }
}


class SourceHeroPage extends StatefulWidget {
  @override
  _SourceHeroPageState createState() => _SourceHeroPageState();
}

//封装好的widget是
class _SourceHeroPageState extends State<SourceHeroPage> {

  Hero _sourceHero = Hero(
      tag: "hero tag",   //tag是标识,必须一致
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.lightBlue,
      ));

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return GestureDetector(
            child: _sourceHero,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return DestinationHeroPage();
              }),
            ));
  }
}

class DestinationHeroPage extends StatefulWidget {
  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationHeroPage> {
  Hero _destinationHero = Hero(
      tag: "hero tag",
      child: Container(
        height: 100.0,
        width: 400.0,
        color: Colors.blue,
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              child: _destinationHero, onTap: () => Navigator.of(context).pop())
        ],
      ),
    );
  }
}