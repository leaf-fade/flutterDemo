import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ScrollBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollBarDemo();
  }
}

class ScrollBarDemo extends StatelessWidget {
  final String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
          child:Container(
              color: Colors.redAccent,
              width: 360,
              child: Column(
                children: str.split("").map((c) => Text(c, textScaleFactor: 2.0,)).toList(),
              )
          )
        )
    );
  }
}






