

import 'dart:convert';
import 'package:http/http.dart' as http;

class ChuckNorrisJoke {
  late var categories;
  late String created_at;
  late String icon_url;
  late String id;
  late String updated_at;
  late String url;
  late String value;

  ChuckNorrisJoke.fromJson(Map<String, dynamic> json) {
    this.categories = json["categories"];
    this.created_at = json["created_at"];
    this.icon_url = json["icon_url"];
    this.id = json["id"];
    this.updated_at = json["updated_at"];
    this.url = json["url"];
    this.value = json["value"];
  }

  @override
  String toString() {
    return "\n $categories, $created_at, $icon_url, $id, $updated_at, $url, $value \n";
  }
}

void main() async {
  final List<ChuckNorrisJoke> jokes = [];

  for (int i = 0; i < 50; i++) {
    final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
    final Map<String, dynamic> json = jsonDecode(response.body);
    final joke = ChuckNorrisJoke.fromJson(json);
    jokes.add(joke);
  }

  print(jokes);
  print('Total jokes: ${jokes.length}');
}











