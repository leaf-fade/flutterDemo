import 'dart:_http';

import 'dart:convert';

abstract class Callback{
  void onSuccess(result);
  void onFail(error);
}

class HttpCallBack{
  Function success;
  Function fail;
  HttpCallBack(this.success,this.fail);
}

httpConnect(String url,HttpCallBack callback) async {
  HttpClient httpClient = HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  if(response.statusCode == 200){
    var text = await response.transform(utf8.decoder).join();
    //callback.onSuccess(text);
    callback.success.call(text);
  }else{
    //callback.onFail("http请求失败");
    callback.fail.call("http请求失败");
  }
  httpClient.close();
}