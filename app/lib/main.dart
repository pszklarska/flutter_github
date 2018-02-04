import 'package:app/data/model/Repo.dart';
import 'package:app/data/rest_manager.dart';
import 'package:app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var restManager = new RestManager();

void main() {
  runApp(new FlutterGitHubApp());
}

class FlutterGitHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.APP_NAME,
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
        body: new FutureBuilder(
            future: restManager.loadRepositories(),
            builder: _buildWidgetFromRepoListState));
  }

  Widget _buildWidgetFromRepoListState(
      BuildContext context, AsyncSnapshot<List<Repo>> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return _buildProgress();
      default:
        if (snapshot.hasError) {
          return _buildError();
        } else {
          return _buildRepoList(context, snapshot);
        }
    }
  }

  Center _buildProgress() => new Center(child: new CircularProgressIndicator());

  Center _buildError() => new Center(child: new Icon(Icons.error));

  Widget _buildRepoList(
      BuildContext context, AsyncSnapshot<List<Repo>> snapshot) {
    List<Repo> repoList = snapshot.data;
    return new ListView.builder(
        itemBuilder: (context, index) =>
            _buildRepoTile(context, snapshot.data[index]),
        itemCount: repoList.length);
  }

  Widget _buildRepoTile(BuildContext context, Repo repo) {
    return new ListTile(
      title: new Text(repo.name),
      leading: new CircleAvatar(
        child: new Text(repo.language[0]),
      ),
    );
  }
}
