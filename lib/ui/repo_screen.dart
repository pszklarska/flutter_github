import 'package:app/data/model/repo.dart';
import 'package:app/data/rest_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class RepoScreen extends StatelessWidget {
  final RestManager restManager;
  final String repoName;

  RepoScreen(this.restManager, this.repoName);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("$repoName"),
        ),
        body: new FutureBuilder(
            future: restManager.loadRepository(repoName),
            builder: _buildAppScreenBody));
  }

  Widget _buildAppScreenBody(
      BuildContext context, AsyncSnapshot<Repo> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
      case ConnectionState.done:
        Repo repo = snapshot.data;
        return _buildRepoHeader(repo);
      default:
        return new Container();
    }
  }

  Widget _buildRepoHeader(Repo repo) {
    return new Container(
      margin: new EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new Text(repo.description, textAlign: TextAlign.center,),
          new Padding(
            padding: new EdgeInsets.only(top: 16.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new HeaderItem("${repo.watchers}\nwatchers"),
                new HeaderItem("${repo.openIssuesCount}\nopen issues"),
                new HeaderItem("${repo.forksCount}\nforks"),
              ],
            ),
          ),
          new Divider(),

        ],
      ),
    );
  }
}

class HeaderItem extends StatelessWidget {
  final String repoInfo;

  HeaderItem(this.repoInfo);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      child: new Text(
        repoInfo,
        textAlign: TextAlign.center,
      ),
      padding: new EdgeInsets.all(8.0),
    );
  }
}
