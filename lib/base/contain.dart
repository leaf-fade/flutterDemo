import 'package:flutter/material.dart';
import 'package:flutter_app/base/widget/button.dart';
import 'package:flutter_app/base/widget/image.dart';
import 'package:flutter_app/base/widget/switch.dart';
import 'package:flutter_app/base/widget/text.dart';
import 'package:flutter_app/base/widget/textField.dart';
import 'package:flutter_app/contain.dart';

class BaseWidgetContain extends StatelessWidget {
  final List<Widget> barList = <Widget>[
    Tab(text: "text",),
    Tab(text: "button",),
    Tab(text: "image",),
    Tab(text: "switch",),
    Tab(text: "editText",),
  ];
  final title = "基础控件展示";
  final viewList = <Widget>[
    TextWidget().build(),
    ButtonWidget().build(),
    ImageWidget().build(),
    SwitchWidget().build(),
    TextFieldWidget().build()
  ];

  @override
  Widget build(BuildContext context) {
    return BaseContain(title, barList, viewList);
  }
}







