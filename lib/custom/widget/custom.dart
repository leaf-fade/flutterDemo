import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleView();
  }
}

class CircleView extends SingleChildRenderObjectWidget{
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCircle();
  }
}

class RenderCircle extends RenderBox{
  Paint _paint;
  Path _path;
  double textWidth = 100;
  double textFontSize = 12.0;
  ui.Paragraph paragraph;

  RenderCircle(){
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

  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var canvas = context.canvas;
    print("${size.width}  ${size.height}");
    canvas.translate(size.width/2, size.height/2);
    //绘制表格
    double width = 160;
      for(double i = -width; i<= width; i+=10){
      _paint.strokeWidth = 1;
      _paint.color = Colors.grey;
      canvas.drawLine(Offset(width, i), Offset(-width, i), _paint);
      canvas.drawLine(Offset(i, -width), Offset(i, width), _paint);
    }
    //绘制坐标
    _paint.strokeWidth = 2;
    _paint.color = Colors.black;
    canvas.drawLine(Offset(width, 0), Offset(-width, 0), _paint);
    canvas.drawLine(Offset(0, -width), Offset(0, width), _paint);

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

    canvas.drawParagraph(paragraph, Offset(-textWidth/2,-textFontSize/2));
    
  }

}