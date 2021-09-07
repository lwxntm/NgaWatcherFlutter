// @dart=2.9
// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:convert';
import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:fast_gbk/fast_gbk.dart';
import 'package:flutter/material.dart';
import 'ngajson.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'tool.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DemoPage(),
    );
  }
}

class ListItem {
  ListItem(String title, String content) {
    this.title = title;
    this.content = content;
  }

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
        widgets.add(Divider());
      } else {
        final index = i ~/ 2;
        widgets.add(_buildRow(_messages[index]));
      }
    }
    return widgets;
  }

  Widget _buildMessages() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider();
          /*2*/
          final index = i ~/ 2; /*3*/
          // if (index >= _suggestions.length) {
          //   _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          // }
          return _buildRow(_messages[index]);
        });
  }

  Widget _buildRow(ListItem item) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: TextStyle(fontSize: 18.0, color: Colors.pink),
            //   style: _biggerFont,
          ),
          Text(
            item.content,
            //   style: _biggerFont,
          ),
        ],
      ),
    );
  }

  changePersonToDeZhiDao() async {
    desiredPersonUID = "39806656";
    await loadData();
  }

  changePersonToTlaoshi() async {
    desiredPersonUID = "60013666";
    await loadData();
  }

  changePersonToFerngLiSu() async {
    desiredPersonUID = "63396125";
    await loadData();
  }

  changePersonToAns() async {
    desiredPersonUID = "7974389";
    await loadData();
  }

  loadData() async {
    var httpClient = HttpClient();
    var headers = new Map<String, String>();
    headers['cookie'] =
        'ngaPassportUid=41766312;ngaPassportCid=Z8fp95hchil9f85mjso5fmh4nh9sb4pj84tjm8ju';
    String dataURL = "https://bbs.nga.cn/thread.php?searchpost=1&authorid=" +
        desiredPersonUID +
        "&lite=js&page=1&noprefix";
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(dataURL));
    request.headers.add('cookie',
        'ngaPassportUid=41766312;ngaPassportCid=Z8fp95hchil9f85mjso5fmh4nh9sb4pj84tjm8ju');
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(gbk.decoder).join();
    print(responseBody);
    Map userMap = json.decode(responseBody);
    var nj = new ngajson.fromJson(userMap);
    httpClient.close();
    setState(() {
      _messages.clear();
      _messages.add(new ListItem(
          nj.data.tT.message0.subject, tool.FormatContent(nj.data.tT.message0.pP.content) ));
      _messages.add(new ListItem(
          nj.data.tT.message1.subject, tool.FormatContent(nj.data.tT.message1.pP.content)));
      _messages.add(new ListItem(
          nj.data.tT.message2.subject, tool.FormatContent(nj.data.tT.message2.pP.content)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NGA大佬说了啥"),
        actions: [
          FloatingActionButton(
            tooltip: "看看Ans大佬说了啥",
            onPressed: changePersonToAns,
            child: Icon(Icons.whatshot_rounded,),
          ),
          FloatingActionButton(
            tooltip: "看看德指导说了啥",
            onPressed: changePersonToDeZhiDao,
            child: Icon(Icons.wb_incandescent_outlined),
          ),
          FloatingActionButton(
            tooltip: "看看T老师说了啥",
            onPressed: changePersonToTlaoshi,
            child: Icon(Icons.title),
          ),
          FloatingActionButton(
            tooltip: "看看凤梨酥说了啥",
            onPressed: changePersonToFerngLiSu,
            child: Icon(Icons.flight_takeoff_rounded),
          ),
        ],
      ),
      body: ListView(
        children: _getListData(),
      ),

    );
  }
}
