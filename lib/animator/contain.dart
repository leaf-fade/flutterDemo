import 'package:flutter/material.dart';
import 'package:flutter_app/animator/page/page.dart';
import 'package:flutter_app/animator/widget/base.dart';
import 'package:flutter_app/animator/widget/hero.dart';
import 'package:flutter_app/contain.dart';

class AnimationContain extends StatelessWidget {
  final List<Widget> barList = <Widget>[
    Tab(text: "Base",),
    Tab(text: "Hero"),
    Tab(text: "net",),
  ];
  final title = "动画展示";
  final viewList = <Widget>[
    BaseAnimationWidget().build(),
    HeroWidget().build(),
    HttpConnectWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return BaseContain(title, barList, viewList);
  }
}







