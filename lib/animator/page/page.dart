import 'package:flutter/material.dart';
import 'package:flutter_app/animator/page/http.dart';

class AnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("http网络请求")),
      body: Center(),
    );
  }
}

class HttpConnectWidget extends StatefulWidget {
  @override
  _HttpConnectWidgetState createState() => _HttpConnectWidgetState();
}

class _HttpConnectWidgetState extends State<HttpConnectWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          child: Text("网络请求"),
          onPressed: (){
            httpConnect(
                "https://www.baidu.com",
                HttpCallBack(
                  (result)=> print(result),
                  (error)=> print(error)
                )
            );
          }
      ),
    );
  }
}



