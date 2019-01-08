import 'package:flutter/material.dart';
import 'package:flutter_app/contain.dart';
import 'package:flutter_app/scroll/widget/custom_scroll_view.dart';
import 'package:flutter_app/scroll/widget/scrollBar.dart';
import 'package:flutter_app/scroll/widget/scrollable.dart';

class ScrollWidgetContain extends StatelessWidget {
  final List<Widget> barList = <Widget>[
    Tab(text: "原生滚动控件",),
    Tab(text: "滚动条",),
    Tab(text: "自定义滚动控件",),
  ];
  final String title = "滚动控件展示";
  final viewList = <Widget>[
    ScrollWidget(),
    ScrollBarView(),
    CustomScrollViewTestRoute()
  ];
  @override
  Widget build(BuildContext context) {
    return BaseContain(title, barList, viewList);
  }
}
