import 'package:app/data/model/repo.dart';
import 'package:app/data/model/user.dart';
import 'package:app/data/rest_manager.dart';
import 'package:app/ui/user_info/user_info_screen.dart';
import 'package:app/util/strings.dart';
import 'package:app/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  final RestManager restManager;

  HomeScreen(this.restManager);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(Strings.APP_NAME),
        ),
        body: _buildAppScreenBody());
  }

  Widget _buildAppScreenBody() {
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
        return new ProfileHeader(snapshot, restManager);
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
  final RestManager restManager;

  ProfileHeader(this.snapshot, this.restManager);

  @override
  Widget build(BuildContext context) {
    User user = snapshot.data;
    return Widgets.returnWidgetOrEmpty(
        snapshot, () => _buildUserHeader(context, user));
  }

  Widget _buildUserHeader(BuildContext context, User user) {
    var avatarUrl = user.avatarUrl;

    return new Container(
      margin: new EdgeInsets.all(16.0),
      child: new GestureDetector(
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
        onTap: () => handleOnUserTap(context, user),
      ),
    );
  }

  void handleOnUserTap(BuildContext context, User user) {
    Navigator.push(context,
        new MaterialPageRoute(
            builder: (_) => new UserInfoScreen (restManager, user)));
  }

  Column _buildProfileInfo(User user, BuildContext context) {
    List<Widget> headerItems = new List();
    buildHeaderTextItem(user.name, headerItems, context);
    buildHeaderTextItem(user.login, headerItems, context);
    buildHeaderIconTextItem(
        user.company, Icons.location_city, headerItems, context);
    buildHeaderIconTextItem(
        user.location, Icons.location_on, headerItems, context);

    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: headerItems);
  }

  void buildHeaderTextItem(String text, List<Widget> headerItems,
      BuildContext context) {
    if (text != null) {
      headerItems.add(new Text(
        text,
        style: Theme
            .of(context)
            .textTheme
            .headline,
      ));
    }
  }

  void buildHeaderIconTextItem(String text, IconData icon,
      List<Widget> headerItems, BuildContext context) {
    if (text != null) {
      headerItems.add(new Row(
        children: <Widget>[new Icon(icon), new Text(text)],
      ));
    }
  }
}

class AppScreenList extends StatelessWidget {
  final AsyncSnapshot<List<Repo>> snapshot;

  AppScreenList(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Widgets.returnWidgetOrEmpty(
        snapshot, () => new AppRepoList(snapshot.data));
  }
}

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
    Navigator.pushNamed(context, '/repo/${repo.name}');
  }
}
