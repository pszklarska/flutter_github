import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/data/model/repo.dart';
import 'package:app/data/model/user.dart';
import 'package:app/util/constants.dart';

class RestManager {
  var httpClient = new HttpClient();

  Future<List<Repo>> loadRepositories() async {
    var decodedJSON = await _getDecodedJson(Constants.API_GET_REPO_URL);

    List<Repo> repoList = new List<Repo>();
    for (var repoJSON in decodedJSON) {
      repoList.add(Repo.fromJson(repoJSON));
    }

    return repoList;
  }

  Future<User> loadUser() async {
    var decodedJSON = await _getDecodedJson(Constants.API_GET_USER_URL);
    return User.fromJson(decodedJSON);
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
