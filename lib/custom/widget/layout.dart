import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: LayoutDemo(
        children: <Widget>[
          Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
          Container(
            color: Colors.red,
            width: 100,
            height: 100,
          ),
          Container(
            color: Colors.green,
            width: 100,
            height: 100,
          ),
          Container(
            color: Colors.amber,
            width: 100,
            height: 100,
          )
        ],
      ),
    );
  }
}

class LayoutDemo extends MultiChildRenderObjectWidget{
  LayoutDemo({
    Key key,
    List<Widget> children
  }): super(key: key , children: children);

  @override
  RenderLayout createRenderObject(BuildContext context) {
    return RenderLayout();
  }

  @override
  void updateRenderObject(BuildContext context, RenderLayout renderObject) {

  }
}

class PageParentData extends ContainerBoxParentData<RenderBox> {}

class RenderLayout extends RenderBox with ContainerRenderObjectMixin<RenderBox, PageParentData>,RenderBoxContainerDefaultsMixin<RenderBox, PageParentData>{

  Paint _paint;
  RenderLayout({List<RenderBox> children}){
    _paint = Paint()..strokeWidth = 2
                   ..color = Colors.white;
    addAll(children);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! PageParentData)
      child.parentData = PageParentData();
  }

  @override
  void performLayout() {
    var index = 0;
    double widthOffset = 0.0;
    double heightOffset = 0.0;
    //size = constraints.constrain(Size(200, 200));
    size = constraints.constrain(Size(double.infinity,double.infinity));
    RenderBox child = firstChild;
    while(child != null){
      if(index != 0){
        if(index%2 == 0){
          widthOffset = 0.0;
          heightOffset += 100.0;
        }else{
          widthOffset += 100.0;
        }
      }
      final PageParentData childParentData = child.parentData;
      child.layout(constraints.heightConstraints(), parentUsesSize: true);
      childParentData.offset = Offset(widthOffset, heightOffset);
      index++;
      child = childParentData.nextSibling;
    }
  }

  @override
  bool hitTestChildren(HitTestResult result, { Offset position }) {
    return defaultHitTestChildren(result,position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
    //绘制一个圆环
    //context.canvas.drawCircle(Offset(100, 100), 10.0, _paint);
    //context.canvas.drawCircle(Offset(100, 100), 6.0, _paint);

  }

}

