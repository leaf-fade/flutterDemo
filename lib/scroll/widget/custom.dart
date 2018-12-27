import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_app/animator/page/toast.dart';

class CustomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleView();
  }
}

/*
* 绘制一个圆
*
*  CustomPaint 是一个 SingleChildRenderObjectWidget
*
*  createRenderObject 返回 RenderCustomPaint
*  RenderCustomPaint 就是 RenderBox with RenderObjectWithChildMixin<RenderBox>
*  在其的paint方法中调用_paintWithPainter(context.canvas, offset, _painter)
*  回调 painter.paint(canvas, size);
*   _painter 是 CustomPainter
*
* */
class CircleView extends StatefulWidget {
  @override
  _CircleViewState createState() => _CircleViewState();
}

class _CircleViewState extends State<CircleView> {
  Rect _rect;
  @override
  Widget build(BuildContext context) {
    //屏幕的尺寸
    Size size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
          child: CustomPaint(
            size: size,
            painter: CirclePainter((rect){
              _rect = rect;
              print(_rect.toString());
            }),
          ),
          onTapDown:(TapDownDetails detail){
            //获取的点击点是绝对高度
            print(detail.globalPosition.toString());
            //状态栏高度
            double statusBar = MediaQueryData.fromWindow(ui.window).padding.top;
            //顶部高度 = 状态栏高度+toolbar高度+tab高度
            double topHeight = statusBar + kToolbarHeight + kTextTabBarHeight;
            var dx = detail.globalPosition.dx - size.width/2;
            //绝对高度减去
            var dy = detail.globalPosition.dy - (size.height-topHeight)/2 -topHeight ;
            if(_rect.contains(Offset(dx, dy))){
              Toast.show("点击文字！");
            }
          },
          onTap: (){
            print("========================");
          }
      )
    );
  }
}


typedef RectCallback = void Function(Rect rect);
class CirclePainter extends CustomPainter{
  Paint _paint;
  Path _path;
  double textWidth = 100;
  double textFontSize = 12.0;
  ui.Paragraph paragraph;
  RectCallback callback;
  CirclePainter(this.callback){
    _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
    _path = Path();
    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: textFontSize,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      ),
    )
      ..pushStyle(
        ui.TextStyle(
            color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText("六芒星咒符");

    paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: textWidth));

    //高度误差+20
    Rect rect = Rect.fromLTRB(-textWidth/2, -10-textFontSize/2, textWidth/2, 10+textFontSize/2);
    callback.call(rect);
  }

  @override
  void paint(Canvas canvas, Size size) {
    print("${size.width}  ${size.height}");
    canvas.translate(size.width/2, size.height/2);
    //绘制表格
    /*double width = 160;
      for(double i = -width; i<= width; i+=10){
      _paint.strokeWidth = 1;
      _paint.color = Colors.grey;
      canvas.drawLine(Offset(width, i), Offset(-width, i), _paint);
      canvas.drawLine(Offset(i, -width), Offset(i, width), _paint);
    }*/
    //绘制坐标
    /*_paint.strokeWidth = 2;
    _paint.color = Colors.black;
    canvas.drawLine(Offset(width, 0), Offset(-width, 0), _paint);
    canvas.drawLine(Offset(0, -width), Offset(0, width), _paint);*/

    //绘制外圈
    _paint.strokeWidth = 1.5;
    _paint.color = Colors.blueAccent;
    _paint.style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(0, 0), 100, _paint);
    canvas.drawCircle(Offset(0, 0), 120, _paint);

    //绘制六芒星
    _paint.color = Colors.redAccent;
    _path.moveTo(0, -100);
    _path.lineTo(0.85*100, 0.5*100);
    _path.lineTo(-0.85*100, 0.5*100);
    _path.lineTo(0, -100);
    _path.moveTo(0, 100);
    _path.lineTo(0.85*100, -0.5*100);
    _path.lineTo(-0.85*100, -0.5*100);
    _path.lineTo(0, 100);
    canvas.drawPath(_path, _paint);

    //绘制文字

    /*
    * 绘制文字有2种方式
    * 1.继承构造TextPainter，通过其的paint来绘制
    * */
    canvas.drawParagraph(paragraph, Offset(-textWidth/2,-textFontSize/2));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

