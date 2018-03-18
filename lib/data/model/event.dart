import 'package:app/data/model/user.dart';

class Event {
  final EventType type;
  final User actor;
  final EventPayload payload;
  final EventRepo repo;

  Event(this.type, this.actor, this.payload, this.repo);

  factory Event.fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Event(
          getEventType(json['type']),
          new User.fromJson(json['actor']),
          new EventPayload.fromJson(json['payload']),
          new EventRepo.fromJson(json['repo'])
      );
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
  CreateEvent,
  Unknown
}

class EventPayload {
  final String action;
  final int size;
  final String refType;

  EventPayload(this.action, this.size, this.refType);

  factory EventPayload.fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new EventPayload(json['action'], json['size'], json['ref_type']);
    }
  }
}

class EventRepo {
  final String url;
  final String name;

  EventRepo(this.url, this.name);

  factory EventRepo.fromJson(json){
    if (json == null) {
      return null;
    } else {
      return new EventRepo(json['url'], json['name']);
    }
  }
}
