import 'package:app/data/model/user.dart';
import 'package:app/util/constants.dart';
import 'package:app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoScreen extends StatelessWidget {

  final User user;
  final List<ProfileTab> tabs;

  UserInfoScreen(this.user) : tabs = <ProfileTab>[
    new InfoTab(user),
    new ActivityTab(user),
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
                        child: profileTab._buildTabView(),
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

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class ProfileItem extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;
  final Function onClickFunction;

  ProfileItem(this.title, this.subtitle, this.icon, {this.onClickFunction});

  @override
  Widget build(BuildContext context) {
    if (title == null || title.isEmpty) return new Container();
    return new Card(
      child: new ListTile(
        title: new Text(title),
        subtitle: new Text(subtitle),
        leading: new Icon(icon),
        onTap: onClickFunction,
      ),
    );
  }
}

abstract class ProfileTab {
  final String title;
  final IconData icon;

  ProfileTab(this.title, this.icon);

  Widget _buildTabView();
}

class InfoTab extends ProfileTab {

  final User user;
  final List profileItems;

  InfoTab(this.user)
      : profileItems = <ProfileItem>[
    new ProfileItem(user.email, Strings.EMAIL, Icons.email),
    new ProfileItem(user.blog, Strings.BLOG, Icons.comment,
        onClickFunction: () => _launchURL(user.blog)),
    new ProfileItem(user.location, Strings.LOCATION, Icons.location_on,
        onClickFunction: () => _launchURL(Constants.MAP_QUERY + user.location)),
    new ProfileItem(user.company, Strings.WORK, Icons.account_balance),
  ],
        super(Strings.INFO_TAB, Icons.info);

  @override
  Widget _buildTabView() {
    debugPrint(user.toString());
    return new ListView.builder(
        itemBuilder: (context, index) => profileItems[index],
        itemCount: profileItems.length
    );
  }
}

class ActivityTab extends ProfileTab {

  final User user;

  ActivityTab(this.user) : super(Strings.ACTIVITY_TAB, Icons.people);

  @override
  Widget _buildTabView() {
    return new Text("TODO: User's activity list");
  }
}

class StarredTab extends ProfileTab {
  final User user;

  StarredTab(this.user) : super(Strings.STARRED_TAB, Icons.star);

  @override
  Widget _buildTabView() {
    return new Text("TODO: Starred repos list");
  }
}