import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Movie {
  double popularity;
  int vote_count;
  bool video;
  String poster_path;
  int id;
  bool adult;
  String backdrop_path;
  String original_language;
  String original_title;
  List<int> genre_ids;
  String title;
  double vote_average;
  String overview;
  String release_date;
  Movie({
    this.popularity,
    this.vote_count,
    this.video,
    this.poster_path,
    this.id,
    this.adult,
    this.backdrop_path,
    this.original_language,
    this.original_title,
    this.genre_ids,
    this.title,
    this.vote_average,
    this.overview,
    this.release_date,
  });

  Future getTopRated() async {
    var url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=780ebbc5bdedf5c2ed2f00a75d78a285&language=en-US&page=1';
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    var aux = data["results"];
    return aux;
  }

  Future getRecommendation() async {
    var url =
        'https://api.themoviedb.org/3/movie/592350/recommendations?api_key=780ebbc5bdedf5c2ed2f00a75d78a285&language=en-US&page=1';
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    var aux = data["results"];
    return aux;
  }

  Movie copyWith({
    double popularity,
    int vote_count,
    bool video,
    String poster_path,
    int id,
    bool adult,
    String backdrop_path,
    String original_language,
    String original_title,
    List<int> genre_ids,
    String title,
    double vote_average,
    String overview,
    String release_date,
  }) {
    return Movie(
      popularity: popularity ?? this.popularity,
      vote_count: vote_count ?? this.vote_count,
      video: video ?? this.video,
      poster_path: poster_path ?? this.poster_path,
      id: id ?? this.id,
      adult: adult ?? this.adult,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      original_language: original_language ?? this.original_language,
      original_title: original_title ?? this.original_title,
      genre_ids: genre_ids ?? this.genre_ids,
      title: title ?? this.title,
      vote_average: vote_average ?? this.vote_average,
      overview: overview ?? this.overview,
      release_date: release_date ?? this.release_date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'popularity': popularity,
      'vote_count': vote_count,
      'video': video,
      'poster_path': poster_path,
      'id': id,
      'adult': adult,
      'backdrop_path': backdrop_path,
      'original_language': original_language,
      'original_title': original_title,
      'genre_ids': genre_ids,
      'title': title,
      'vote_average': vote_average,
      'overview': overview,
      'release_date': release_date,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Movie(
      popularity: map['popularity'].toDouble(),
      vote_count: map['vote_count'],
      video: map['video'],
      poster_path: map['poster_path'],
      id: map['id'],
      adult: map['adult'],
      backdrop_path: map['backdrop_path'],
      original_language: map['original_language'],
      original_title: map['original_title'],
      genre_ids: List<int>.from(map['genre_ids']),
      title: map['title'],
      vote_average: map['vote_average'].toDouble(),
      overview: map['overview'],
      release_date: map['release_date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(popularity: $popularity, vote_count: $vote_count, video: $video, poster_path: $poster_path, id: $id, adult: $adult, backdrop_path: $backdrop_path, original_language: $original_language, original_title: $original_title, genre_ids: $genre_ids, title: $title, vote_average: $vote_average, overview: $overview, release_date: $release_date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Movie &&
        o.popularity == popularity &&
        o.vote_count == vote_count &&
        o.video == video &&
        o.poster_path == poster_path &&
        o.id == id &&
        o.adult == adult &&
        o.backdrop_path == backdrop_path &&
        o.original_language == original_language &&
        o.original_title == original_title &&
        listEquals(o.genre_ids, genre_ids) &&
        o.title == title &&
        o.vote_average == vote_average &&
        o.overview == overview &&
        o.release_date == release_date;
  }

  @override
  int get hashCode {
    return popularity.hashCode ^
        vote_count.hashCode ^
        video.hashCode ^
        poster_path.hashCode ^
        id.hashCode ^
        adult.hashCode ^
        backdrop_path.hashCode ^
        original_language.hashCode ^
        original_title.hashCode ^
        genre_ids.hashCode ^
        title.hashCode ^
        vote_average.hashCode ^
        overview.hashCode ^
        release_date.hashCode;
  }
}
