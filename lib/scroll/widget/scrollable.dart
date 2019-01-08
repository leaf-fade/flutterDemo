 import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollWidgetDemo();
  }
}

class ScrollWidgetDemo extends StatefulWidget {
  @override
  _ScrollWidgetDemoState createState() => _ScrollWidgetDemoState();
}

class _ScrollWidgetDemoState extends State<ScrollWidgetDemo> {
  ScrollController _controller;
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener((){
        print(_controller.offset); //打印滚动位置
      }
    );
    super.initState();
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
        viewportBuilder: (context,offset) {
          return _SingleChildViewport(
            offset: offset,
            child: Container(
                color: Colors.amber,
                height: 1000,
                width: 400,
                child: Column(
                  children: str.split("").map((c) => Text(c, textScaleFactor: 2.0,)).toList(),
                )
            ),
          );
        }
    );
  }
}

/*
* RenderObjectWidget控件，创建和更新 RenderObject对象
* */
class _SingleChildViewport extends SingleChildRenderObjectWidget {
  const _SingleChildViewport({
    Key key,
    this.offset,
    Widget child,
  }) :super(key: key, child: child);

  final ViewportOffset offset;

  @override
  _RenderChildViewport createRenderObject(BuildContext context) {
    return _RenderChildViewport(
      offset: offset,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderChildViewport renderObject) {
    renderObject
      ..offset = offset;
  }
}

/*
* RenderObject对象，含有
* performLayout() 摆放
* paint() 绘制
* */
class _RenderChildViewport extends RenderBox with RenderObjectWithChildMixin<RenderBox>{
  _RenderChildViewport({
    @required ViewportOffset offset,
  }):_offset = offset;

  ViewportOffset _offset;
  ViewportOffset get offset => _offset;
  set offset(ViewportOffset value) {
    assert(value != null);
    if (value == _offset)
      return;
    if (attached)
      _offset.removeListener(_hasScrolled);
    _offset = value;
    if (attached)
      _offset.addListener(_hasScrolled);
    markNeedsLayout();
  }
  Offset get _paintOffset => _paintOffsetForPosition(offset.pixels);

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _offset.addListener(_hasScrolled);
  }

  @override
  void detach() {
    _offset.removeListener(_hasScrolled);
    super.detach();
  }

  void _hasScrolled() {
    print("==3===");
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  bool _shouldClipAtPaintOffset(Offset paintOffset) {
    assert(child != null);
    return paintOffset < Offset.zero || !(Offset.zero & size).contains((paintOffset & child.size).bottomRight);
  }

  @override
  void performLayout() {
    print("==1===");
    if (child == null) {
      size = constraints.smallest;
    } else {
      child.layout(constraints.widthConstraints(), parentUsesSize: true);
      size = constraints.constrain(child.size);
    }
    offset.applyViewportDimension(size.height);
    print(child.size.height - size.height);
    offset.applyContentDimensions(0.0, child.size.height - size.height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    print("==2===");
    if (child != null) {
      final Offset paintOffset = _paintOffset;
      void paintContents(PaintingContext context, Offset offset) {
        context.paintChild(child, offset + paintOffset);
      }
      if (_shouldClipAtPaintOffset(paintOffset)) {
        context.pushClipRect(needsCompositing, offset, Offset.zero & size, paintContents);
      } else {
        paintContents(context, offset);
      }
    }
  }

  Offset _paintOffsetForPosition(double position) {
    return Offset(0.0, -position);
  }
}



