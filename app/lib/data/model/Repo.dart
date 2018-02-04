class Repo {
  final int id;
  final String name;
  final String language;
  final String description;

  const Repo(this.id, this.name, this.language, this.description);

  static fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Repo(
          json['id'], json['name'], json['language'], json['description']);
    }
  }
}
