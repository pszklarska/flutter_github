import 'package:app/data/rest_manager.dart';
import 'package:app/ui/repo_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

void configureRoutes(Router router, RestManager restManager) {
  router.define('/repo/:repoName',
      handler: new Handler(handlerFunc: buildRepoHandler(restManager)));
}

HandlerFunc buildRepoHandler(RestManager restManager) {
  return (BuildContext context, Map<String, dynamic> params) =>
  new RepoScreen(restManager, params['repoName']);
}