import 'package:app/data/model/repo.dart';
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
        body: new AppScreenBody());
  }
}

class AppScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: restManager.loadRepositories(),
        builder: (BuildContext context, AsyncSnapshot<List<Repo>> snapshot) {
          return new AppScreenList(snapshot);
        });
  }
}

class AppScreenList extends StatelessWidget {
  final AsyncSnapshot<List<Repo>> snapshot;

  AppScreenList(this.snapshot);

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return _buildProgress();
      default:
        if (snapshot.hasError) {
          return _buildError();
        } else {
          return new AppRepoList(snapshot.data);
        }
    }
  }

  Center _buildProgress() => new Center(child: new CircularProgressIndicator());

  Center _buildError() => new Center(child: new Icon(Icons.error));
}

class AppRepoList extends StatelessWidget {
  final List<Repo> repoList;

  AppRepoList(this.repoList);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: (context, index) => new AppRepoListTile(repoList[index]),
        itemCount: repoList.length);
  }
}

class AppRepoListTile extends StatelessWidget {
  final Repo repo;

  AppRepoListTile(this.repo);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(repo.name),
      subtitle: repo.description != null
          ? new Text(
              repo.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      leading: new CircleAvatar(
        child: new Text(repo.language[0]),
      ),
    );
  }
}
