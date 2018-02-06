import 'package:app/data/model/repo.dart';
import 'package:app/data/model/user.dart';
import 'package:app/data/rest_manager.dart';
import 'package:app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final RestManager restManager = new RestManager();

class HomeScreen extends StatelessWidget {
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
    return new Column(
      children: <Widget>[
        _buildProfileHeader(),
        new Divider(
          height: 3.0,
        ),
        _buildAppScreenList(),
      ],
    );
  }

  FutureBuilder<User> _buildProfileHeader() {
    return new FutureBuilder(
      future: restManager.loadUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        return new ProfileHeader(snapshot);
      },
    );
  }

  FutureBuilder<List<Repo>> _buildAppScreenList() {
    return new FutureBuilder(
        future: restManager.loadRepositories(),
        builder: (BuildContext context, AsyncSnapshot<List<Repo>> snapshot) {
          return new AppScreenList(snapshot);
        });
  }
}

class ProfileHeader extends StatelessWidget {
  final AsyncSnapshot<User> snapshot;

  ProfileHeader(this.snapshot);

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
      case ConnectionState.done:
        User user = snapshot.data;
        return _buildUserHeader(context, user);
      default:
        return new Container();
    }
  }

  Widget _buildUserHeader(BuildContext context, User user) {
    var avatarUrl = user.avatarUrl;

    return new Container(
      margin: new EdgeInsets.all(16.0),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            radius: 40.0,
            backgroundImage: new NetworkImage(avatarUrl),
          ),
          new Container(
            margin: new EdgeInsets.all(16.0),
            child: _buildProfileInfo(user, context),
          )
        ],
      ),
    );
  }

  Column _buildProfileInfo(User user, BuildContext context) {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            user.name,
            style: Theme.of(context).textTheme.headline,
          ),
          new Text(
            user.login,
            style: Theme.of(context).textTheme.subhead,
          ),
          new Row(
            children: <Widget>[
              new Icon(Icons.location_city),
              new Text(user.company)
            ],
          ),
          new Row(
            children: <Widget>[
              new Icon(Icons.location_on),
              new Text(user.location)
            ],
          )
        ]);
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
}

Center _buildProgress() => new Center(child: new CircularProgressIndicator());

Center _buildError() => new Center(child: new Icon(Icons.error));

class AppRepoList extends StatelessWidget {
  final List<Repo> repoList;

  AppRepoList(this.repoList);

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new ListView.builder(
          itemBuilder: (context, index) => new AppRepoListTile(repoList[index]),
          itemCount: repoList.length),
    );
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
      onTap: () => handleOnRepoTap(context, repo),
    );
  }

  void handleOnRepoTap(BuildContext context, Repo repo) {
    Navigator.pushNamed(context, '/repo/${repo.id}');
  }
}
