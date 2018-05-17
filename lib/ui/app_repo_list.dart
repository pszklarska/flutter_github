import 'package:app/data/model/repo.dart';
import 'package:flutter/material.dart';

class AppRepoList extends StatelessWidget {
  final List<Repo> repoList;

  AppRepoList(this.repoList);

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new ListView.builder(
          itemBuilder: buildRepoTile, itemCount: repoList.length),
    );
  }

  Widget buildRepoTile(BuildContext context, int index) {
    Repo repo = repoList[index];
    return new AppRepoListTile(repo);
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
        child: new Text(repo.language != null ? repo.language[0] : "?"),
      ),
      onTap: () => handleOnRepoTap(context, repo),
    );
  }

  void handleOnRepoTap(BuildContext context, Repo repo) {
    Navigator.pushNamed(context, '/repo/${repo.name}');
  }
}
