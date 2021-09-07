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
  var desiredPersonUID = "60013666";
  var _messages = <ListItem>[];

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

  changePersonToDeZhiDao() async {
    desiredPersonUID = "39806656";
    await loadData();
    var _ = BotToast.showText(text: "看看德指导说了啥",
        contentColor: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(8))); //弹出一个文本框;

  }

  changePersonToTlaoshi() async {
    desiredPersonUID = "60013666";
    await loadData();
     BotToast.showText(text: "看看T老师说了啥",
         contentColor: Colors.green,
         borderRadius: BorderRadius.all(Radius.circular(8))); //弹出一个文本框;
  }

  changePersonToFerngLiSu() async {
    desiredPersonUID = "63396125";
    await loadData();
     BotToast.showText(text: "看看凤梨酥说了啥",
         contentColor: Colors.green,
         borderRadius: BorderRadius.all(Radius.circular(8))); //弹出一个文本框;
  }

  changePersonToAns() async {
    desiredPersonUID = "7974389";
    await loadData();
    BotToast.showText(
        text: "看看A大说了啥",
        contentColor: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(8))); //弹出一个文本框;
  }

  loadData() async {
    var ngaPassportUid='41766312';
    var ngaPassportCid="Z8fp95hchil9f85mjso5fmh4nh9sb4pj84tjm8ju";

    var httpClient = HttpClient();
    String dataURL = "https://bbs.nga.cn/thread.php?searchpost=1&authorid=$desiredPersonUID&lite=js&page=1&noprefix";
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
    setState(() {
      _messages = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NGA大佬说了啥"),
        actions: [
          IconButton(
            tooltip: "此功能目前禁用",
            onPressed: null,
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: ListView(
        children: _getListData(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
}
