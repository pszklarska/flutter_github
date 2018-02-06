import 'package:app/ui/home_screen.dart';
import 'package:app/ui/routes.dart';
import 'package:app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluro/fluro.dart';

final Router router = new Router();

class FlutterGithubApp extends StatelessWidget {
  FlutterGithubApp() {
    configureRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.APP_NAME,
      home: new HomeScreen(),
      onGenerateRoute: router.generator,
    );
  }
}
