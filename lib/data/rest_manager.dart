import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/data/model/event.dart';
import 'package:app/data/model/repo.dart';
import 'package:app/data/model/user.dart';
import 'package:app/util/constants.dart';

class RestManager {
  var httpClient = new HttpClient();

  Future<List<Repo>> loadRepositories() async {
    var decodedJSON = await _getDecodedJson(Constants.API_GET_REPOS_URL);

    List<Repo> repoList = new List<Repo>();
    for (var repoJSON in decodedJSON) {
      repoList.add(new Repo.fromJson(repoJSON));
    }

    return repoList;
  }

  Future<Repo> loadRepository(String repoName) async {
    var decodedJSON =
        await _getDecodedJson(Constants.API_GET_REPO_URL + repoName);
    return new Repo.fromJson(decodedJSON);
  }

  Future<User> loadUser() async {
    var decodedJSON = await _getDecodedJson(Constants.API_GET_USER_URL);
    return new User.fromJson(decodedJSON);
  }

  Future<List<Event>> loadRepoEvents(String repoName) async {
    var decodedJSON =
        await _getDecodedJson("/repos/pszklarska/$repoName/events");
    List<Event> eventList = new List<Event>();
    for (var eventJSON in decodedJSON) {
      eventList.add(new Event.fromJson(eventJSON));
    }

    return eventList;
  }

  Future<List<Event>> loadUserEvents(String userName) async {
    var decodedJSON = await _getDecodedJson("users/pszklarska/events");
    List<Event> eventList = new List<Event>();
    for (var actionJSON in decodedJSON) {
      eventList.add(new Event.fromJson(actionJSON));
    }

    return eventList;
  }

  Future<List<Repo>> loadUserStarredRepos(String userName) async {
    var decodedJSON = await _getDecodedJson("users/pszklarska/starred");
    List<Repo> repoList = new List<Repo>();
    for (var repoJSON in decodedJSON) {
      repoList.add(new Repo.fromJson(repoJSON));
    }

    return repoList;
  }

  Future _getDecodedJson(String path) async {
    var uri = new Uri.https(Constants.API_BASE_URL, path);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();
    var decoded = JSON.decode(json);
    return decoded;
  }
}
