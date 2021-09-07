// @dart=2.9
// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:convert';
import 'dart:io';

import 'package:fast_gbk/fast_gbk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cup;
import 'ngajson.dart';

import 'tool.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:myapp/aboutPage.dart' as myAbout;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: BotToastInit(), //1.调用BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
      home: DemoPage(),
    );
  }
}

class ListItem {
  ListItem(this.title, this.content) ;
  String title;
  String content;
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  var _allMessages=Map<String, List<ListItem>>();   //所有用户的发言，启动应用后初始化一次。
  var _allUsers=Map<String, String>();  //所有用户的表
  var _messages = <ListItem>[];   //临时容器，储存当前显示的列表
  var _loadedCount=0;  //读取完成一个人后加一，若所有人都读取完可以提示用户。

  _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < _messages.length * 2; i++) {
      if (i.isOdd) {
        widgets.add(Divider(
          color: Colors.pink,
        ));
      } else {
        final index = i ~/ 2;
        widgets.add(_buildRow(_messages[index]));
      }
    }
    return widgets;
  }

  Widget _buildRow(ListItem item) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: TextStyle(fontSize: 13.0, color: Colors.pink),
            //   style: _biggerFont,
          ),
          Divider(
            color: Colors.pink,

          ),
          Text(
            item.content,
          ),
        ],
      ),
    );
  }

  changePersonToDeZhiDao()  {
    setState(() {
      _messages=_allMessages['德指导'];
    });
    var _ = BotToast.showText(text: "看看德指导说了啥",
        contentColor: Colors.green); //弹出一个文本框;

  }

  changePersonToTlaoshi()  {
    setState(() {
      _messages=_allMessages['T老师'];
    });
     BotToast.showText(text: "看看T老师说了啥",
         contentColor: Colors.green); //弹出一个文本框;
  }

  changePersonToFerngLiSu()  {
    setState(() {
      _messages=_allMessages['凤梨酥'];
    });
     BotToast.showText(text: "看看凤梨酥说了啥",
         contentColor: Colors.green); //弹出一个文本框;
  }
  changePersonbyName(String name)  {
    setState(() {
      _messages=_allMessages[name];
    });
    BotToast.showText(text: "看看$name 说了啥",
        contentColor: Colors.green); //弹出一个文本框;
  }

  changePersonToAns()  {
    setState(() {
      _messages=_allMessages['Ans大'];
    });
    BotToast.showText(
        text: "看看A大说了啥",
        contentColor: Colors.green); //弹出一个文本框;
  }

  Future<List<ListItem>> loadData(String user) async {
    var ngaPassportUid='41766312';
    var ngaPassportCid="Z8fp95hchil9f85mjso5fmh4nh9sb4pj84tjm8ju";

    var httpClient = HttpClient();
    String dataURL = "https://bbs.nga.cn/thread.php?searchpost=1&authorid=$user&lite=js&page=1&noprefix";
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(dataURL));
    request.headers.add('cookie',
        'ngaPassportUid=$ngaPassportUid;ngaPassportCid=$ngaPassportCid');
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(gbk.decoder).join();
    Map userMap = json.decode(responseBody);
    var nj = new ngajson.fromJson(userMap);
    httpClient.close();

    var tempList = <ListItem>[];
    for (var item in nj.data.tT.messages) {
      tempList
          .add(new ListItem(item.subject, tool.FormatContent(item.pP.content)));
    }
    _loadedCount++;
    if(_loadedCount==_allUsers.length){
      BotToast.showText(text: "读取完成");
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {

    var b1=PopupMenuButton<String>(
      onSelected: (String result) {
        changePersonbyName(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: "凤梨酥",
          child: Text('凤梨酥'),
        ),
        const PopupMenuItem<String>(
          value: "T老师",
          child: Text("T老师"),
        ),
        const PopupMenuItem<String>(
          value: "德指导",
          child: Text("德指导"),
        ),
        const PopupMenuItem<String>(
          value: "Ans大",
          child: Text("Ans大"),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("NGA大佬说了啥"),
        actions: [

          IconButton(
            tooltip: "关于",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return myAbout.AboutPage();
              }
                  )
              );
              },
            icon: Icon(
              Icons.add,
            ),
          ),
          b1,
        ],
      ),
      body: ListView(
        children: _getListData(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            tooltip: "看看Ans大佬说了啥",
            onPressed: changePersonToAns,
            child: Icon(cup.CupertinoIcons.at_circle_fill),
            heroTag: "one",
          ),
          FloatingActionButton(
            tooltip: "看看德指导说了啥",
            onPressed: changePersonToDeZhiDao,
            child: Icon(cup.CupertinoIcons.dial),
            heroTag: "two",
          ),
          FloatingActionButton(
            tooltip: "看看T老师说了啥",
            onPressed: changePersonToTlaoshi,
            child: Icon(Icons.title),
            heroTag: "three",
          ),
          FloatingActionButton(
            tooltip: "看看凤梨酥说了啥",
            onPressed: changePersonToFerngLiSu,
            child: Icon(cup.CupertinoIcons.f_cursive_circle_fill),
            heroTag: "four",
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
   loaddAllMessage();
    super.initState();
  }

  void loaddAllMessage(){
    _allUsers['德指导']="39806656";
    _allUsers['T老师']="60013666";
    _allUsers['凤梨酥']="63396125";
    _allUsers['Ans大']="7974389";
    _allUsers.forEach((key, value) async {
      _allMessages[key]=await loadData(value);
    });
    BotToast.showText(text: "正在获取数据，请稍侯操作");
  }



}


// This is the type used by the popup menu below.
enum WhyFarther { harder, smarter, selfStarter, tradingCharter }