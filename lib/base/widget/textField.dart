import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/*
 * 实现原理：
 * 使用FocusNode获取当前textField焦点
 * 在TextNode的textInputAction属性中选择键盘action（next/down）
 * 对于最后一个之前的TextField：在onSubmitted属性中解除当前focus状态
 * 再聚焦下一个FocusNode:FocusScope.of(context).requestFocus( nextFocusNode );
 * 对于最后一个TextField,直接解除focus并提交表单
* */
class TextFieldWidget{
  Widget build(){
    return  TextFieldFocus();
  }
}

class TextFieldFocus extends StatefulWidget {
  @override
  _TextFieldFocusState createState() => _TextFieldFocusState();
}

class _TextFieldFocusState extends State<TextFieldFocus> {
  TextEditingController _nameController,_pwController;
  FocusNode _nameFocus,_pwFocus;
  String name, password;

  @override
  void initState() {
    _nameController = TextEditingController();
    _pwController = TextEditingController();
    _nameController.text="hello world!";
    _nameController.selection = TextSelection(baseOffset: 2, extentOffset: _nameController.text.length);
    _nameFocus = FocusNode();
    _pwFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose(){
    _nameController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
          children: <Widget>[
            const SizedBox(height: 80.0),
            Center(
              child: Text('Login',style: TextStyle(
                  fontSize: 32.0
              ),),
            ),
            const SizedBox(height: 80.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                child: TextField(
                  focusNode: _nameFocus,
                  controller: _nameController,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  //最多字数限制
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  //只能输入数字
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  onSubmitted: (input){
                    _nameFocus.unfocus();
                    FocusScope.of(context).requestFocus(_pwFocus);
                  },
                  decoration: InputDecoration(
                    labelText: "name",
                  ),
                  onChanged: (v){
                    name = v;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                child: TextField(
                  focusNode: _pwFocus,
                  controller: _pwController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (input){
                    _pwFocus.unfocus();
                    //登陆请求
                  },
                  decoration: InputDecoration(
                    labelText: "password",
                  ),
                  onChanged: (v){
                    password = v;
                  },
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            ButtonBar(
              children: <Widget>[
                RaisedButton(onPressed: (){showTips();},child: Text('login'),color: Colors.white,)
              ],
            )
          ],
        );
  }

  showTips() {
    String tip;
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          tip = "账号为$name，密码为$password";
          return new Container(
              child: new Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: new Text(tip,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 16.0
                       )
                  )
              )
          );
        });
  }
}


