import 'package:app/data/model/user.dart';
import 'package:app/ui/user_info/tabs/profile_tab.dart';
import 'package:app/util/constants.dart';
import 'package:app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Widget build(BuildContext context) {
    debugPrint(user.toString());
    return new ListView.builder(
        itemBuilder: (context, index) => profileItems[index],
        itemCount: profileItems.length
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