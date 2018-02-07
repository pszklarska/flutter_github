import 'package:app/data/rest_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class RepoScreen extends StatelessWidget {
  final RestManager restManager;
  final String repoId;

  RepoScreen(this.restManager, this.repoId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("$repoId"),
        ),
        body: new Container());
  }
}
