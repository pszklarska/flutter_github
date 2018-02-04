class Repo {
  final int id;
  final String name;
  final String language;

  const Repo(this.id, this.name, this.language);

  static fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Repo(json['id'], json['name'], json['language']);
    }
  }
}
