import 'package:app/data/model/user.dart';
import 'package:app/ui/user_info/tabs/profile_tab.dart';
import 'package:app/util/strings.dart';
import 'package:flutter/material.dart';


class StarredTab extends ProfileTab {
  final User user;

  StarredTab(this.user) : super(Strings.STARRED_TAB, Icons.star);

  @override
  Widget build(BuildContext context) {
    return new Text("TODO: Starred repos list");
  }
}