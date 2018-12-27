import 'package:flutter/material.dart';
import 'package:flutter_app/scroll/widget/custom.dart';
import 'package:flutter_app/scroll/widget/scrollBar.dart';
import 'package:flutter_app/scroll/widget/scrollable.dart';


class ScrollWidgetContain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ContainDemo();
  }
}

class ContainDemo extends StatelessWidget{
  final List<Widget> barList = <Widget>[
    Tab(text: "原生滚动控件",),
    Tab(text: "自定义绘制",),
    Tab(text: "滚动条",),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> barViewList = List.generate(barList.length,(index)=>Contain(index));

    return DefaultTabController(
        length: barList.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text("滚动控件展示"),
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
        return getContain(type,ScrollWidget());
      case 1:
        return getContain(type, CustomView());
      case 2:
        return getContain(type, ScrollBarView());
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