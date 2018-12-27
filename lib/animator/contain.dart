import 'package:flutter/material.dart';
import 'package:flutter_app/animator/page/page.dart';
import 'package:flutter_app/animator/widget/base.dart';
import 'package:flutter_app/animator/widget/hero.dart';

class AnimationContain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContainDemo();
  }
}

class ContainDemo extends StatelessWidget{
  final List<Widget> barList = <Widget>[
    Tab(text: "Base",),
    Tab(text: "Hero"),
    Tab(text: "net",),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> barViewList = List.generate(barList.length,(index)=>Contain(index));
    return DefaultTabController(
        length: barList.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text("动画展示"),
              bottom: TabBar(tabs: barList),
            ),
            body: TabBarView(children: barViewList)
        ));
  }
}

/*
* 工厂创建
* */
class Contain extends Center{
  static final Map<int, Contain> _map =  <int, Contain>{};
  factory Contain(int type){
    if(_map.containsKey(type)){
      return _map[type];
    }
    switch(type){
      case 0:
        return getContain(type, BaseAnimationWidget().build());
      case 1:
        return getContain(type, HeroWidget().build());
      case 2:
        return getContain(type, HttpConnectWidget());
    }
    return null;
  }

  static Contain getContain(int type, Widget widget){
    final contain = Contain.widget(widget);
    _map[type] = contain;
    return contain;
  }

  Contain.widget(Widget child): super(child: child);
}






