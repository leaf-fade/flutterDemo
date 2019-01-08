import 'package:flutter/material.dart';
import 'package:flutter_app/contain.dart';
import 'package:flutter_app/custom/widget/custom.dart';
import 'package:flutter_app/custom/widget/custom_with_widget.dart';
import 'package:flutter_app/custom/widget/layout.dart';
import 'package:flutter_app/custom/widget/layout_with_widget.dart';

class CustomContain extends StatelessWidget {
  final List<Widget> barList = <Widget>[
    Tab(text: "六芒星基础实现",),
    Tab(text: "六芒星封装控件实现",),
    Tab(text: "布局基础实现"),
    Tab(text: "布局封装控件实现"),
  ];
  final title = "自定义控件";
  final viewList = <Widget>[
    CustomView(),
    CustomView2(),
    MyLayout(),
    LayoutWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseContain(title, barList, viewList);
  }
}