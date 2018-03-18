import 'package:app/data/model/user.dart';
import 'package:app/data/rest_manager.dart';
import 'package:app/ui/user_info/tabs/activity_tab.dart';
import 'package:app/ui/user_info/tabs/info_tab.dart';
import 'package:app/ui/user_info/tabs/profile_tab.dart';
import 'package:app/ui/user_info/tabs/starred_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserInfoScreen extends StatelessWidget {

  final List<ProfileTab> tabs;
  final RestManager restManager;
  final User user;

  UserInfoScreen(this.restManager, this.user) : tabs = <ProfileTab>[
    new InfoTab(user),
    new ActivityTab(restManager, user),
    new StarredTab(user),
  ];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: tabs.length,
      child: new Scaffold(
          appBar: new AppBar(
              title: new Text(user.name)
          ),
          body: new Column(
            children: <Widget>[
              _buildUserHeader(),
              new Container(
                //TODO no ripple effect while color is set up bug
                  color: Colors.blue,
                  child: new TabBar(
                      tabs: tabs.map((ProfileTab profileTab) {
                        return new Tab(
                          text: profileTab.title,
                          icon: new Icon(profileTab.icon),
                        );
                      }).toList()
                  )
              ),
              new Expanded(
                  child: new TabBarView(
                    children: tabs.map((ProfileTab profileTab) {
                      return new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: profileTab,
                      );
                    }).toList(),
                  )
              ),
            ],
          )
      ),
    );
  }

  Widget _buildUserHeader() {
    return new Container(
        margin: new EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            new Center(
                child:
                new CircleAvatar(
                  radius: 40.0,
                  backgroundImage: new NetworkImage(user.avatarUrl),
                )
            ),
            new Padding(
                padding: new EdgeInsets.symmetric(vertical: 16.0),
                child: new Text(user.name, style: new TextStyle(fontSize: 25.0))
            ),
            new Text(user.login, style: new TextStyle(fontSize: 20.0)),

          ],
        )
    );
  }

}
