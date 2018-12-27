import 'package:flutter/material.dart';
import 'package:flutter_app/animator/contain.dart';
import 'package:flutter_app/base/contain.dart';
import 'package:flutter_app/scroll/contain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage()
      );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("flutter"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    child: Text("基础控件"),
                    onPressed: (){
                      //基础路由调用
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BaseWidgetContain()));
                    }
                ),
                RaisedButton(
                  child: Text("动画"),
                  onPressed: (){
                    //路由自定义动画,改为左边进入
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context,Animation animation,_)=>FadeTransition(
                          opacity: animation,
                          child: SlideTransition(position: Tween<Offset>(begin: Offset(-1.0, 0.0),end: Offset(0.0, 0.0)).animate(animation),child: AnimationContain(),),
                        )
                    ));
                  }
                ),
                RaisedButton(
                    child: Text("滚动控件"),
                    onPressed: (){
                      //基础路由调用
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScrollWidgetContain()));
                    }
                ),
              ],
            )
        )
    );
  }
}


