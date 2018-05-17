import 'package:app/data/model/repo.dart';
import 'package:app/data/model/user.dart';
import 'package:app/data/rest_manager.dart';
import 'package:app/ui/app_repo_list.dart';
import 'package:app/ui/user_info/tabs/profile_tab.dart';
import 'package:app/util/strings.dart';
import 'package:app/util/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarredTab extends ProfileTab {
  final RestManager restManager;
  final User user;

  StarredTab(this.restManager, this.user)
      : super(Strings.STARRED_TAB, Icons.star);

  @override
  Widget build(BuildContext context) {
    return _createStarredReposListBuilder(restManager, user);
  }

  Widget _createStarredReposListBuilder(RestManager restManager, User user) {
    return new FutureBuilder(
        future: restManager.loadUserStarredRepos(user.name),
        builder: handleReposListState);
  }

  Widget handleReposListState(
      BuildContext context, AsyncSnapshot<List<Repo>> snapshot) {
    List<Repo> actionList = snapshot.data;
    return Widgets.returnWidgetOrEmpty(snapshot, () => _buildList(actionList));
  }

  Widget _buildList(List<Repo> repos) {
    return new StarredReposList(repos);
  }
}

class StarredReposList extends AppRepoList {
  StarredReposList(List<Repo> repoList) : super(repoList);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: buildRepoTile, itemCount: repoList.length);
  }
}
