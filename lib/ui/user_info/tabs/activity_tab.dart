import 'package:app/data/model/event.dart';
import 'package:app/data/model/user.dart';
import 'package:app/data/rest_manager.dart';
import 'package:app/ui/event_list.dart';
import 'package:app/ui/user_info/tabs/profile_tab.dart';
import 'package:app/util/strings.dart';
import 'package:app/util/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityTab extends ProfileTab {
  final RestManager restManager;
  final User user;

  ActivityTab(this.restManager, this.user)
      : super(Strings.ACTIVITY_TAB, Icons.people);

  @override
  Widget build(BuildContext context) {
    return _createActionsListBuilder(restManager, user);
  }

  Widget _createActionsListBuilder(RestManager restManager, User user) {
    return new FutureBuilder(
        future: restManager.loadUserEvents(user.name),
        builder: handleActionsListState);
  }

  Widget handleActionsListState(
      BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
    List<Event> actionList = snapshot.data;
    return Widgets.returnWidgetOrEmpty(snapshot, () => _buildList(actionList));
  }

  Widget _buildList(List<Event> events) {
    return new ProfileEventList(events);
  }
}

class ProfileEventList extends EventList {
  ProfileEventList(List<Event> eventList) : super(eventList);

  @override
  String getTitle(String userName, Event event) {
    var title = super.getTitle("", event) + " on ${event.repo.name}";
    final trimmed = title.trimLeft();
    return trimmed;
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: buildEventTile, itemCount: eventList.length);
  }
}
