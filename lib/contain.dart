import 'package:flutter/material.dart';


class BaseContain extends StatelessWidget{

  final String title;
  final List<Widget> barList;
  final List<Widget> viewList;
  BaseContain(this.title,this.barList,this.viewList);

  @override
  Widget build(BuildContext context) {
    List<Widget> barViewList = List.generate(barList.length,(index)=>Contain(index,viewList));

    return DefaultTabController(
        length: barList.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              bottom: TabBar(
                tabs: barList,
                isScrollable: true, 
              ),
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
  factory Contain(int type,List<Widget> viewList){
    if(_map.containsKey(type)){
      return _map[type];
    }
    return getContain(type, viewList);
  }

  static Contain getContain(int type, List<Widget> list){
    final contain = Contain.widget(list[type]);
    _map[type] = contain;
    return contain;
  }

  Contain.widget(Widget child): super(child: child);
}
