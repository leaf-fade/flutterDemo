import 'package:flutter/material.dart';
/*
* Image 是继承 StatefulWidget
* 可修改状态
* 可修改属性为:
* ImageStream _imageStream;
  ImageInfo _imageInfo;
  bool _isListeningToStream = false;
  bool _invertColors;
* */
class ImageWidget{
  Widget build(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("images/head.png",width: 100.0,),
        Image.asset("images/1.gif",width: 100.0,), //加载gif
        //Image.network("https://flutter.io/images/flutter-mark-square-100.png",width: 100.0,), //这个网络加载图片，热加载用起来很不好使
        Text("\uE914\uE000\uE90D",
          style: TextStyle(
          fontFamily: "MaterialIcons",
          fontSize: 24.0,
          color: Colors.green
          )
        )
      ],
    );
  }
}