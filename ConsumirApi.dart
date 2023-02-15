import 'dart:convert';
import 'package:http/http.dart' as http;

void main(List<String> args) async {
  String host = "api.chucknorris.io";
  String path = "/jokes/random";

  List<Jokes> ChuckJokes = [];

  getJoke(host, path).then((result) {
    String body = result.body;
    var resultJson = jsonDecode(body);
    //print(resultJson);

    for (var i = 0; i < 50; i++) {
      ChuckJokes.add(Jokes.fromJson(resultJson));
    }
    print(ChuckJokes);
  });
}

Future<http.Response> getJoke(String host, String path) async {
  Uri url = Uri.http(host, path);
  var result = await http.get(url);
  return result;
}

//
class Jokes {
  late var categories;
  late String created_at;
  late String icon_url;
  late String id;
  late String updated_at;
  late String url;
  late String value;

  Jokes.fromJson(Map<String, dynamic> json) {
    this.categories = json["categories"];
    this.created_at = json["created_at"];
    this.icon_url = json["icon_url"];
    this.id = json["id"];
    this.updated_at = json["updated_at"];
    this.url = json["url"];
    this.value = json["value"];
  }

}
