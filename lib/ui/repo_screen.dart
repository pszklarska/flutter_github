import 'package:app/data/model/event.dart';
import 'package:app/data/model/repo.dart';
import 'package:app/data/rest_manager.dart';
import 'package:app/ui/event_list.dart';
import 'package:app/util/strings.dart';
import 'package:app/util/widgets.dart';
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
    Repo repo = snapshot.data;
    return Widgets.returnWidgetOrEmpty(snapshot, () => _buildRepoHeader(repo));
  }

  Widget _buildRepoHeader(Repo repo) {
    return new Container(
      margin: new EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          _buildRepoDescription(repo),
          _buildRepoStats(repo),
          new Divider(),
          _createRepoEventsListBuilder()
        ],
      ),
    );
  }

  Widget _buildRepoDescription(Repo repo) {
    return new Text(
      repo.description,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRepoStats(Repo repo) {
    return new Padding(
      padding: new EdgeInsets.only(top: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new HeaderItem("${repo.watchers}\n" + Strings.WATCHERS),
          new HeaderItem("${repo.openIssuesCount}\n" + Strings.OPEN_ISSUES),
          new HeaderItem("${repo.forksCount}\n" + Strings.FORKS),
        ],
      ),
    );
  }

  Widget _createRepoEventsListBuilder() {
    return new FutureBuilder(
        future: restManager.loadEvents(repoName),
        builder: handleRepoEventsListState);
  }

  Widget handleRepoEventsListState(
      BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
    List<Event> eventList = snapshot.data;
    return Widgets.returnWidgetOrEmpty(snapshot, () => _buildList(eventList));
  }

  Widget _buildList(List<Event> eventList) {
    return new EventList(eventList);
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
