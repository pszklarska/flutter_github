import 'package:app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(new FlutterGitHubApp());
}

class FlutterGitHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "FlutterGitHubApp",
      home: new AppScreen(),
    );
  }
}

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(Strings.APP_NAME),
        ),
        body: new ListView.builder(itemBuilder: _buildRepoTile, itemCount: 10));
  }

  Widget _buildRepoTile(BuildContext context, int index) {
    return new ListTile(title: new Text("Number of row: $index"));
  }
}
