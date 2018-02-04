class User {
  final int id;
  final String login;
  final String name;
  final String avatarUrl;
  final String location;
  final String company;

  User(this.id, this.login, this.name, this.avatarUrl, this.location,
      this.company);

  static fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new User(json['id'], json['login'], json['name'],
          json['avatar_url'], json['location'], json['company']);
    }
  }
}
