import 'package:app/data/model/user.dart';

class Event {
  final EventType type;
  final User actor;
  final EventPayload payload;

  Event(this.type, this.actor, this.payload);

  factory Event.fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Event(
          getEventType(json['type']),
          new User.fromJson(json['actor']),
          new EventPayload.fromJson(json['payload']));
    }
  }
}

EventType getEventType(eventTypeJson) {
  return EventType.values.firstWhere((value) => equals(value, eventTypeJson),
      orElse: () => handleNoSuchEventType(eventTypeJson));
}

bool equals(EventType value, eventTypeJson) {
  return value.toString() == "EventType." + eventTypeJson;
}

EventType handleNoSuchEventType(eventTypeJson) {
  print("No such EventType: $eventTypeJson");
  return EventType.Unknown;
}

enum EventType {
  WatchEvent,
  PushEvent,
  PullRequestEvent,
  ForkEvent,
  IssueCommentEvent,
  Unknown
}

class EventPayload {
  final String action;
  final int number;

  EventPayload(this.action, this.number);

  factory EventPayload.fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new EventPayload(json['action'], json['number']);
    }
  }
}
