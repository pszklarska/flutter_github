import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/data/model/Repo.dart';

class RestManager {
  var httpClient = new HttpClient();

  Future<List<Repo>> loadRepositories() async {
    var uri =
        new Uri.https("api.github.com", "/users/pszklarska/repos");
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var json = await response.transform(UTF8.decoder).join();
    var decoded = JSON.decode(json);

    List<Repo> repoList = new List<Repo>();
    for (var repoJSON in decoded) {
      repoList.add(Repo.fromJson(repoJSON));
    }

    return repoList;
  }
}
