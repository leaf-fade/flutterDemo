import 'package:flutter/material.dart';
/*
* 基础动画
* */

class BaseAnimationWidget{
  Widget build(){
    return  AnimationWidget();
  }
}

class AnimationWidget extends StatefulWidget {
  @override
  _AnimationWidgetState createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> {
  int _type = 0;
  List<String> _names = ["缩放控制器","缩放控件","多个动画"];
  List<Widget> _viewList = <Widget>[
    ScaleAnimationWidget(),
    AnimatedContainerDemo(),
    AnimatedBuilderWidget()
  ];
  List<Widget> _buttonList;
  @override
  void initState(){
    _buttonList = List.generate(_names.length, (index)=> Padding(
          padding: EdgeInsets.all(5),
          child:RaisedButton(
            child: Text(_names[index]),
            onPressed: ()=>setType(index),
          )
      )
    );
    super.initState();
  }

  setType(int type){
    setState(() {
      _type = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: _buttonList)
        ),
        Expanded(child: _viewList[_type],)
      ],
    );
  }
}

//缩放动画，基础实现
class ScaleAnimationWidget extends StatefulWidget {
  @override
  _ScaleAnimationWidgetState createState() => _ScaleAnimationWidgetState();
}

class _ScaleAnimationWidgetState extends State<ScaleAnimationWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double _value = 255.0;
  bool _flag = true;
  _changeValue(){
    if(_flag) {
      _controller.forward();
    }else{
      _controller.reverse();
    }
    _flag = !_flag;
  }

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(seconds: 1),vsync: this);
    //插值器
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _animation = Tween(begin: 255.0, end: 80.0).animate(_animation)
      ..addListener((){
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeValue,
      child: Container(
        width: _animation.value,
        height: _animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}


//组合动画
class AnimatedBuilderWidget extends StatefulWidget {
  @override
  _AnimatedBuilderWidgetState createState() => _AnimatedBuilderWidgetState();
}

class _AnimatedBuilderWidgetState extends State<AnimatedBuilderWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _x;
  Animation<double> _size;
  Animation<Color> _color;
  bool _flag = true;
  _changeValue(){
    if(_flag) {
      _controller.forward();
    }else{
      _controller.reverse();
    }
    _flag = !_flag;
  }

  @override
  void initState() {
    _controller = AnimationController(duration: Duration(seconds: 4),vsync: this);
    _x = Tween(begin: 0.0, end: 200.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.6,curve: Curves.bounceInOut))
    );
    _color= ColorTween(begin: Colors.green, end: Colors.red).animate(
        CurvedAnimation(parent: _controller, curve: Curves.ease)
    );
    _size = Tween(begin: 25.0, end:50.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.2, 1.0,curve: Curves.linear))
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeValue,
      child: Container(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context,child)=>Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB( _x.value,_x.value*1.5, 0.0, 0.0),
                    child: Text(" \uE90D",
                    style: TextStyle(
                    fontFamily: "MaterialIcons",
                    fontSize: _size.value,
                    color: _color.value
                    ),
                    )
                  )
                ],
              ),
            )
        ),
      )
    );
  }
}


//缩放动画,官方封装好的widget类 AnimatedWidget  
class AnimatedContainerDemo extends StatefulWidget {
  @override
  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  double _value = 255.0;

  _changeValue()=>setState(() {
    _value = _value == 255.0 ? 80.0: 255.0;
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _changeValue,
        child: AnimatedContainer(
          curve: Curves.decelerate,//多种方式，类似于属性动画的插值器
          duration: Duration(seconds: 1),
          width: _value,
          height: _value,
          color: Color.fromARGB(_value.toInt(), _value.toInt(),_value.toInt(), _value.toInt()),
          child: FlutterLogo(),
        ),
      );
  }
}