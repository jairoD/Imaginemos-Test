import 'dart:convert';
import 'package:http/http.dart' as http;

class Credits {
  int cast_id;
  String character;
  String credit_id;
  int gender;
  int id;
  String name;
  int order;
  String profile_path;
  Credits({
    this.cast_id,
    this.character,
    this.credit_id,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profile_path,
  });

  Future getCredits(int movieId) async {
    var url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=780ebbc5bdedf5c2ed2f00a75d78a285';
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    var aux = data["cast"];
    return aux;
  }

  Future getDetails(int movieId) async {
    var url =
        'https://api.themoviedb.org/3/movie/$movieId?api_key=780ebbc5bdedf5c2ed2f00a75d78a285&language=en-US';
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  Credits copyWith({
    int cast_id,
    String character,
    String credit_id,
    int gender,
    int id,
    String name,
    int order,
    String profile_path,
  }) {
    return Credits(
      cast_id: cast_id ?? this.cast_id,
      character: character ?? this.character,
      credit_id: credit_id ?? this.credit_id,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      profile_path: profile_path ?? this.profile_path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cast_id': cast_id,
      'character': character,
      'credit_id': credit_id,
      'gender': gender,
      'id': id,
      'name': name,
      'order': order,
      'profile_path': profile_path,
    };
  }

  factory Credits.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Credits(
      cast_id: map['cast_id'],
      character: map['character'],
      credit_id: map['credit_id'],
      gender: map['gender'],
      id: map['id'],
      name: map['name'],
      order: map['order'],
      profile_path: map['profile_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Credits.fromJson(String source) =>
      Credits.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Credits(cast_id: $cast_id, character: $character, credit_id: $credit_id, gender: $gender, id: $id, name: $name, order: $order, profile_path: $profile_path)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Credits &&
        o.cast_id == cast_id &&
        o.character == character &&
        o.credit_id == credit_id &&
        o.gender == gender &&
        o.id == id &&
        o.name == name &&
        o.order == order &&
        o.profile_path == profile_path;
  }

  @override
  int get hashCode {
    return cast_id.hashCode ^
        character.hashCode ^
        credit_id.hashCode ^
        gender.hashCode ^
        id.hashCode ^
        name.hashCode ^
        order.hashCode ^
        profile_path.hashCode;
  }
}
