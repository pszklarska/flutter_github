import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Widgets {
  static Widget returnWidgetOrEmpty(
      AsyncSnapshot snapshot, Widget buildWidget()) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return new Container();
      default:
        if (!snapshot.hasError) {
          return buildWidget();
        } else {
          return new Container();
        }
    }
  }
}
