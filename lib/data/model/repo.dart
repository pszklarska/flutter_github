class Repo {
  final int id;
  final String name;
  final String language;
  final String description;
  final int watchers;
  final int forksCount;
  final int openIssuesCount;

  const Repo(this.id, this.name, this.language, this.description, this.watchers,
      this.forksCount, this.openIssuesCount);

  static fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Repo(
          json['id'],
          json['name'],
          json['language'],
          json['description'],
          json['watchers'],
          json['forks_count'],
          json['open_issues_count']);
    }
  }
}
