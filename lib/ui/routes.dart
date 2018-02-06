import 'package:app/ui/repo_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

void configureRoutes(Router router) {
  router.define('/repo/:repoId', handler: new Handler(handlerFunc: buildRepoHandler()));
}

HandlerFunc buildRepoHandler() {
  return (BuildContext context, Map<String, dynamic> params) =>
      new RepoScreen(params['repoId']);
}
