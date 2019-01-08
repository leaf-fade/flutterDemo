import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: CustomMultiChildLayout(
        delegate: _MyDelegate(),
        children: <Widget>[
          LayoutId(
              id: 0,
              child: Container(
                color: Colors.blue,
                width: 100,
                height: 100,
              )
          ),
          LayoutId(
            id: 1,
            child: Container(
              color: Colors.red,
              width: 100,
              height: 100,
            ),
          ),
          LayoutId(
            id: 2,
            child:  Container(
              color: Colors.green,
              width: 100,
              height: 100,
            ),
          ),
          LayoutId(
              id: 3,
              child: Container(
                color: Colors.amber,
                width: 100,
                height: 100,
              )
          ),
        ],
      ),
    );
  }
}

class _MyDelegate extends MultiChildLayoutDelegate{
  @override
  void performLayout(Size size) {
    double widthOffset = 0.0;
    double heightOffset = 0.0;
    for(int i = 0; i < 4; i++){
      if(hasChild(0)){
        if(i != 0){
          if(i%2 == 0){
            widthOffset = 0.0;
            heightOffset += 100.0;
          }else{
            widthOffset += 100.0;
          }
        }
        layoutChild(i, BoxConstraints.loose(size));
        positionChild(i, Offset(widthOffset, heightOffset));
      }
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }

}
