import 'package:app/data/model/event.dart';
import 'package:app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventList extends StatelessWidget {
  final List<Event> eventList;

  EventList(this.eventList);

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new ListView.builder(
          itemBuilder: buildEventTile, itemCount: eventList.length),
    );
  }

  Widget buildEventTile(BuildContext context, int index) {
    Event event = eventList[index];
    return new Column(children: <Widget>[
      new ListTile(
          leading: new Icon(getIcon(event)),
          title: new Text(getTitle(event.actor.login, event))),
      new Divider()
    ]);
  }

  IconData getIcon(Event event) {
    switch (event.type) {
      case EventType.ForkEvent:
        return Icons.share;
      case EventType.IssueCommentEvent:
        return Icons.comment;
      case EventType.PullRequestEvent:
        return Icons.create_new_folder;
      case EventType.PushEvent:
        return Icons.cloud_upload;
      case EventType.WatchEvent:
        return Icons.remove_red_eye;
      case EventType.CreateEvent:
        return Icons.create;
      case EventType.Unknown:
      default:
        return Icons.bug_report;
    }
  }

  String getTitle(String actorName, Event event) {
    switch (event.type) {
      case EventType.ForkEvent:
        return "$actorName "
            "${Strings.FORKED_REPO}";
      case EventType.IssueCommentEvent:
        return "$actorName "
            "${event.payload.action} "
            "${Strings.COMMENT}";
      case EventType.PullRequestEvent:
        return "$actorName "
            "${event.payload.action} "
            "${Strings.PULL_REQUEST}";
      case EventType.PushEvent:
        return "$actorName "
            "${Strings.PUSHED} "
            "${event.payload.size} "
            "${Strings.COMMITS}";
      case EventType.WatchEvent:
        return "$actorName "
            "${event.payload.action} "
            "${Strings.WATCHING_REPO}";
      case EventType.CreateEvent:
        return "$actorName "
            "${Strings.CREATED} "
            "${event.payload.refType} ";
      case EventType.Unknown:
      default:
        return "";
    }
  }
}
