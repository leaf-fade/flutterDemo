import 'package:flutter/material.dart';
import 'dart:async';
/*
* button 继承的是 StatelessWidget，是不可以修改状态的
* */
class ButtonWidget{
  Widget build(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text("RaisedButton"),
          onPressed: ()=>{},
        ),
        FlatButton(
          child: Text("FlatButton"),
          onPressed: () => {},
        ),
        OutlineButton(
          child: Text("outlineButton"),
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.thumb_up),
          onPressed: () => {},
        ),
        RaisedButton(
          color: Colors.blue,
          //highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,        //点击时，水波动画中水波的颜色
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Text("Submit"),
          onHighlightChanged: (flag)=> print(flag), //颜色变化事件监听
          onPressed: () => {},
        ),
        CountDownButton()
      ],
    );
  }
}

/*
* 倒计时按钮
* */
class CountDownButton extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CountDownState();
  }
}

class _CountDownState extends State<CountDownButton>{
  int _count;
  String _str;
  Timer _timer;
  static const COUNT = 60;
  @override
  void initState() {
    super.initState();
    _count = 0;
    _str = "发送验证码";
  }

  _startCountDown(){
    _count = COUNT;
    _timer = Timer.periodic(Duration(seconds: 1), (_){
      if(_count == 0){
        _cancelTimer();
        return;
      }
      _count --;
      _str = "$_count";
      setState(() {});
      if(_count == 0){
        _str = "重新发送";
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(_str),
      onPressed: (){
        if(_count == 0){
          _startCountDown();
        }
      },
    );
  }
}