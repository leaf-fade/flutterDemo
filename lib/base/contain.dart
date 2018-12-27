import 'package:flutter/material.dart';
import 'package:flutter_app/base/widget/button.dart';
import 'package:flutter_app/base/widget/image.dart';
import 'package:flutter_app/base/widget/switch.dart';
import 'package:flutter_app/base/widget/text.dart';
import 'package:flutter_app/base/widget/textField.dart';

class BaseWidgetContain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ContainDemo();
  }
}

class ContainDemo extends StatelessWidget{
  final List<Widget> barList = <Widget>[
    Tab(text: "text",),
    Tab(text: "button",),
    Tab(text: "image",),
    Tab(text: "switch",),
    Tab(text: "editText",),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> barViewList = List.generate(barList.length,(index)=>Contain(index));

    return DefaultTabController(
        length: barList.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text("基础控件展示"),
              bottom: TabBar(
                  isScrollable: true,
                  tabs: barList),
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
        return getContain(type,TextWidget().build());
      case 1:
        return getContain(type,ButtonWidget().build());
      case 2:
        return getContain(type,ImageWidget().build());
      case 3:
        return getContain(type,SwitchWidget().build());
      case 4:
        return getContain(type,TextFieldWidget().build());
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






