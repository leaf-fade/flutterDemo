import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_app/animator/page/toast.dart';
/*
* Text 是继承 StatelessWidget
* 不可以修改状态
* */
class TextWidget{
  Widget build(){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("简单文字"*2,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,  //超出部分以省略号结尾
          textScaleFactor: 1.5, //字体放大倍数
          style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              height: 1.2,
              fontFamily: "Courier",
              background: new Paint()..color=Colors.yellow,
              decoration:TextDecoration.underline,         //下划线
              decorationStyle: TextDecorationStyle.dashed  //虚线
          ),
        ),
        DefaultTextStyle(
          //1.设置文本默认样式
          style: TextStyle(
            color:Colors.red,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.start,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("hello world"),
              Text("I am Jack"),
              Text("I am Jack",
                style: TextStyle(
                    inherit: false, //2.不继承默认样式
                    color: Colors.grey
                ),
              ),
            ],
          ),
        ),
        TextTap()
      ],
    );
  }
}

class TextTap extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TextState();
  }
}

class _TextState extends State<TextTap>{
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: "点我计数加一，count：",
        children: [
          TextSpan(
              text: "$_count",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20
              )
          )
        ],
        recognizer: TapGestureRecognizer()..onTap=(){
          Toast.show("计数加一");
          setState(() {
            _count++;
          });
        }
    ));
  }
}