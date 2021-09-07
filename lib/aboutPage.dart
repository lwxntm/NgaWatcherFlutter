import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
    title: "关于页面",
      home: AboutPageContent(),
    );
  }
}

class AboutPageContent extends StatelessWidget {
  const AboutPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading:  null,
        middle: Text("关于页面"),
      ),
      child: Container(child: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("无聊的人写的无聊程序"),
        ],)
      ),
      ),
    );
  }
}
