class Repo {
  final int id;
  final String name;

  const Repo(this.id, this.name);

  static fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Repo(json['id'], json['name']);
    }
  }
}
