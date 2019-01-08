import 'package:flutter/material.dart';
import 'package:flutter_app/contain.dart';
import 'package:flutter_app/special/widget/inherited.dart';
import 'package:flutter_app/special/widget/theme.dart';

class SpecialWidgetContain extends StatelessWidget {
  final List<Widget> barList = <Widget>[
    Tab(text: "数据共享",),
    Tab(text: "主题",),
  ];
  final title = "特殊控件展示";
  final viewList = <Widget>[
    TestInheritedWidget(),
    ThemeTest()
  ];

  @override
  Widget build(BuildContext context) {
    return BaseContain(title, barList, viewList);
  }
}
