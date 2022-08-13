import 'dart:convert';

class OverallResp {
    OverallResp({
        required this.results,
    });

    List<Movie> results;

    factory OverallResp.fromRawJson(String str) => OverallResp.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OverallResp.fromJson(Map<String, dynamic> json) => OverallResp(
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}
class Movie {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  int id;
  String? originalTitle;
  String? overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  double voteAverage;
  int voteCount;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
